import com.hamoid.*;
import shiffman.box2d.*;


final boolean PERFORM_RECORDING = false;
final int SCREEN_WIDTH = 1500;
final int SCREEN_HEIGHT = 1000;
final int CELL_WIDTH = 10;
final int CELL_HEIGHT = CELL_WIDTH;

final int MAX_LINES = 0;

VideoExport videoExport;
long lastFrame;

ImpulseGrid grid;
GridRenderer render;
Bitka bitka;
ArrayList<Ball> balls = new ArrayList<Ball>(1000);
Ball prevBall;
ArrayList<MovingLine> lines = new ArrayList<MovingLine>(1000);
PVector circleCenter;
float circleRadius;

// ------------
void setup() {
  size(1024, 768);
  smooth();
  //fullScreen();
  background(0);
  stroke(210);
  fill(100);
  rectMode(CENTER);
  frameRate(100);
  strokeWeight(1);
  lastFrame = millis();
  
  grid = new ImpulseGrid(width/CELL_WIDTH, height/CELL_HEIGHT, CELL_WIDTH, CELL_HEIGHT, CELL_WIDTH/2, CELL_HEIGHT/2);
  println("Grid size: " + grid.width + " : " + grid.height);
  render = new GridRenderer(grid);
  bitka = new Bitka(render);
  balls = new ArrayList();
  balls.add(new Ball(render));
  circleCenter = new PVector(grid.width/2.0, grid.height/2.0);
  circleRadius = 15;

  if(PERFORM_RECORDING){
    videoExport = new VideoExport(this, "interactive.mp4");
    videoExport.startMovie();
  }
}

void draw() {
  long frame = millis();
  float delta = (frame - lastFrame)/1000.0;
  lastFrame = frame;
  
  
  clear();
  
  drawAll();
  updateAll(1.0/50.0);
  
  videoCapture();
  printfps();
}

void drawAll(){
  for(Ball b : balls){
    b.draw();
  }
  bitka.draw();

  render.circleAlt(circleCenter.x,circleCenter.y,15);
  render.circle(circleCenter.x, circleCenter.y,15);
  
  render.circle(circleCenter.x, circleCenter.y,9);
  render.circleAlt(circleCenter.x, circleCenter.y,9);
  render.circle(circleCenter.x, circleCenter.y,5);
  render.circleAlt(circleCenter.x, circleCenter.y,5);
  render.circle(circleCenter.x, circleCenter.y,3);
  render.circleAlt(circleCenter.x, circleCenter.y,3);


  for(MovingLine line : lines){
    line.draw();
  }
  grid.draw();
}

void updateAll(float delta){
  for(Ball b : balls){
     if(bitka.checkCollision(b.point)){
      b.point.dir.y *= -1;
      b.update(delta);
    }
    if(Intersection.checkLineCircleIntersect(b.point.pos, b.point.nextPosition, circleCenter, circleRadius)){
      b.point.dir = Intersection.getReflectedVector(b.point.dir, PVector.sub(b.point.pos, circleCenter).normalize());
      b.update(delta);
      println("Intersection");
    }
    b.update(delta);
  }
  ArrayList<Ball> candidates = new ArrayList<Ball>();
  for(Ball b : balls){
    if(!b.point.alive){
      candidates.add(b);
    }
  }
  for(Ball b : candidates){
    balls.remove(b);
    for(int i = 0; i < lines.size(); i++){
      if(lines.get(i).connectedToBall(b)){
        lines.remove(lines.get(i));
        i--;
      }
    }
  }
  
  bitka.update(delta);
  grid.update(delta);  
  if(frameCount%5== 0 && balls.size()<20){
    Ball newBall = new Ball(render);
    if(prevBall != null && frameCount%100 == 0){
      lines.add(new MovingLine(prevBall.point, newBall.point, render));
      prevBall = null;
    }
    balls.add(newBall);
    prevBall = newBall;
  };
}

void keyPressed() {
  if (key == 'q') {
    processExit();
  }
  if(key == 'a'){

  }
  if(key == 'c'){
  }
}

void printfps(){
  if(frameCount%100 == 0){
    println("FPS : " + frameRate);
  }
}
void processExit() {
  exit();
}

void videoCapture(){
  if(PERFORM_RECORDING){
    videoExport.saveFrame();
  }
}
