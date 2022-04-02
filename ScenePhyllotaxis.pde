class ScenePhyllotaxis extends BaseObject {
  final int POINTS_NUMBER = 1000;
  float PHYLO_ANGLE = 137.5;
  final float THETA = PI * (3.0 - sqrt(5));
  float scaleFactor = 3.0;
  ArrayList<PVector> points = new ArrayList();
  int MAX_POINTS = 100`1;
  int MAX_SCALE = 4;
  float pointsCount = 1;

  public ScenePhyllotaxis() {
    points = generateLeafs(1, scaleFactor);
  }

  void draw() {
    PVector center = new PVector(grid.width/2.0, grid.height/2.0);
    int index = 0;
    float lastPosX = -1;
    float lastPosY = -1;
      for (PVector point : points) {
      index++;
      point.rotate(frameCount*PI/180.0);
      float posX = point.x +center.x;
      float posY = point.y +center.y;
      render.point(posX, posY, 2.0, color(255*index/(points.size()!=0?points.size():1), 0, 0));
      if(lastPosX > 0){
        render.line(center.x, center.y, posX, posY, 1.0, color(index*255.0/points.size(), 255, 0));
      }
      if(poorSignal < 20){
      textSize(32);
      fill(255, 102, 153);
      stroke(2);
      textAlign(CENTER,CENTER);
      text(meditation, width/2, height/2);  // Specify a z-axis value
      }
      lastPosX = posX;
      lastPosY = posY;
    }
  }
void setMeditation(int val){
  Ani.to(this,  2.5, "meditation", val);
}

void setPoorSignal(int val){
  Ani.to(this,  0.5, "poorSignal", val);
}
void setAttention(int val){
  Ani.to(this,  0.5, "attention", val);
}
  void update(float dt) {
    //if (isKeyPressed('a')) {
    //  scaleFactor = scaleFactor - scaleFactor*0.1;
    //}
    //if (isKeyPressed('d')) {
    //  scaleFactor = scaleFactor + scaleFactor*0.1;
    //}
    //if (isKeyPressed('z')) {
    //  pointsCount = pointsCount - pointsCount/10.0;
    //}
    //if (isKeyPressed('c')) {
    //  pointsCount = pointsCount + pointsCount/10.0;
    //}
    pointsCount = MAX_POINTS * meditation/100.0;
    scaleFactor = MAX_SCALE*meditation/100.0;
    points = generateLeafs(round(pointsCount), scaleFactor);
    println("ScaleFactor: " + scaleFactor);
    println("PointsCount: " + pointsCount);
  }

  ArrayList generateLeafs(int size, float scaleFactor) {
    ArrayList leafs = new ArrayList();
    for (int i = 0; i < size; i++) {
      leafs.add(getLeaf(scaleFactor, size/2 - i));
    }
    return leafs;
  }
  PVector getLeaf(float scaleFactor, int index) {
    float angle = index*THETA;
    float r = scaleFactor * sqrt(index);

    float x = r * cos(angle);
    float y = r * sin(angle);
    return new PVector(x, y);
  }
}
