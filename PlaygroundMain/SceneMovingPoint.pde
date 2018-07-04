class SceneMovingPoint{
  PVector pos = new PVector(1,1);
  PVector speed = new PVector(5,5);
  
  SceneMovingPoint(){
  }
  
  void draw(GridRenderer render){
    render.point(pos.x, pos.y, 0.5);
  }
  
  void update(float dt){
    pos.x += speed.x * dt;
    pos.y += speed.y * dt;
  }
}
