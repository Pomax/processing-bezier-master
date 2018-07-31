class PointVector extends Curve {
  // special values for point-on/along-curve purposes.
  double t, d;

  double x, y, z;

  public PointVector(double x, double y, double z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }

  public PointVector(PointVector other) {
    this(other.x, other.y, other.z);
  }

  double length() {
    return sqrt(x*x + y*y + z*z);
  }

  PointVector normalize() {
    return normalise();
  }

  PointVector normalise() {
    double l = length();
    return new PointVector(x/l, y/l, z/l);
  }

  PointVector scale(double s) {
    return new PointVector(s*x, s*y, s*z);
  }

  Curve formDerivative() {
    return new Constant(0);
  }

  PointVector near(double x, double y) {
    return this.near(x, y, this.z, 5);
  }

  PointVector near(double x, double y, double z) {
    return this.near(x, y, z, 5);
  }

  PointVector near(double x, double y, double z, double d) {
    return (abs(this.x-x)<d && abs(this.y-y)<d && abs(this.z-z)<d) ? this : null;
  }

  void draw() {
    stroke(0, 0, 100);
    noFill();
    ellipse(this, 5, 5);
  }

  double getForT(double t, double[] dims) {
    return dims[0];
  }

  PointVector plus(PointVector other) {
    return new PointVector(
      this.x + other.x, 
      this.y + other.y, 
      this.z + other.z
      );
  }

  PointVector minus(PointVector other) {
    return new PointVector(
      this.x - other.x, 
      this.y - other.y, 
      this.z - other.z
      );
  }

  PointVector cross(PointVector other) {
    return new PointVector(
      this.y * other.z - this.z * other.y, 
      this.z * other.x - this.x * other.z, 
      this.x * other.y - this.y * other.x
      );
  }   

  double dot(PointVector other) {
    return this.x * other.x + this.y * other.y + this.z * other.z;
  }  

  String toString() {
    return "{" + x + "," + y + "," + z + "} (length=" + length() + ")";
  }

  PointVector project() {
    return project(PROJECTION_ANGLE_X - AXDIFF, PROJECTION_ANGLE_Z - AZDIFF);
  }

  /**
   * cabinet projection is good enough
   */
  PointVector project(double phi, double rho) {
    ProjectionType type = getProjectionType();

    if (type == ProjectionType.CABINET) {
      // What they rarely tell you: if you want z to "go up", x "come out of the screen"
      // and y to be the "left/right", we need this:
      double x =  this.y, 
        y = -this.z, 
        z = -this.x;
      return new PointVector(
        x + z/2 * cos(phi), 
        y + z/2 * sin(phi), 
        0
      );
    }

    if (type == ProjectionType.TOP) {
      return new PointVector(x, -y, 0);
    }

    return this;
  }

  PointVector lerp(PointVector other, double ratio) {
    return new PointVector(
      (1-ratio)*x + ratio*other.x, 
      (1-ratio)*y + ratio*other.y, 
      (1-ratio)*z + ratio*other.z  
      );
  }
}
