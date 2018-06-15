class Ball{
  MovingPoint point;
  GridRenderer render;
  
  Ball(GridRenderer render){
    point = new MovingPoint(render.grid.width-1, render.grid.height-1);
    this.render = render;
  }
  
  void draw(){
    
  }
  
  void update(float dt){
    point.update(dt);
    render.point(point.pos.x, point.pos.y);
  }
}
