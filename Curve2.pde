class Curve2 extends Curve {

  public Curve2(ArrayList<PointVector> points) {
    super(points);
  }

  public Curve2(int dim, double ...values) {
    super(dim, values);
  }  

  public Curve formDerivative() {
    double 
      ax = cpoints[0].x, 
      ay = cpoints[0].y, 
      az = cpoints[0].z, 
      bx = cpoints[1].x, 
      by = cpoints[1].y, 
      bz = cpoints[1].z, 
      cx = cpoints[2].x, 
      cy = cpoints[2].y, 
      cz = cpoints[2].z;

    ArrayList<PointVector> d = new ArrayList<PointVector>();
    d.add(new PointVector(2*(bx-ax), 2*(by-ay), 2*(bz-az)));
    d.add(new PointVector(2*(cx-bx), 2*(cy-by), 2*(cz-bz)));
    return new Line(d);
  }

  double getForT(double t, double[] dims) {
    double mt = 1-t, 
      c1 = mt * mt, 
      c2 = 2 * mt * t, 
      c3 = t * t;
    return c1 * dims[0] + c2 * dims[1] + c3 * dims[2];
  }
}
