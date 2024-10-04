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
     * Parametrizing the value of n,
     * results in different and amazing
     * patterns, inside the galaxy's nucleus!
     * Some examples, are given below:
     *
     * --> 3f | -3f
     * --> 12f | -12f
     */
    var n = PI;
    this.theta *= n;
    this.phi *= n;

    /*
     * Each of the variables of the newPosition vector
     * stem from the following polar equation:
     *
     * --> pow(sin(this.theta | phi), n) * pow(cos(this.theta | phi), m)
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
    n = 1;
    var m = 1;

    var sinThetaN = pow(sin(this.theta), n);
    var sinThetaM = pow(sin(this.theta), m);
    var cosThetaN = pow(cos(this.theta), n);
    var cosThetaM = pow(cos(this.theta), m);
    var sinPhiN = pow(sin(this.phi), n);
    var sinPhiM = pow(sin(this.phi), m);
    var cosPhiN = pow(cos(this.phi), n);
    var cosPhiM = pow(cos(this.phi), m);

    var posX = sinThetaN * sinPhiM;
    var posY = sinThetaN * sinPhiM;
    var posZ = sinThetaN * sinPhiM;
    var newPosition = new PVector(posX, posY, posZ);

    var radius = pow(this.rho, n);
    newPosition.mult(radius);
    newPosition.add(initialV.copy());

    return newPosition.copy();
  }
}
