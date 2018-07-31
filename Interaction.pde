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
  // We want to zoom in at the cursor, but we want to zoom out away
  // from the cursor, similar to how applications like Sketchup
  // handle scroll based zoom.  
  double step = event.getCount() < 0 ? 1 : -1, 
    zoom = 1.1, 
    zoomFactor = pow(zoom, abs(step)), 
    moveFactor = zoomFactor - 1.0, 
    // view to canvas  
    zoomCenterX = (step>0 ? mouseX : (width - (width - mouseX))) / SCALE + ROX, 
    zoomCenterY = (step>0 ? mouseY : (height - (height - mouseY))) /SCALE + ROY,
    // translation shift
    invZoomFactor = 1/zoomFactor,
    x = (ROX - zoomCenterX) * (moveFactor * invZoomFactor), 
    y = (ROY - zoomCenterY) * (moveFactor * invZoomFactor);

  SCALE *= (step==1)? zoomFactor : invZoomFactor;
  ROX += step * x;
  ROY += step * y;

  redraw();
}
