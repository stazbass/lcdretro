class Bitka{
  GridRenderer grid;
  float xpos;
  float ypos;
  Box box;
  
  Bitka(GridRenderer grid){
    this.grid = grid;
    box = new Box(30, 4);
  }
  
  void draw(){
    PVector [] vertices = box.getVertices();
    grid.line(vertices[0].x,vertices[0].y,vertices[1].x,vertices[1].y);
    grid.line(vertices[1].x,vertices[1].y,vertices[2].x,vertices[2].y);
    grid.line(vertices[2].x,vertices[2].y,vertices[3].x,vertices[3].y);
    grid.line(vertices[3].x,vertices[3].y,vertices[0].x,vertices[0].y);
  }
  
  boolean checkCollision(PVector point){
    //if(point.x > lu.x && point.x < rd.x && point.y > lu.y && point.y < rd.y)return true;
    return false;
  }
  
  void update(float dt){
    xpos = mouseX/10;
    ypos = 5;
    box.moveTo(xpos, 10);
    box.rot(frameCount/50.0);
  }
}
