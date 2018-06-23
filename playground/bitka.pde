class Bitka{
  GridRenderer render;
  float xpos;
  float ypos;
  Box box;
  PVector [] vertices;
  Edge [] edges;
  
  Bitka(GridRenderer render){
    this.render = render;
    box = new Box(10, 1);
  }
  
  void draw(){
    vertices = box.getVertices();
    
    render.line(vertices[0].x,vertices[0].y,vertices[1].x,vertices[1].y, 1.0);
    render.line(vertices[1].x,vertices[1].y,vertices[2].x,vertices[2].y, 1.0);
    render.line(vertices[2].x,vertices[2].y,vertices[3].x,vertices[3].y, 1.0);
    render.line(vertices[3].x,vertices[3].y,vertices[0].x,vertices[0].y, 1.0);
  }
  
  
  
  void update(float dt){
    xpos = mouseX/render.grid.cellWidth;
    ypos = 5;
    box.moveTo(xpos, render.grid.height-2);
  }
}