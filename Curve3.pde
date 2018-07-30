class Curve3 extends Curve {

  public Curve3(ArrayList<PointVector> points) {
    super(points);
  }

  public Curve3(int dim, double ...values) {
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
      cz = cpoints[2].z, 
      dx = cpoints[3].x, 
      dy = cpoints[3].y, 
      dz = cpoints[3].z;

    ArrayList<PointVector> d = new ArrayList<PointVector>();
    d.add(new PointVector(3*(bx-ax), 3*(by-ay), 3*(bz-az)));
    d.add(new PointVector(3*(cx-bx), 3*(cy-by), 3*(cz-bz)));
    d.add(new PointVector(3*(dx-cx), 3*(dy-cy), 3*(dz-cz)));
    return new Curve2(d);
  }

  double getForT(double t, double[] dims) {
    double mt = 1-t, 
      c1 = mt * mt * mt, 
      c2 = 3 * mt * mt * t, 
      c3 = 3 * mt * t * t, 
      c4 = t * t * t;
    return c1 * dims[0] + c2 * dims[1] + c3 * dims[2] + c4 * dims[3];
  }
}
