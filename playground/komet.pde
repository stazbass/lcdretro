class Kometka{
  PVector pos = new PVector(320, 240);
  float speed = 1550;
  PVector dir = new PVector(speed*random(0, 1), speed*random(0, 1));
  ImpulseGrid grid;
  
  Kometka(ImpulseGrid grid){
    this.grid = grid;
  }
  
  void draw(){
    grid.getCellAt(pos.x,pos.y).applyImpulse(1.0);
  }
  
  void update(float dt){
    pos.x += dir.x*dt;
    pos.y += dir.y*dt;
    if(pos.x > screenW){
      pos.x = screenW;
      dir.x = -dir.x;
    }
    if(pos.x < 0){
      pos.x = 0;
      dir.x = -dir.x;
    }
    if(pos.y > screenH){
      pos.y = screenH;
      dir.y = -dir.y;
    }
    if(pos.y < 0){
      pos.y = 0;
      dir.y = -dir.y;
    }
  }
}