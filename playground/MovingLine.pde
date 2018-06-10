class MovingLine{
  MovingPoint p1;
  MovingPoint p2;
  GridRenderer render;
  
  MovingLine(int maxx, int maxy, GridRenderer render){
    p1 = new MovingPoint(maxx, maxy);
    p2 = new MovingPoint(maxx, maxy);
    this.render = render;
  }
  
  void draw(){
    render.line(p1.pos.x,p1.pos.y,p2.pos.x,p2.pos.y);
  }
  
  void update(float delta){
    p1.update(delta);
    p2.update(delta);
  }
}