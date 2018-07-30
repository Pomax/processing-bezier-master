public abstract class Curve {
  Curve derivative = null;
  PointVector[] cpoints = {};
  PointVector[] LUT = {};

  double[] X = {};
  double[] Y = {};
  double[] Z = {};


  public Curve() {
  }

  public Curve(int dim, double ...values) {
    ArrayList<PointVector> points = new ArrayList<PointVector>();
    for (int i=0, l=values.length; i<l; i+=dim) {
      PointVector p = new PointVector(values[i], values[i+1], 0);
      if (dim == 3) {        
        p.z = values[i+2];
      }
      points.add(p);
    }
    updatePoints(points);
  }

  public Curve(ArrayList<PointVector> points) {
    updatePoints(points);
  }


  // ==================


  abstract Curve formDerivative();

  private void updatePoints(ArrayList<PointVector> points) {
    int l = (points == null) ? cpoints.length : points.size();
    if (points != null) {
      cpoints = new PointVector[l];
    }
    X = new double[l];
    Y = new double[l];
    Z = new double[l];
    while (l-- != 0) {
      PointVector p = (points == null) ? cpoints[l] : points.get(l);
      X[l] = p.x;
      Y[l] = p.y;
      Z[l] = p.z;
      if (points != null) {
        cpoints[l] = new PointVector(X[l], Y[l], Z[l]);
      }
    }
    derivative = formDerivative();
    if (cpoints.length > 1) {
      LUT = new PointVector[100];
      l=LUT.length;
      for (int i=0, d=l-1; i<l; i++) {
        LUT[i] = get( (double)i/(double)d );
      }
    }
  }

  void update() {
    updatePoints(null);
  }

  double getCurvature(double t) {
    PointVector d = derivative.get(t), 
      dd = derivative.derivative.get(t);
    double v1 = d.cross(dd).length(), 
      v2 = pow(d.length(), 3);
    return v1/v2;
  }

  double getCurvatureRadius(double t) {
    return 1.0 / getCurvature(t);
  }

  VectorFrame getFrenetFrame(double t) {
    PointVector p = get(t);
    PointVector tangent = derivative.get(t).normalise();
    PointVector normal = getNormal(t).normalise();
    return new VectorFrame(p, tangent, normal);
  }

  ArrayList<VectorFrame> getRMF(int steps) {
    ArrayList<VectorFrame> frames = new ArrayList<VectorFrame>();
    double c1, c2, step = 1.0/steps, t0=0, t1;
    PointVector v1, v2, riL, tiL;
    VectorFrame x0, x1;

    frames.add(getFrenetFrame(t0));

    for (; t0<=1.0-step; t0+=step) {
      x0 = frames.get(frames.size() - 1);
      t1 = t0 + step;
      x1 = getFrenetFrame(t1);
      v1 = x1.o.minus(x0.o);
      c1 = v1.dot(v1);
      riL = x0.r.minus(v1.scale( 2/c1 * v1.dot(x0.r) ));
      tiL = x0.t.minus(v1.scale( 2/c1 * v1.dot(x0.t) ));
      v2 = x1.t.minus(tiL);
      c2 = v2.dot(v2);
      x1.r = riL.minus(v2.scale( 2/c2 * v2.dot(riL) ));
      x1.n = x1.r.cross(x1.t);
      frames.add(x1);
    }

    return frames;
  }

  PointVector get(double t) {
    return new PointVector(getForT(t, X), getForT(t, Y), getForT(t, Z));
  }

  PointVector getDerivative(double t) {
    return derivative.get(t);
  }

  PointVector getNormal(double t) {
    PointVector
      p = curve.get(t), 
      d = derivative.get(t).normalize(), 
      dd = derivative.derivative.get(t).normalize(), 
      axis = d.cross(dd).normalize(), 
      normal = axis.cross(d).normalize();
    return normal;
  }

  abstract double getForT(double t, double[] dims);

  PointVector getControlPointNear(double x, double y) {
    PointVector test = null;
    for (PointVector p : cpoints) {
      test = p.near(x, y);
      if (test != null) return p;
    }
    return null;
  }

  private double[] closest(PointVector[] LUT, PointVector point) {
    double mdist = pow(2, 63), mpos = -1, d;
    for (int idx=0, l=LUT.length; idx<l; idx++) {
      PointVector p = LUT[idx];
      d = dist(point, p);
      if (d < mdist) {
        mdist = d;
        mpos = idx;
      }
    }
    return new double[]{mdist, mpos};
  }

  PointVector getClosestPointTo(double x, double y) {
    PointVector point = new PointVector(x, y, 0);
    // step 1: coarse check
    int l = LUT.length - 1;
    double[] closest = closest(LUT, point);
    double mdist = closest[0], mpos = closest[1];

    if (mpos == 0 || mpos == l) {
      double t = mpos / l;
      PointVector pt = get(t);
      pt.t = t;
      pt.d = mdist;
      return pt;
    }

    // step 2: fine check
    PointVector p;
    double ft, t, d, 
      t1 = (mpos - 1) / l, 
      t2 = (mpos + 1) / l, 
      step = 0.1 / l;

    mdist += 1;
    for (t = t1, ft = t; t < t2 + step; t += step) {
      p = get(t);
      d = dist(point, p);
      if (d < mdist) {
        mdist = d;
        ft = t;
      }
    }
    p = get(ft);
    p.t = ft;
    p.d = mdist;
    return p;
  }

  // ==================


  void draw() {
    stroke(255, 0, 0);
    noFill();
    beginShape();
    double t;
    for (int i=0, l=100; i<=l; i++) {
      t = i/100.0;
      PointVector p = get(t);
      vertex(p);
    }
    endShape();
  }

  void drawT(double t) {
    PointVector p = get(t);
    ellipse(p, 5, 5);
  }

  void drawCurvature() {
    drawCurvature(1, 100);
  }

  void drawCurvature(int count) {
    drawCurvature(1, count);
  }

  void drawCurvature(double scale) {
    drawCurvature(scale, 100);
  }

  void drawCurvature(double scale, int count) {
    PointVector p, n;
    double i, l, t, r;
    for (i=0, l=count-1; i<=l; i++) {
      t = i/l;
      p = get(t);
      n = getNormal(t);
      r = getCurvatureRadius(t);
      line(p, p.plus(n.scale(scale*r)));
    }
  }

  void drawNormals() {
    drawNormals(200, 100);
  }

  void drawNormals(int count) {
    drawNormals(count, 100);
  }

  void drawNormals(int count, int scale) {
    for (VectorFrame f : curve.getRMF(count)) {
      line(f.o, f.o.plus(f.n.scale(scale)));
    }
  }    

  void drawConstruction() {
    int l = cpoints.length;
    stroke(100);

    line(cpoints[0], cpoints[1]);
    line(cpoints[l-2], cpoints[l-1]);

    if (l>3) {
      stroke(200);
      for (int i=1; i<l-1; i++) {
        line(cpoints[i], cpoints[i+1]);
      }
    }

    for (PointVector p : cpoints) {
      p.draw();
    }
  }
}
