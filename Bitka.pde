class Bitka extends BaseObject{
  float xpos;
  float ypos;
  ArrayList<Box> box = new ArrayList();
  PVector [] vertices;
  Edge [] edges;
  
  Bitka(){
    for(int i = 0; i < 20; i++){
    box.add(new Box(sin(i/PI)*30,cos(i/PI)*30));
    }
    
  }
  
  void draw(){
    super.draw();
    for(int i = 0; i < box.size(); i++){
      vertices = box.get(i).getVertices();
      render.line(vertices[0].x,vertices[0].y,vertices[1].x,vertices[1].y, 1.0, color(0, 255, 200));
      render.line(vertices[1].x,vertices[1].y,vertices[2].x,vertices[2].y, 1.0, color(0, 0, 255));
      render.line(vertices[2].x,vertices[2].y,vertices[3].x,vertices[3].y, 1.0, color(255, 0, 255));
      render.line(vertices[3].x,vertices[3].y,vertices[0].x,vertices[0].y, 1.0, color(0, 255, 255));
    }
  }
  
  PVector [] getEdge(){
    return new PVector[]{vertices[0], vertices[1]};
  }
  
  void update(float dt){
    super.update(dt);
    xpos = (1920-mouseX)/grid.cellWidth;
    ypos = (1200-mouseY)/2/grid.cellHeight;
    for(Box b : box){
      b.moveTo(xpos + sin(frameCount/PI+box.indexOf(b)/PI)*30 , ypos + cos(frameCount/PI + box.indexOf(b)/PI)*30);
    }
  }
}