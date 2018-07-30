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

  // where are we, x/y wise? 
  double tw = width / SCALE, 
    th = height / SCALE;

  SCALE += step;

  double nw = width / SCALE, 
    nh = height / SCALE;

  double nx = map(mouseX, 0, tw, 0, nw), 
    ny = map(mouseY, 0, th, 0, nh);

  double xdiff = mouseX - nx, 
    ydiff = mouseY - ny;

  // We want the mouse coordinate, expressed as ratio of the
  // width/height, to remain the same. We know what the old
  // and new values are, so we need to adjust ROX/ROY by
  // the differences

    ROX += -xdiff;
    ROY += -ydiff;

  // TODO: this is all wrong =)

  redraw();
}
