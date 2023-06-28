
class ScenePhyllotaxis extends BaseObject {
  final int POINTS_NUMBER = 1000;
  float PHYLO_ANGLE = 137.5;
  final float THETA = PI * (3.0 - sqrt(5));
  float scaleFactor = 8.0;
  float targetScale = 0;
  ArrayList<PVector> points = new ArrayList();
  int MAX_POINTS = 100;
  int MAX_SCALE = 5;
  float pointsCount = 1;
  int lastMeditation;
  float rotateSpeed = 0.01;
  HashMap lastPointHash = new HashMap();
  
  public ScenePhyllotaxis() {
    points = generateLeafs(POINTS_NUMBER, scaleFactor);
    lastMeditation = meditation;
    targetScale = scaleFactor;
  }

  void draw() {
    PVector center = new PVector(grid.width/2.0, grid.height/2.0);
    if(meditation  != lastMeditation){
      lastMeditation = getMeditation();
      setMeditation(meditation);
    }
    int index = 0;
    float lastPosX = 0;
    float lastPosY = 0;
    lastPointHash.clear();
    
    render.circle(center.x, center.y, 2, 1);
    for (PVector point : points) {
      index++;
      //point.setMag(point.mag()+index);
      point.rotate(index*rotateSpeed*PI/180.0);
      float scale2Meditation = scaleFactor*(meditationSmooth/100.0);
      
      float posX = point.x*scale2Meditation +center.x;
      float posY = point.y*scale2Meditation +center.y;
       PVector.dist(point,center);
      render.point(posX, posY, 1.0, color(sin((index%255)*PI/180)*255, sin( (255-index%255)*PI/180 )*255, 0));
      if (lastPosX > 0) {
        //render.line(lastPosX, lastPosY, posX, posY, 1.0, color(index%255, 255-index%255, 0));
        lastPosX = posX;
        lastPosY = posY;
      }
      //if (poorSignal < 20) {
      //}
    }
  }

  
  int getMeditation(){
    return meditation; 
  }
  void update(float dt) {
    if (isKeyPressed('r')) {
      rotateSpeed = rotateSpeed - rotateSpeed*0.1;
    }
    if (isKeyPressed('t')) {
      rotateSpeed = rotateSpeed + rotateSpeed*0.1;
    }
    //rotateSpeed = 1.0/(100-meditation+1);
    //println("R" + rotateSpeed);
    if (isKeyPressed('z')) {
      pointsCount = pointsCount - pointsCount/10.0;
    }
    if (isKeyPressed('c')) {
      pointsCount = pointsCount + pointsCount/10.0;
    }
    //pointsCount = MAX_POINTS * meditation/100.0+1;
    //targetScale = map(100-meditation, 0, 100, 0, MAX_SCALE);
    //scaleFactor += (targetScale-scaleFactor)*0.01;
    //points = generateLeafs(round(pointsCount), scaleFactor);
    //println("ScaleFactor: " + scaleFactor);
    //println("PointsCount: " + pointsCount);
  }

  ArrayList generateLeafs(int size, float scaleFactor) {
    ArrayList leafs = new ArrayList();
    for (int i = 0; i < size; i++) {
      leafs.add(getLeaf(scaleFactor, size - i));
    }
    return leafs;
  }
  PVector getLeaf(float scaleFactor, int index) {
    float angle = index*THETA;
    float r = scaleFactor * sqrt(index)/sqrt(MAX_POINTS);

    float x = r * cos(angle);
    float y = r * sin(angle);
    return new PVector(x, y);
  }
}
