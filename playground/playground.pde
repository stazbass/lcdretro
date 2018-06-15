import com.hamoid.*;
import shiffman.box2d.*;


final boolean PERFORM_RECORDING = false;
final int SCREEN_WIDTH = 1024;
final int SCREEN_HEIGHT = 768;
final int CELL_WIDTH = 11;
final int CELL_HEIGHT = CELL_WIDTH;

final int MAX_LINES = 0;

VideoExport videoExport;
long lastFrame;

ImpulseGrid grid;
GridRenderer render;
Bitka bitka;
ArrayList<Ball> balls = new ArrayList<Ball>();
// ------------
void setup() {
  size(1024, 768);
  smooth();
  //fullScreen();
  background(0);
  stroke(70);
  fill(200);
  rectMode(CENTER);
  frameRate(100);
  lastFrame = millis();
  
  grid = new ImpulseGrid(width/CELL_WIDTH, height/CELL_HEIGHT, CELL_WIDTH, CELL_HEIGHT, CELL_WIDTH/2, CELL_HEIGHT/2);
  println("Grid size: " + grid.width + " : " + grid.height);
  render = new GridRenderer(grid);
  bitka = new Bitka(render);
  balls = new ArrayList();
  balls.add(new Ball(render));
  
  if(PERFORM_RECORDING){
    videoExport = new VideoExport(this, "interactive.mp4");
    videoExport.startMovie();
  }
}

void draw() {
  long frame = millis();
  //float delta = (frame - lastFrame)/1000.0;
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
  grid.draw();
}

void updateAll(float delta){
  for(Ball b : balls){
     if(bitka.checkCollision(b.point, delta)){
      b.point.dir.y *= -1;
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
  }
  
  bitka.update(delta);
  grid.update(delta);  
  if(frameCount%20 == 0)balls.add(new Ball(render));
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
