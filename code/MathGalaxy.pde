class MathGalaxy
{

  private int density;

  private float galaxyRadius;
  private float maxRadius;
  private PVector range;

  private ArrayList<GalaxyPoint> galaxyPoints;

  /* Constructor definition */
  public MathGalaxy(int density)
  {
    this.density = density;

    /*
     * The galaxyRadius parameter, determines the
     * distance of the camera from the center
     * of the galaxy. The bigger the distance,
     * the further it will be.
     */
    this.galaxyRadius = 15 * TAU;

    /*
     * Incrementing the spread fractor,
     * causes the points near the center
     * of the galaxy to spread further away
     * from it.
     */
    var phi = (1 + sqrt(5)) / 2;
    var e = 2 + 1f/2 + 1f/6 +
      1f/24 + 1f/120 + 1f/720;
    var spreadFactor = phi * PI;
    this.maxRadius = spreadFactor / e;

    /*
     * Parametrizing the range of the
     * [x, y, z] axes, alters the shape
     * of the galaxy's inner nucleus.
     * Some examples, are given below:
     *
     * --> [PI / 2, PI / 12, PI / 2]
     * --> [PI / 2, PI / 2, PI / 2]
     * --> [PI / 3, PI / 3, PI / 3]
     * --> [PI / 5, phi * PI, PI / 5]
     */
    var rX = PI / 2;
    var rY = PI / 2;
    var rZ = PI / 2;
    this.range = new PVector(rX, rY, rZ);

    this.createGalaxy();
  }

  /* Function definition */
  private void createGalaxy()
  {
    this.galaxyPoints = new ArrayList<GalaxyPoint>();
    var maxIteration = floor(3 * this.density);

    for (int x = 0; x < this.density; x++)
    {
      for (int y = 0; y < this.density; y++)
      {
        for (int z = 0; z < this.density; z++)
        {
          var posX = map(x, 0, this.density, -this.range.x, this.range.x);
          var posY = map(y, 0, this.density, -this.range.y, this.range.y);
          var posZ = map(z, 0, this.density, -this.range.z, this.range.z);
          var position = new PVector(posX, posY, posZ);

          var radius = 0f;
          var iteration = 0;
          var initialV = position.copy();
          for (int k = 0; k < maxIteration; k++)
          {
            var sphericalV = new Spherical(position.copy());
            var isPointOutsideOfGalaxy = (sphericalV.rho > this.maxRadius);
            if (isPointOutsideOfGalaxy) break;

            position = sphericalV.get3DPosition(initialV);
            radius = sphericalV.rho;
            iteration = k;
          }

          this.addGalaxyPoint(position, radius, iteration);
        }
      }
    }
  }

  private void addGalaxyPoint(PVector position,
    float radius, int iteration)
  {
    var isPointInsideOfGalaxy = (radius < this.maxRadius);
    if (isPointInsideOfGalaxy)
    {     
      var noiseValue = noise(radius % iteration);
      var hue = map(noiseValue, 0, 1, 0, 360);
      var newPosition = position.copy();
      newPosition.mult(this.galaxyRadius);

      this.galaxyPoints.add(new GalaxyPoint(newPosition, hue));
    }
  }

  public void render()
  {
    if (this.galaxyPoints != null)
    {
      for (var galaxyPoint : this.galaxyPoints)
        galaxyPoint.render();
    }
  }
}
