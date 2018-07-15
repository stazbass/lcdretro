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
  PVector speed;
  color col;
  
  MovingPoint(){
    pos = new PVector(random(0, render.grid.width), random(0, render.grid.height));
    speed = new PVector(random(0,1)*100.0f, random(0,1)*100.0f);
    col = color(50*random(0,1), 255*random(0,1), 50*random(0, 1));
  }
  
  void draw(){
    render.point(pos.x, pos.y, 1.0, col);
  }
  
  void update(float dt){
    PVector nextPoint = new PVector(pos.x + speed.x * dt, pos.y+ speed.y * dt);
    if(nextPoint.x > render.grid.width-1){
      nextPoint.x = render.grid.width-1;
      speed.x *=-1;
      pos.x += speed.x * dt;
    }
    if(nextPoint.x < 0){
      nextPoint.x = 0;
      speed.x *=-1;
      pos.x += speed.x * dt;      
    }
    if(nextPoint.y > render.grid.height-1){
      nextPoint.y = render.grid.height-1;
      speed.y *=-1;
      pos.y += speed.y * dt;
    }
    if(nextPoint.y < 0){
      nextPoint.y = 1;
      speed.y *=-1;
      pos.y += speed.y * dt;
    }
    
    
    pos.x += speed.x * dt;
    pos.y += speed.y * dt;
  }
}