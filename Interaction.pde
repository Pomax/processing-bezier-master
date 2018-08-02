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

int AXMARK=-1, 
  AZMARK=-1, 
  XMARK=-1, 
  YMARK=-1, 
  XDIFF=0, 
  YDIFF=0;

double AXDIFF=0, 
  AZDIFF=0;

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

  // change the projection angles
  if (mouseButton==3 && (AXMARK != -1 && AZMARK != -1)) {
    AXDIFF = (PI*float(mouseX - AXMARK)/width);
    AZDIFF = (PI*float(AZMARK - mouseY)/height);
  }

  // pan the scene   
  if (mouseButton!=3 && (XMARK != -1 && YMARK != -1)) {
    XDIFF = mouseX - XMARK;
    YDIFF = mouseY - YMARK;
  }
  
  forwardToListeners(__mouse_dragged);
  redraw();
}


ArrayList<BezierMouseListener> __mouse_pressed = new ArrayList<BezierMouseListener>();

void addMousePressedListener(BezierMouseListener listener) {
  __mouse_pressed.add(listener);
}

void mousePressed() {

  if (interactionPoint != null) {
    relocationPoint = interactionPoint;
  } else {
    AXMARK = mouseX;
    AZMARK = mouseY;
    XMARK = mouseX;
    YMARK = mouseY;
  }
  forwardToListeners(__mouse_pressed);
  redraw();
}


ArrayList<BezierMouseListener> __mouse_released = new ArrayList<BezierMouseListener>();

void addMouseReleasedListener(BezierMouseListener listener) {
  __mouse_released.add(listener);
}

void mouseReleased() {
  relocationPoint = null;

  if (AXDIFF!=0 || AZDIFF!=0) {
    PROJECTION_ANGLE_X += AXDIFF;
    PROJECTION_ANGLE_Z += AZDIFF;
    AXDIFF = 0;
    AZDIFF = 0;
    AXMARK = -1;
    AZMARK = -1;
  }

  if (XDIFF!=0 || YDIFF!=0) {
    OX += XDIFF;
    OY += YDIFF;
    XDIFF = 0;
    YDIFF = 0;
    XMARK = -1;
    YMARK = -1;
  }

  forwardToListeners(__mouse_released);
  redraw();
}


ArrayList<BezierMouseListener> __mouse_wheel = new ArrayList<BezierMouseListener>();

void addMouseWheelListener(BezierMouseListener listener) {
  __mouse_wheel.add(listener);
}

void mouseWheel(MouseEvent event) {
  double c = event.getCount();
  if (c == 0) return;

  // We want to zoom in at the cursor, but we want to zoom out away
  // from the cursor, similar to how applications like Sketchup
  // handle scroll based zoom.
  double step = (c < 0) ? 1 : -1,
    zoom = 1.1, 
    zoomFactor = pow(zoom, abs(step)), 
    moveFactor = zoomFactor - 1.0, 
    // view to canvas  
    mx = (step > 0) ? mouseX : (width - (width - mouseX)), 
    my = (step > 0) ? mouseY : (height - (height - mouseY)), 
    zoomCenterX = (mx - OX)/SCALE + ROX, 
    zoomCenterY = (my - OY)/SCALE + ROY, 
    invZoomFactor = 1/zoomFactor, 
    // translation shift
    x = (ROX - zoomCenterX) * (moveFactor * invZoomFactor), 
    y = (ROY - zoomCenterY) * (moveFactor * invZoomFactor);
  // update our scale and world offset    
  SCALE *= (step == 1)? zoomFactor : invZoomFactor;
  ROX += step * x;
  ROY += step * y;
  forwardToListeners(__mouse_wheel);  
  redraw();
}
