class MovingPoint{
  PVector pos;
  float speed = 100.0;
  PVector dir;
  int maxX;
  int maxY;
  boolean alive = true;
  PVector nextPosition = new PVector();
  
  MovingPoint(int maxx, int maxy){
    pos = new PVector((float)(maxx * Math.random()), (float)(maxy * Math.random()));
    dir = new PVector(random(-1, 1), random(-1, 1));
    nextPosition = movePoint(pos.copy(), dir, speed, 1.0/50.0);
    this.maxX = maxx;
    this.maxY = maxy;
  }
  
  void checkBoundaries(){
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
  }
  
  void recalcPosition(PVector newPosition, float dt){
    pos.set(newPosition);
    nextPosition.x = pos.x;
    nextPosition.y = pos.y;
    nextPosition = movePoint(nextPosition, dir, speed, dt);
  }
  
  void update(float dt){
    checkBoundaries();
    
    pos.x = nextPosition.x;
    pos.y = nextPosition.y;

    nextPosition = movePoint(nextPosition, dir, speed, dt);
  }
  
  PVector movePoint(PVector point, PVector dir, float speed, float dt){
    point.x += dir.x*speed*dt;
    point.y += dir.y*speed*dt;
    return point;
  }
}