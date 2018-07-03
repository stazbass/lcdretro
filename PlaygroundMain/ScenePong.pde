class ScenePong{
  public final int BALLS_INITIAL = SceneConfig.BALLS_COUNT;
  GridRenderer render;
  Ball ball;
  Bitka bitka;
  ArrayList<Ball> balls = new ArrayList();
  
  ScenePong(GridRenderer render){
    this.render = render;
    this.ball = new Ball(render);
    this.bitka = new Bitka(render);
    addBall(BALLS_INITIAL);
  }
  
  void addBall(int cnt){
    for(int i = 0; i < cnt; i++){
      balls.add(new Ball(render));
    }
  }
  
  void draw(){
    bitka.draw();
    ball.draw();
    for(Ball b : balls){
      b.draw();
    }
  }
  
  void update(float delta){
    delta = mouseX != 0 ? 1.0/mouseX : delta;
    checkCollisions(delta);
    bitka.update(delta);
    ball.update(delta);
    for(Ball b : balls){
      b.update(delta);
    }
    if(frameCount%10 == 0){
      addBall((int)random(10, 30));
    }
 }
 
 void checkCollisions(float delta){
   PVector[] intersection;
   for(Ball b : balls){
     if( (intersection = Intersection.checkLineBoxIntersection(b.point.pos,b.point.nextPosition,bitka.box)) !=null ){
       b.point.dir = Intersection.getReflectedVector(b.point.dir, intersection[1]);
       b.point.pos.set(intersection[0]);
       b.point.nextPosition = intersection[0];
       //b.size = b.size+1;
       b.update(delta);
     }
   }
 }

}
