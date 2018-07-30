class Line extends Curve {

  public Line(ArrayList<PointVector> points) {
    super(points);
  }

  public Line(int dim, double ...values) {
    super(dim, values);
  }

  Curve formDerivative() {
    double 
      ax = cpoints[0].x, 
      ay = cpoints[0].y, 
      az = cpoints[0].z, 
      bx = cpoints[1].x, 
      by = cpoints[1].y, 
      bz = cpoints[1].z, 
      x = (bx-ax), 
      y = (by-ay),
      z = (bz-az);
    return new PointVector(x, y, z);
  }

  double getForT(double t, double[] dims) {
    return (1-t) * dims[0] + t * dims[1];
  }
}
