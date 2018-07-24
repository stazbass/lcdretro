class SceneMovingPoint extends BaseObject{
  boolean enabled = true;
  ArrayList<MovingPoint> points = new ArrayList(1000);
  
  SceneMovingPoint(){
    for(int i = 0; i < 10; i++){
    points.add(new MovingPoint());
    }
  }
  
  void draw(){
    if(!enabled)return;
    for(MovingPoint pt : points){
      pt.draw();
    }
    //for(int i = 0; i < points.size()-1; i++){
    //  MovingPoint p1 = points.get(i);
    //  MovingPoint p2 = points.get(i+1);
    //  render.line(p1.pos.x,p1.pos.y,p2.pos.x,p2.pos.y,1,p1.col);
    //}
  }
  
  
  void update(float dt){
    if(!enabled)return;
    for(MovingPoint pt : points){
      pt.update(dt);
    }
    if(isKeyPressed('a')){
      //for(int i = 0; i < points.size()/100; i++){
        points.add(new MovingPoint());
      //}
      println("Points " + points.size());
    }
    if(isKeyPressed('s')){
      //for(int i = 0; i < 10; i++){
      //  if(points.size() > 0)
      //  points.remove(0);
      //  else break;
      //}
    }
  }
}

class MovingPoint extends BaseObject{
  PVector pos;
  PVector nextPos;
  PVector speed;
  color col;
  boolean alive = true;
  
  MovingPoint(){
    //pos = new PVector(sin((frameCount%180)*PI/180.0)*grid.height, cos((frameCount%180)*PI/180.0)*grid.height);
    pos = new PVector(grid.width/2, grid.height/2);
    nextPos = pos.copy();
    speed = new PVector(sin(random(0,2*PI))*10.0f, cos(random(0,2*PI))*10.0f);
    col = color(255*random(0,1), 107*random(0,1), 100*random(0, 1));
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
      alive = false;
    }
    if(nextPos.x < 0){
      nextPos.x = 0;
      speed.x *=-1;
      alive = false;
    }
    if(nextPos.y > render.grid.height-1){
      nextPos.y = render.grid.height-1;
      speed.y *=-1;
      alive = false;
    }
    if(nextPos.y < 0){
      nextPos.y = 0;
      speed.y *=-1;
      alive = false;
    }
  }
  
  void checkCollision(Box b){
    Intersection.checkLineBoxIntersection(pos,nextPos, b);
  }
}