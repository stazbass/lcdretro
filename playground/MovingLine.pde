class MovingLine{
  MovingPoint p1;
  MovingPoint p2;
  GridRenderer render;
  
  MovingLine(int maxx, int maxy, GridRenderer render){
    p1 = new MovingPoint(maxx, maxy);
    p2 = new MovingPoint(maxx, maxy);
    this.render = render;
  }
  
  MovingLine(MovingPoint p1, MovingPoint p2, GridRenderer render){
    this.p1 = p1;
    this.p2 = p2;
    this.render = render;
  }
  
  void draw(){
    render.line(p1.pos.x,p1.pos.y,p2.pos.x,p2.pos.y);
  }
  
  boolean connectedToBall(Ball b){
    if(p1 == b.point || p2 == b.point)return true;else return false;
  }
  void update(float delta){
    p1.update(delta);
    p2.update(delta);
  }
}
