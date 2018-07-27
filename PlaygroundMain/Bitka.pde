class Bitka extends BaseObject{
  float xpos;
  float ypos;
  ArrayList<Box> box = new ArrayList();
  PVector [] vertices;
  Edge [] edges;
  
  Bitka(){
    for(int i = 0; i < 30; i++){
    box.add(new Box(sin(i*PI/180)*20,cos(i*PI/180)*20));
    }
    
  }
  
  void draw(){
    super.draw();
    for(int i = 0; i < box.size(); i++){
      vertices = box.get(i).getVertices();
      render.line(vertices[0].x,vertices[0].y,vertices[1].x,vertices[1].y, 1.0, color(87*random(0.5,1), 24*random(0.5,1), 69*random(0.5,1)));
      render.line(vertices[1].x,vertices[1].y,vertices[2].x,vertices[2].y, 1.0, color(144*random(0.5,1), 12*random(0.5,1), 62*random(0.5,1)));
      render.line(vertices[2].x,vertices[2].y,vertices[3].x,vertices[3].y, 1.0, color(255*random(0.5,1), 87*random(0.5,1), 51*random(0.5,1)));
      render.line(vertices[3].x,vertices[3].y,vertices[0].x,vertices[0].y, 1.0, color(255*random(0.5,1), 195*random(0.5,1), 0));
    }
  }
  
  PVector [] getEdge(){
    return new PVector[]{vertices[0], vertices[1]};
  }
  
  void update(float dt){
    if(isKeyPressed('b'))box.add(new Box(sin(box.size()*PI/180)*40*random(0.5,1),cos(box.size()*PI/180)*40*random(0.5,1)));
    if(isKeyPressed('n') && box.size() > 0)box.remove(box.size()-1);
    super.update(dt);
    xpos = (1920-mouseX)/grid.cellWidth;
    ypos = (1200-mouseY)/grid.cellHeight;
    for(Box b : box){
      b.moveTo(xpos + sin(frameCount/PI+box.indexOf(b)/PI)*30 , ypos + cos(frameCount/PI + box.indexOf(b)/PI)*30);
      b.rot(sin(PI*box.indexOf(b)/180));
    }
  }
}