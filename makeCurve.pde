// We have this file because Processing is almost-but-not-quite Java,
// where any class you define becomes an internal class, so you can't
// mix static and instance members. Instead, what in Java would be
// static curve creation functions just become "global functions".

Curve makeCurve(PointVector ...points) {
  ArrayList<PointVector> pts = new ArrayList<PointVector>();
  for (PointVector p : points) {
    pts.add(p);
  }
  return makeCurve(pts);
}

Curve makeCurve(ArrayList<PointVector> points) {
  if (points.size() == 3) {
    return new Curve2(points);
  }
  if (points.size() == 4) {

    return new Curve3(points);
  }
  return null;
}
