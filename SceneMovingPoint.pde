class SceneMovingPoint extends BaseObject {
  boolean enabled = true;
  ArrayList<MovingPoint> points = new ArrayList(1000);

  SceneMovingPoint() {
    for (int i = 0; i < 2; i++) {
      points.add(new MovingPoint());
    }
  }

  void draw() {
    if (!enabled)return;
    
    for (int i = 0; i < points.size(); i++) {
      points.get(i).draw();
    }
  }


  void update(float dt) {
    if (!enabled)return;
    for (MovingPoint pt : points) {
      pt.update(dt);
    }
    if (keys.get('a') != null && keys.get('a') == true) {
      points.add(new MovingPoint());
    }
    if(isKeyPressed('d') && !points.isEmpty()){
      points.remove(0);
    }
  }
}

class MovingPoint extends BaseObject {
  PVector pos;
  PVector nextPos;
  PVector speed;
  float speedNormalized;
  color col;

  MovingPoint() {
    reset();
  }
  
  void reset(){
    pos = new PVector(mouseX/grid.cellWidth, mouseY/grid.cellHeight);
    nextPos = pos.copy();
    speedNormalized = random(0.1, 100);
    speed = new PVector(sin(random(0, 2*PI))*speedNormalized, cos(random(0, 2*PI))*speedNormalized);
    col = color(240*random(0, 1), 240*random(0, 1), 240*random(0, 1));
  }

  void draw() {
    super.draw();
    render.point(pos.x, pos.y, 1, col);
    //render.circle(pos.x, pos.y, abs(render.grid.width/2 - pos.x)*2, 1, col);
  }

  void update(float dt) {
    super.update(dt);

    pos.x = nextPos.x;
    pos.y = nextPos.y;

    nextPos = new PVector(pos.x + speed.x * dt, pos.y+ speed.y * dt);
    if (nextPos.x > render.grid.width-1) {
      nextPos.x = render.grid.width-1;
      speed.x *=-1;
      reset();
    }
    if (nextPos.x < 0) {
      nextPos.x = 0;
      speed.x *=-1;
      reset();
    }
    if (nextPos.y > render.grid.height-1) {
      nextPos.y = render.grid.height-1;
      speed.y *=-1;
      reset();
    }
    if (nextPos.y < 0) {
      nextPos.y = 0;
      speed.y *=-1;
      reset();
    }
  }

  void checkCollision(Box b) {
    Intersection.checkLineBoxIntersection(pos, nextPos, b);
  }
}