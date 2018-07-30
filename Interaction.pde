/**
 * This is the part that lets you move points around. 
 */

PointVector interactionPoint = null;
PointVector relocationPoint = null;

void forwardToListeners(ArrayList<BezierMouseListener> listeners) {
  for (BezierMouseListener l : listeners) { 
    l.handle();
  }
}

interface BezierMouseListener {
  void handle();
}

ArrayList<BezierMouseListener> __mouse_moved = new ArrayList<BezierMouseListener>();

void addMouseMovedListener(BezierMouseListener listener) {
  __mouse_moved.add(listener);
}

void mouseMoved() {
  if (!mousePressed) {
    interactionPoint = curve.getControlPointNear(mouseX, mouseY);
    if (interactionPoint != null ) {
      cursor(HAND);
    } else {
      cursor(ARROW);
    }
  }
  forwardToListeners(__mouse_moved);
}

ArrayList<BezierMouseListener> __mouse_dragged = new ArrayList<BezierMouseListener>();

void addMouseDraggedListener(BezierMouseListener listener) {
  __mouse_dragged.add(listener);
}

void mouseDragged() {
  if (relocationPoint != null) {
    relocationPoint.x = mouseX;
    relocationPoint.y = mouseY;
    curve.update();
    redraw();
  }
  forwardToListeners(__mouse_dragged);
}

ArrayList<BezierMouseListener> __mouse_pressed = new ArrayList<BezierMouseListener>();

void addMousePressedListener(BezierMouseListener listener) {
  __mouse_pressed.add(listener);
}

void mousePressed() {
  if (interactionPoint != null) {
    relocationPoint = interactionPoint;
  }
  forwardToListeners(__mouse_pressed);
}

ArrayList<BezierMouseListener> __mouse_released = new ArrayList<BezierMouseListener>();

void addMouseReleasedListener(BezierMouseListener listener) {
  __mouse_released.add(listener);
}

void mouseReleased() {
  relocationPoint = null;
  forwardToListeners(__mouse_released);
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount(), 
    step = (e<0 ? 1 : -1) * 0.02;

  SCALE += step;

  // We want to scale "around" the cursor,
  // so we need to do a bit of ROX/ROY
  // correcting, to make sure that when
  // redraw() occurs, the sketch has a new
  // translation that maps the same point
  // to where the mouse cursor trigged scaling.


  redraw();
}
