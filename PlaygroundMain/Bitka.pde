class Bitka extends BaseObject{
  float xpos;
  float ypos;
  Box box;
  PVector [] vertices;
  Edge [] edges;
  
  Bitka(){
    box = new Box(20,7);
  }
  
  void draw(){
    super.draw();
    vertices = box.getVertices();
    render.line(vertices[0].x,vertices[0].y,vertices[1].x,vertices[1].y, 1.0, color(0, 0, 255));
    render.line(vertices[1].x,vertices[1].y,vertices[2].x,vertices[2].y, 1.0, color(0, 0, 255));
    render.line(vertices[2].x,vertices[2].y,vertices[3].x,vertices[3].y, 1.0, color(0, 0, 255));
    render.line(vertices[3].x,vertices[3].y,vertices[0].x,vertices[0].y, 1.0, color(0, 0, 255));
  }
  
  PVector [] getEdge(){
    return new PVector[]{vertices[0], vertices[1]};
  }
  
  void update(float dt){
    super.update(dt);
    xpos = mouseX/grid.cellWidth;
    ypos = 15;
    box.moveTo(xpos, grid.height/2);
  }
}
