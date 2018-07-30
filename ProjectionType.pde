// It is super annoying that there is no "static in inner classes", which
// makes sense in Java but makes zero sense in the model that Processing
// pretends to be (while taking advantage of java for 99.99% of things.

enum ProjectionType {
  TOP,
  FRONT,
  SIDE,
  CABINET
}

ProjectionType projectionType = ProjectionType.CABINET;

ProjectionType getProjectionType() {
  return projectionType;
}

void setProjectionType(ProjectionType type) {
  projectionType = type;
}
