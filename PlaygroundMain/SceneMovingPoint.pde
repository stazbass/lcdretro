class SceneMovingPoint extends BaseObject{
  PVector pos = new PVector(1,1);
  PVector speed = new PVector(5,5);
  boolean enabled = true;
  
  SceneMovingPoint(){
  }
  
  void draw(GridRenderer render){
    if(!enabled)return;
    render.point(pos.x, pos.y, 0.5);
  }
  
  void update(float dt){
    if(!enabled)return;
    pos.x += speed.x * dt;
    pos.y += speed.y * dt;
  }
}
