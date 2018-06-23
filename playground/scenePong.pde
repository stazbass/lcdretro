class ScenePong{
  GridRenderer render;
  Ball ball;
  Bitka bitka;

  
  ScenePong(GridRenderer render){
    this.render = render;
    this.ball = new Ball(render);
    this.bitka = new Bitka(render);
  }
  void draw(){
    bitka.draw();
    ball.draw();
  }
  
  void update(float delta){
    bitka.update(delta);
    ball.update(delta);
  }
}