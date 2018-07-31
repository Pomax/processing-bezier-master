class Grid {
  double dim;
  final static int DEFAULT_PADDING = 20;

  public Grid(double dim) {
    this.dim = dim;
  }

  void draw() { 
    draw(10);
  }

  void draw(int s) {
    int v;
    color b = color(100, 100, 100), 
      g = color(200, 200, 200);

    stroke(g);
    for (v=0; v<=dim; v+=s) {
      if (v%100 == 0) continue;

      line(new PointVector(v, 0, 0), new PointVector(v, dim, 0));
      line(new PointVector(v, 0, 0), new PointVector(v, 0, dim));

      line(new PointVector(0, v, 0), new PointVector(dim, v, 0));
      line(new PointVector(0, v, 0), new PointVector(0, v, dim));

      line(new PointVector(0, 0, v), new PointVector(dim, 0, v));
      line(new PointVector(0, 0, v), new PointVector(0, dim, v));
    }

    stroke(b);
    for (v=0; v<=dim; v+=s) {
      if (v % 100 != 0) continue;

      line(new PointVector(v, 0, 0), new PointVector(v, dim, 0));
      line(new PointVector(v, 0, 0), new PointVector(v, 0, dim));

      line(new PointVector(0, v, 0), new PointVector(dim, v, 0));
      line(new PointVector(0, v, 0), new PointVector(0, v, dim));

      line(new PointVector(0, 0, v), new PointVector(dim, 0, v));
      line(new PointVector(0, 0, v), new PointVector(0, dim, v));
    }
  }
}
