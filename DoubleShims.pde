float _(double d) { 
  return round((float)d);
}
int floor(double d) { 
  return (int) _(Math.floor(d));
}
int ceil(double d) { 
  return (int) _(Math.ceil(d));
}
double sqrt(double v) { 
  return Math.sqrt(v);
}
double abs(double v) { 
  return Math.abs(v);
}
double map(double a, double b, double c, double d, double e) {
  return map(_(a), _(b), _(c), _(d), _(e));
}
double dist(double a, double b, double c, double d) {
  double dx = abs(a-c);
  double dy = abs(b-d);
  return sqrt(dx*dx + dy*dy);
}
double dist(double a, double b, double c, double d, double e, double f) {
  double dx = abs(a-d);
  double dy = abs(b-e);
  double dz = abs(c-f);
  return sqrt(dx*dx + dy*dy + dz*dz);
}
double cos(double x) { 
  return Math.cos(x);
}
double acos(double x) { 
  return Math.acos(x);
}
double sin(double x) { 
  return Math.sin(x);
}
double asin(double x) { 
  return Math.asin(x);
}
double tan(double x) { 
  return Math.tan(x);
}
double atan(double x) { 
  return Math.atan(x);
}
double atan2(double dy, double dx) { 
  return Math.atan2(dy, dx);
}
double pow(double a, double b) { 
  return Math.pow(a, b);
}
