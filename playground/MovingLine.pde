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
    render.circle(p1.pos,5, 1);
    render.circle(p2.pos,5, 1);
    render.circleAlt(p1.pos,5, 1);
    render.circleAlt(p2.pos,5, 1);
    render.line(p1.pos.x,p1.pos.y,p2.pos.x,p2.pos.y, 1);
  }
  
  void update(float delta){
    p1.update(delta);
    p2.update(delta);
  }
}