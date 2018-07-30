PointVector makePoint(double x, double y, double ox, double oy, double s) {
  return new PointVector(x+ox, y+oy, 0).scale(s);
}

PointVector makePoint(double x, double y, double z, double ox, double oy, double s) {
  return new PointVector(x+ox, y+oy, z).scale(s);
}
