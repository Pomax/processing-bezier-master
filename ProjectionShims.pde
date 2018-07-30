double dist(PointVector a, PointVector b) {
  double dx = a.x - b.x, dy = a.y - b.y, dz = a.z - b.z;
  return sqrt(dx*dx + dy*dy + dz*dz);
}

void line(PointVector p1, PointVector p2) {
  p1 = p1.project();
  p2 = p2.project();
  line(_(p1.x), _(p1.y), _(p2.x), _(p2.y));
}

void circle(PointVector p) {
  circle(p, 2.5);
}

void circle(PointVector p, double r) {
  p = p.project();  
  float d = _(r);
  ellipse(_(p.x), _(p.y), d, d);
}

void ellipse(PointVector p, double w, double h) {
  p = p.project();
  ellipse(_(p.x), _(p.y), _(w), _(h));
}

void vertex(PointVector p) {
  p = p.project();
  vertex(_(p.x), _(p.y));
}
