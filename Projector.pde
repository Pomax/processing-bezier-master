double PROJECTION_ANGLE_X = 0;
double PROJECTION_ANGLE_Z = 0;

// It is super annoying that there is no "static in inner classes", which
// makes sense in Java but makes zero sense in the model that Processing
// pretends to be (while taking advantage of java for 99.99% of things.

enum ProjectionType {
  TOP, 
    FRONT, 
    SIDE, 
    CABINET
}

static class Projector {
  static ProjectionType projectionType = ProjectionType.CABINET;

  static ProjectionType getProjectionType() {
    return projectionType;
  }

  static void setProjectionType(ProjectionType type) {
    projectionType = type;
  }

  static double sin(double v) { 
    return Math.sin(v);
  }

  static double cos(double v) { 
    return Math.cos(v);
  }

  /**
   * cabinet projection is good enough
   */
  static PointVector project(PointVector p, double phi, double rho) {
    ProjectionType type = getProjectionType();

    if (type == ProjectionType.CABINET) {
      // What they rarely tell you: if you want z to "go up", x "come out of the screen"
      // and y to be the "left/right", we need this:

      double nx = p.x * cos(rho) - p.z * sin(rho), 
        ny = p.y, 
        nz = p.x * sin(rho) + p.z * cos(rho);

      double tx = nx * cos(phi) - ny * sin(phi), 
        ty = nx * sin(phi) + ny * cos(phi), 
        tz = nz;

      double x =  ty, 
        y = -tz, 
        z = -tx;

      double cab =  -PI/6, 
        px = x + z/2 * cos(cab), 
        py = y + z/2 * sin(cab);

      return p.build(px, py, 0);
    }

    if (type == ProjectionType.TOP) {
      return p.build(p.x, -p.y, 0);
    }

    return p;
  }
}
