class VectorFrame {
  // origin, tangent, rotational axis, resultant normal
  PointVector o, t, r, n;

  public VectorFrame(PointVector origin, PointVector tangent, PointVector normal) {
    this(origin, tangent, normal, tangent.cross(normal).normalize());
  }

  public VectorFrame(PointVector origin, PointVector tangent, PointVector normal, PointVector rotation) {
    o=origin;
    this.t=tangent;
    this.n=normal;
    this.r=rotation;
  }
}
