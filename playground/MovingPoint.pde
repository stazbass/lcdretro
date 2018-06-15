class MovingPoint{
  PVector pos;
  float speed;
  PVector dir;
  int maxX;
  int maxY;
  boolean alive = true;
  
  MovingPoint(int maxx, int maxy){
    pos = new PVector((float)(maxx * Math.random()), (float)(maxy * Math.random()));
    speed = 100*Math.random();
    dir = new PVector(speed*random(0, 1) - speed/2, speed*random(0, 1) - speed/2);
    this.maxX = maxx;
    this.maxY = maxy;
  }
  
  MovingPoint(PVector pos, int maxx, int maxy){
    this.pos = pos.copy();
    speed = 240;
    dir = new PVector(random(-1, 1), random(-1, 1));
    dir.normalize();
    dir.mult(speed);
    this.maxX = maxx;
    this.maxY = maxy;
  }
  
  
  void update(float dt){
    pos.x += dir.x*dt;
    pos.y += dir.y*dt;
    if(pos.x > maxX){
      pos.x = maxX;
      dir.x = -dir.x;
    }
    if(pos.x < 0){
      pos.x = 0;
      dir.x = -dir.x;
    }
    if(pos.y > maxY){
      pos.y = maxY;
      dir.y = -dir.y;
      alive = false;
    }
    if(pos.y < 0){
      pos.y = 0;
      dir.y = -dir.y;
    }
  }
}
