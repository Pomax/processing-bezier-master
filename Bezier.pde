Grid grid;
Curve curve = null;
PointInformation pointInformation = null;

float SCALE, ROX, ROY;

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
  // set up an initial draw matrix that lets us
  reset();
  noLoop();
}

void reset() {
  // set up the grid box
  grid = new Grid(width);

  // set up a curve
  curve = makeCurve(
    new PointVector(  0, 0, 0), 
    new PointVector(-380, 260, 0), 
    new PointVector(-25, 541, 0), 
    new PointVector(-15, 821, 0)
    );

  // view the scene with reasonably positioned graphics. 
  SCALE = 0.4; 
  ROX = 0.95 * width;
  ROY = 1.5 * height;
}

void draw() {
  // prep the canvas
  background(255);
  scale(SCALE);
  translate(ROX, ROY);
 
  // draw all the things.
  grid.draw();
  curve.drawConstruction();
  stroke(100, 100, 255, 255);
  curve.drawCurvature();
  stroke(10, 200, 10);
  curve.drawNormals();
  curve.draw();
}
