class SceneMovingPoint extends BaseObject{
  boolean enabled = true;
  ArrayList<MovingPoint> points = new ArrayList(1000);
  
  SceneMovingPoint(){
    for(int i = 0; i < 200; i++){
    points.add(new MovingPoint());
    }
  }
  
  void draw(){
    if(!enabled)return;
    for(MovingPoint pt : points){
      pt.draw();
    }
  }
  
  
  void update(float dt){
    if(!enabled)return;
    for(MovingPoint pt : points){
      pt.update(dt);
    }
    if(keys.get('a') != null && keys.get('a') == true){
      points.add(new MovingPoint());
      points.add(new MovingPoint());
      points.add(new MovingPoint());
      println("Points " + points.size());
    }
  }
}

class MovingPoint extends BaseObject{
  PVector pos;
  PVector nextPos;
  PVector speed;
  color col;
  
  MovingPoint(){
    pos = new PVector(random(0, render.grid.width), random(0, render.grid.height));
    nextPos = pos.copy();
    speed = new PVector(random(0,1)*100.0f, random(0,1)*100.0f);
    col = color(255*random(0,1), 255*random(0,1), 255*random(0, 1));
  }
  
  void draw(){
    super.draw();
    render.point(pos.x, pos.y, 1.0, col);
  }
  
  void update(float dt){
    super.update(dt);
    
    pos.x = nextPos.x;
    pos.y = nextPos.y;
    
    nextPos = new PVector(pos.x + speed.x * dt, pos.y+ speed.y * dt);
    if(nextPos.x > render.grid.width-1){
      nextPos.x = render.grid.width-1;
      speed.x *=-1;
    }
    if(nextPos.x < 0){
      nextPos.x = 0;
      speed.x *=-1;
    }
    if(nextPos.y > render.grid.height-1){
      nextPos.y = render.grid.height-1;
      speed.y *=-1;
    }
    if(nextPos.y < 0){
      nextPos.y = 0;
      speed.y *=-1;
    }
  }
  
  void checkCollision(Box b){
    Intersection.checkLineBoxIntersection(pos,nextPos, b);
  }
}