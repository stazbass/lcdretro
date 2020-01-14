class ScenePhyllotaxis extends BaseObject {
  final int POINTS_NUMBER = 10000;
  float PHYLO_ANGLE = 137.5;
  float theta = PI * (3 - sqrt(5));
  float scaleFactor = 3;
  float indexScale = 1.0;
  ArrayList<PVector> points = new ArrayList();

  public ScenePhyllotaxis() {
    points = generateLeafs(POINTS_NUMBER, scaleFactor);
  }

  void draw() {
    PVector center = new PVector(grid.width/2.0, grid.height/2.0);
    PVector center2 = new PVector(-grid.width/2.0, -grid.height/2.0);
    PVector center3 = new PVector(grid.width/2.0, -grid.height/2.0);

    for (PVector point : points) {
      println(PVector.angleBetween(point, center));
      render.point(point.x +center.x, point.y + center.y, 1.0, color(PVector.angleBetween(point, center)*255/PI, PVector.angleBetween(point, center2)*255/PI, PVector.angleBetween(point, center3)*255/PI));
    }
  }
  void update(float dt) {
    if(isKeyPressed('a')){
      PHYLO_ANGLE -= 0.1;
    }
    if(isKeyPressed('d')){
      PHYLO_ANGLE += 0.1;
    }
    points = generateLeafs(POINTS_NUMBER, scaleFactor);
  }
  
  ArrayList generateLeafs(int size, float scaleFactor) {
    ArrayList leafs = new ArrayList();
    for (int i = 0; i < size; i++) {
      leafs.add(getLeaf(scaleFactor, i));
    }
    return leafs;
  }
  PVector getLeaf(float c, int index) {
    float angle = index*theta;
    float r = c * sqrt(index);

    float x = r * cos(angle);
    float y = r * sin(angle);
    return new PVector(x, y);
  }


}
