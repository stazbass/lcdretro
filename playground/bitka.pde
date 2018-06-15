class Bitka{
  GridRenderer grid;
  int segments = 15;
  int bitkaHeight = 1;
  float xpos;
  float ypos;
  Box box;
  
  Bitka(GridRenderer grid){
    this.grid = grid;
    box = new Box(20, 4);
  }
  
  void draw(){
    PVector [] vertices = box.getVertices();
    for(int i = 0; i < vertices.length-1; i++){
      grid.line(vertices[i].x,vertices[i].y,vertices[i+1].x,vertices[i+1].y);
    }
      grid.line(vertices[0].x,vertices[0].y,vertices[vertices.length-1].x,vertices[vertices.length-1].y);
  }
  
  boolean checkCollision(PVector point){
    //if(point.x > lu.x && point.x < rd.x && point.y > lu.y && point.y < rd.y)return true;
    return false;
  }
  
  void update(float dt){
    xpos = mouseX/10;
    ypos = 5;
    box.moveTo(xpos, 10);
    float angle = frameCount%360 * dt * PI/180.0;
    box.rot(angle);
  }
}