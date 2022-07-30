class ScenePhyllotaxis extends BaseObject {
  final int POINTS_NUMBER = 1000;
  float PHYLO_ANGLE = 137.5; 
  final float THETA = PI * (3.0 - sqrt(5));
  float scaleFactor = 10.0;
  ArrayList<PVector> points = new ArrayList();
  int MAX_POINTS = 100;
  int MAX_SCALE =10;
  float pointsCount = 100;

  public ScenePhyllotaxis() {
    points = generateLeafs(1, scaleFactor);
  }

  void draw() {
    PVector center = new PVector(grid.width/2.0, grid.height/2.0);
    int index = 0;
    float lastPosX = -1;
    float lastPosY = -1;
    render.circle(center.x, center.y, 100-meditation, meditation/100.0, color(0, 255, 0));
    for(int i = 0; i < points.size(); i++){
      index++;
      PVector point = points.get(i).copy();
      point.rotate(frameCount*PI/180.0);
      //point.rotate(i*PI/180.0);
      //meditation = 100;
      float posX = point.x +center.x;
      float posY = point.y +center.y;
      //render.circle(posX, posY, meditation/5.0, color((meditation/100.0)*255, 250*(attention/100.0), 0, 0));
      //render.circle(posX, posY, index/5.0, 1.0, color(255 - point.mag(), 0, 0));
      //if (lastPosX > 0) {
      //  render.line(center.x, center.y, posX, posY, 1.0, color(index%points.size(), 150, 0));
      //}
      if (poorSignal < 20) {
        textSize(164);
        fill(200-meditation*2, meditation*2, 25, 10);
        stroke(2);
        textAlign(CENTER, CENTER);
        text(meditation, width/2, height/2);  // Specify a z-axis value
      }else{
        textSize(14);
        fill(100, 20, 25);
        stroke(2);
        textAlign(CENTER, CENTER);
        text("sig ( " + poorSignal + " )", width/2, height/2);  // Specify a z-axis value        
      }
      lastPosX = posX;
      lastPosY = posY;
    }
    render.circle(center.x, center.y, meditation*10/100.0, 255);
  }
  void setMeditation(int val) {
    Ani.to(this, 1.5, "meditation", val);
  }

  void setPoorSignal(int val) {
    Ani.to(this, 1.5, "poorSignal", val);
  }
  void setAttention(int val) {
    Ani.to(this, 1.5, "attention", val);
  }
  void update(float dt) {
    pointsCount = MAX_POINTS * meditation/100.0+1;
    //scaleFactor = MAX_SCALE*meditation/100.0+1;
    points = generateLeafs(round(pointsCount), scaleFactor);
  }

  ArrayList generateLeafs(int size, float scaleFactor) {
    ArrayList leafs = new ArrayList();
    for (int i = 0; i < size; i++) {
      leafs.add(getLeaf(scaleFactor, size - i));
    }
    return leafs;
  }
  PVector getLeaf(float scaleFactor, int index) {
    float angle = index*PHYLO_ANGLE*PI/180.0;
    float r = scaleFactor * sqrt(index);

    float x = r * cos(angle);
    float y = r * sin(angle);
    return new PVector(x, y);
  }
}
