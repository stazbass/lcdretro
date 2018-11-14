class Bitka extends BaseObject {
  float xpos;
  float ypos;
  ArrayList<Box> box = new ArrayList();
  PVector [] vertices;
  Edge [] edges;
  float radius = 100;

  Bitka() {
    for (int i = 0; i < 20; i++) {
      addBox(i);
    }
  }

  void addBox(int index) {
    box.add(new Box(sin(index/PI)*radius*random(0.7,1.0), cos(index/PI)*radius*random(0.7,1)));
  }

  void draw() {
    super.draw();
    for (int i = 0; i < box.size(); i++) {
      vertices = box.get(i).getVertices();
      render.line(vertices[0].x, vertices[0].y, vertices[1].x, vertices[1].y, 1.0, color(230, 0, 255));
      render.line(vertices[1].x, vertices[1].y, vertices[2].x, vertices[2].y, 1.0, color(230, 70, 255));
      render.line(vertices[2].x, vertices[2].y, vertices[3].x, vertices[3].y, 1.0, color(230, 150, 255));
      render.line(vertices[3].x, vertices[3].y, vertices[0].x, vertices[0].y, 1.0, color(230, 250, 255));
    }
  }

  PVector [] getEdge() {
    return new PVector[]{vertices[0], vertices[1]};
  }

  void update(float dt) {
    super.update(dt);
    if (isKeyPressed('a')) {
      addBox(box.size());
    }
    float xLocal = mouseX/grid.cellWidth;
    float yLocal = mouseY/grid.cellHeight;
    xpos = xLocal;//(1920-mouseX)/2/grid.cellWidth;
    ypos = yLocal;//(1200-mouseY)/2/grid.cellHeight;
    for (Box b : box) {
      b.rot(PI/(frameCount/(2*PI)));
      int frameIndex = box.indexOf(b) + frameCount;
      b.moveTo(xpos + sin( 2*PI/frameIndex), 
               ypos + cos( 2*PI/frameIndex));
    }
  }
}
