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
Ball ball;
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
  ball = new Ball(render);
  
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
  updateAll(1.0/100.0);
  
  videoCapture();
  printfps();
}

void drawAll(){
  ball.draw();
  bitka.draw();
  grid.draw();
}

void updateAll(float delta){
  if(bitka.checkCollision(ball.point, delta)){
    ball.point.dir.y *= -1;
  }
  ball.update(delta);
  bitka.update(delta);
  grid.update(delta);  
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
