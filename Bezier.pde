Grid grid;
Curve curve = null;
PointInformation pointInformation = null;

float SCALE = 0.4, 
  ROX, 
  ROY;

// simple listener so that we can see information about a point near the mouse cursor
class SeeCurvePointInformation implements BezierMouseListener {
  void handle() {
    //pointInformation = new PointInformation(curve, mouseX, mouseY);
    //redraw();
  }
}

void setup() {
  size(600, 600);
  addMouseMovedListener(new SeeCurvePointInformation());
  ROX = 0.75 * width;
  ROY = 1.75*height;
  reset();
  noLoop();
}

void reset() {
  grid = new Grid(width);
  curve = makeCurve(
    new PointVector(  0, 0, 0), 
    new PointVector(-380, 260, 0), 
    new PointVector(-25, 541, 0), 
    new PointVector(-15, 821, 0)
    );
  setProjectionType(ProjectionType.TOP);
}

void draw() {
  background(255);
  scale(SCALE);
  translate(ROX, ROY);

  grid.draw();
  curve.drawConstruction();

  stroke(100, 100, 255, 255);
  curve.drawCurvature();

  stroke(10, 200, 10);
  curve.drawNormals();

  curve.draw();
}
