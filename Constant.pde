class Constant extends Curve {

  double v;

  public Constant(double v) {
    super(1);
    this.v = v;
  }

  public Curve formDerivative() {
    return this;
  }

  double getForT(double t, double[] dims) {
    return v;
  }
}
