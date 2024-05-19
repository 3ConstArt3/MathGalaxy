class Spherical
{

  private float rho;
  private float theta;
  private float phi;

  /* Constructor definition */
  public Spherical(PVector vector)
  {
    this.rho = 0f;
    this.theta = 0f;
    this.phi = 0f;

    this.convertToSpherical(vector);
  }

  /* Function definition */
  private void convertToSpherical(PVector vector)
  {
    var x = vector.x;
    var y = vector.y;
    var z = vector.z;

    var xSquaredPlusYSquared = pow(x, 2) + pow(y, 2);
    this.rho = sqrt(xSquaredPlusYSquared + pow(z, 2));
    this.theta = atan2(sqrt(xSquaredPlusYSquared), z);
    this.phi = atan2(y, x);
  }

  public PVector get3DPosition(PVector initialV)
  {
    /*
     * The following values of the parameter
     * power, change the overall appearance
     * of the galaxy. Some example values are
     * given below:
     *
     * --> PI | -PI
     * --> 12 | -12
     * --> 6 | -6
     */
    var power = PI;
    var nthTheta = power * this.theta;
    var nthPhi = power * this.phi;

    /*
     * Each of the variables of the newPosition vector
     * stem from the following polar equation:
     *
     * --> r * pow(sin(nthTheta | nthPhi), n) *
     * -->   * pow(cos(nthTheta | nthPhi), m),
     * --> where r = scale & {n, m} (e) [0, +oo].
     *
     * Below are given some example values for the
     * parameters [m, n] that produce really
     * intriguing galactic like shapes:
     *
     * --> [12 * PI, 1]
     * --> [PI / 3, 1]
     * --> [1, 12 * PI]
     * --> [-3 * PI, PI]
     * --> [-PI, 1]
     * --> [1, -12 * PI]
     * --> [1, -PI / 2]
     * --> [-1, 12 * PI]
     * --> [123 * PI, 123 * PI]
     */
    var n = PI / 3;
    var m = 1;
    var newPosX = pow(sin(nthTheta), n) * pow(cos(nthPhi), m);
    var newPosY = pow(sin(nthTheta), n) * pow(cos(nthPhi), m);
    var newPosZ = pow(sin(nthTheta), n) * pow(cos(nthPhi), m);
    var newPosition = new PVector(newPosX, newPosY, newPosZ);

    var scalar = pow(this.rho, power);
    newPosition.mult(scalar);
    newPosition.add(initialV.copy());

    return newPosition.copy();
  }
}
