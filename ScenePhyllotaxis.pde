class ScenePhyllotaxis extends BaseObject {
  final int POINTS_NUMBER = 1000;
  float PHYLO_ANGLE = 137.65;
  final float THETA = PI * (3.0 - sqrt(5));
  float scaleFactor = 3.0;
  ArrayList<PVector> points = new ArrayList();

  public ScenePhyllotaxis() {
    points = generateLeafs(1, scaleFactor);
  }

  void draw() {
    PVector center = new PVector(grid.width/2.0, grid.height/2.0);
    for (PVector point : points) {
      point.rotate(3*frameCount*PI/180.0);
      render.point(point.x +center.x, point.y + center.y, 2.0);
    }
  }
  void update(float dt) {
    if(isKeyPressed('a')){
      scaleFactor -= 0.1;
    }
    if(isKeyPressed('d')){
      scaleFactor += 0.1;
    }
    scaleFactor = sin(.5*frameCount*PI/180.0)*4.0;
    points = generateLeafs(mouseX, scaleFactor);
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
