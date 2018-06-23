class MovingPoint{
  PVector pos;
  float speed;
  PVector dir;
  int maxX;
  int maxY;
  boolean alive = true;
  PVector nextPosition = new PVector();
  
  MovingPoint(int maxx, int maxy){
    nextPosition = new PVector((float)(maxx * Math.random()), (float)(maxy * Math.random()));
    pos = nextPosition.copy();
    speed = 50.0;
    dir = new PVector(random(-1, 1), random(-1, 1));
    this.maxX = maxx;
    this.maxY = maxy;
  }
  
  MovingPoint(PVector pos, int maxx, int maxy){
    this.pos = pos.copy();
    speed = 10;
    dir = new PVector(random(-1, 1), random(-1, 1));
    dir.normalize();
    dir.mult(speed);
    this.maxX = maxx;
    this.maxY = maxy;
  }
  
  
  void update(float dt){
    
    pos.x = nextPosition.x;
    pos.y = nextPosition.y;
    

    if(nextPosition.x > maxX){
      pos.x = maxX;
      dir.x = -dir.x;
    }
    if(nextPosition.x < 0){
      pos.x = 0;
      dir.x = -dir.x;
    }
    if(nextPosition.y > maxY){
      pos.y = maxY;
      dir.y = -dir.y;
      alive = false;
    }
    if(nextPosition.y < 0){
      pos.y = 0;
      dir.y = -dir.y;
    }
    nextPosition.x += dir.x*dt*speed;
    nextPosition.y += dir.y*dt*speed;
  }
}