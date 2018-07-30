class PointInformation {
  Curve curve;
  double t;

  PointInformation(Curve c, double x, double y) {
    curve = c;
    double pad = 0.25;
    t = map(x, 0, width, -pad, 1 + pad);
  }

  void draw() {
    double
      t1 = t, 
      t2 = t + 0.001; 

    // let's fit a planar circle through these points, following https://math.stackexchange.com/a/1743505/71940
    PointVector
      p1 = curve.get(t1), 
      n1 = curve.getNormal(t1).normalize(), 
      p2 = curve.get(t2), 
      n2 = curve.getNormal(t2).normalize();

    double theta = acos(n1.dot(n2));
    if (theta > PI/4) {
      // let's flip this normal from here on out
    }
    println(theta);

    line(p1, p1.plus(n1.scale(200)));
    line(p2, p2.plus(n2.scale(200)));
  }
}
