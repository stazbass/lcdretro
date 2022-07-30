class StarzScene extends BaseObject {
  StarzScene() {
    addStar();
  }

  void addStar() {
    addChild(new Star(false));
  }

  void draw() {
    super.draw();
   
  }

  void update(float dt) {
    super.update(dt);
    addStar();
    //addStar();
    //addStar();
    //addStar();
    //addStar();
    //addStar();
    //addStar();
    //addStar();
    //addStar();
    //addStar();
    //addStar();
    //addStar();
  }
}

class Star extends BaseObject {
  float x, y, z;
  int starColor;
  boolean goingToReset = false;
  boolean inverted = false;

  Star(boolean inverted) {
    this.inverted = inverted;
    reset();
  }

  void update(float dt) {
    z -= (500)*dt;
    if (goingToReset)
      reset();
  }

  void reset() {
    x = random(-5000, 5000);
    y = random(-5000, 5000);
    float angle = random(-PI/2.0, PI/2.0);
    x = cos(angle)*x - sin(angle)*y;
    y = sin(angle)*x + cos(angle)*y;
    z = 2000;
    starColor = color(random(0, abs(255*cos(frameCount*PI/180))), random(0, abs(255*sin(frameCount*PI/180.0))), random(0, abs(255)));
    goingToReset = false;
  }

  void draw() {

    float offsetX = inverted ? 100.0 / (x/z) : 100.0 * (x/z);
    float offsetY = inverted ? 100.0 / (y/z) : 100.0 * (y/z);
    float scaleZ = 0.05 * (2000.0-z);

    offsetX = offsetX / render.grid.cellWidth;
    offsetY = offsetY / render.grid.cellHeight;
    offsetX = offsetX + grid.width/2.0;
    offsetY = offsetY + grid.height/2.0;
    render.point(offsetX, offsetY, scaleZ, starColor);
    if (offsetX > grid.width || offsetX < 0)goingToReset = true;
    if (offsetY > grid.height || offsetY < 0)goingToReset = true;
  }
}
