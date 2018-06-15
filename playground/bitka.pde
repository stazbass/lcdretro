class Bitka{
  GridRenderer render;
  float xpos;
  float ypos;
  Box box;
  PVector [] vertices;
  
  Bitka(GridRenderer render){
    this.render = render;
    box = new Box(10, 1);
  }
  
  void draw(){
    vertices = box.getVertices();
    render.line(vertices[0].x,vertices[0].y,vertices[1].x,vertices[1].y);
    render.line(vertices[1].x,vertices[1].y,vertices[2].x,vertices[2].y);
    render.line(vertices[2].x,vertices[2].y,vertices[3].x,vertices[3].y);
    render.line(vertices[3].x,vertices[3].y,vertices[0].x,vertices[0].y);
  }
  PVector get_line_intersection(float p0_x, float p0_y, float p1_x, float p1_y, 
    float p2_x, float p2_y, float p3_x, float p3_y)
  {
      float s1_x, s1_y, s2_x, s2_y;
      s1_x = p1_x - p0_x;     s1_y = p1_y - p0_y;
      s2_x = p3_x - p2_x;     s2_y = p3_y - p2_y;
  
      float s, t;
      s = (-s1_y * (p0_x - p2_x) + s1_x * (p0_y - p2_y)) / (-s2_x * s1_y + s1_x * s2_y);
      t = ( s2_x * (p0_y - p2_y) - s2_y * (p0_x - p2_x)) / (-s2_x * s1_y + s1_x * s2_y);
  
      if (s >= 0 && s <= 1 && t >= 0 && t <= 1)
      {
          // Collision detected
          return new PVector(p0_x + (t * s1_x),p0_y + (t * s1_y)) ;
      }
  
      return null; // No collision
  }
  boolean checkCollision(MovingPoint point, float delta){
    PVector start = point.pos.copy();
    PVector end = point.dir.copy().mult(delta).add(start);
    
    PVector i = get_line_intersection(start.x, start.y, end.x, end.y, vertices[0].x, vertices[0].y, vertices[1].x, vertices[1].y);
    if(i != null){
      return true;
    }
    i = get_line_intersection(start.x, start.y, end.x, end.y, vertices[2].x, vertices[2].y, vertices[3].x, vertices[3].y);
    if(i != null){
      return true;
    }
    return false;
  }
  
  void update(float dt){
    xpos = mouseX/render.grid.cellWidth;
    ypos = 5;
    box.moveTo(xpos, render.grid.height-2);
  }
}
