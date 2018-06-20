class Ball{
  MovingPoint point;
  GridRenderer render;
  
  Ball(GridRenderer render){
    point = new MovingPoint(render.grid.width-1, render.grid.height-1);
    this.render = render;
  }
  
  void draw(){
    render.point(point.pos.x, point.pos.y, 1.0);    
  }
  
  void update(float dt){
    point.update(dt);
  }
}
