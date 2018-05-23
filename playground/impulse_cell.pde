
class ImpulseCell {
  final float DEFAULT_VALUE = 0.0;
  final float HIDE_SPEED = 5.0;
  final float SHOW_SPEED = HIDE_SPEED/3;
  float value = DEFAULT_VALUE;
  float impulse = 0.0;
  float width = 10;
  float height = 10;
  int x, y;

  ImpulseCell(float width, float height, int x, int y, float value) {
    this.width = width;
    this.height = height;
    this.value = value;
    this.x = x;
    this.y = y;
  }

  float getRealX() {
    return x * width;
  }

  float getRealY() {
    return y * height;
  }

  void update(float deltaTime) {
    if (impulse == 0) {
      setValue(value - HIDE_SPEED * deltaTime);
    } else {
      setImpulse(impulse - deltaTime*SHOW_SPEED);
      setValue(value + deltaTime*SHOW_SPEED);
    }
  }

  void setValue(float value) {
    if (value < 0.001)value = 0;
    if (value > 0.99)value = 1;
    this.value = value;
  }
  void setImpulse(float value) {
    if (value < 0.001)value = 0;
    if (value > 0.99)value = 1;
    this.impulse = value;
  }  
  void applyImpulse(float impulseValue) {
    impulse = impulseValue;
  }

  void draw() {
    pushMatrix();
    translate(x*width, y * height);
    rect(0, 0, width*value, height * value);
    popMatrix();
  }
}