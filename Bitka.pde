class Bitka extends BaseObject {
  float xpos;
  float ypos;
  ArrayList<Box> boxes = new ArrayList();
  PVector [] vertices;
  Edge [] edges;
  float radius = 100;

  Bitka() {
    for (int i = 0; i < 20; i++) {
      addBox(i);
    }
  }

  void addBox(int index) {
    boxes.add(new Box(sin(index/(random(0,3)*PI))*radius*random(0.7,4.0), cos(index/(random(0,3)*PI))*radius*random(0.7,4)));
  }
  
  void removeBox(){
    if(boxes.size() > 0){
      boxes.remove(boxes.get(floor(boxes.size()*random(0,1))));
    }
  }

  void draw() {
    super.draw();
    for (int i = 0; i < boxes.size(); i++) {
      vertices = boxes.get(i).getVertices();
      render.line(vertices[0].x, vertices[0].y, vertices[1].x, vertices[1].y, 1.0, color(#527f74));
      render.line(vertices[1].x, vertices[1].y, vertices[2].x, vertices[2].y, 1.0, color(#ba5b3e));
      render.line(vertices[2].x, vertices[2].y, vertices[3].x, vertices[3].y, 1.0, color(#de333c));
      render.line(vertices[3].x, vertices[3].y, vertices[0].x, vertices[0].y, 1.0, color(#de2d64));
    }
  }
//******************** Perceptual ColorPicker colors ********************

  PVector [] getEdge() {
    return new PVector[]{vertices[0], vertices[1]};
  }

  void update(float dt) {
    super.update(dt);
    if (isKeyPressed('a')) {
      addBox(boxes.size());
    }
    if(isKeyPressed('d')){
      removeBox();
    }
    float xLocal = mouseX/grid.cellWidth;
    float yLocal = mouseY/grid.cellHeight;
    xpos = xLocal;//(1920-mouseX)/2/grid.cellWidth;
    ypos = yLocal;//(1200-mouseY)/2/grid.cellHeight;
    for (Box b : boxes) {
      b.rot(PI/(sin(frameCount/(2*PI))));
      int frameIndex = boxes.indexOf(b) + frameCount;
      b.moveTo(xpos + sin( 2*PI/frameIndex), 
               ypos + cos( 2*PI/frameIndex));
    }
  }
}
