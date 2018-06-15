import com.hamoid.*;
import shiffman.box2d.*;


final boolean PERFORM_RECORDING = false;
final int SCREEN_WIDTH = 1024;
final int SCREEN_HEIGHT = 768;
final int CELL_WIDTH = 5;
final int CELL_HEIGHT = CELL_WIDTH;

final int MAX_LINES = 0;

VideoExport videoExport;
long lastFrame;

ImpulseGrid grid;
GridRenderer render;
ArrayList<MovingLine> lines = new ArrayList<MovingLine>(100);
Bitka bitka;
LineChain chain;
// ------------
void setup() {
  size(1024, 768);
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
  chain = new LineChain(grid.width, grid.height, render);
  
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
  updateAll(1.0/60.0);
  
  videoCapture();
  printfps();
}

void drawAll(){
  for(MovingLine line : lines){
    line.draw();
  }
  chain.draw();
  bitka.draw();
  grid.draw();
}

void updateAll(float delta){
  for(MovingLine line : lines){
    line.update(delta);
    if(bitka.checkCollision(line.p1.pos)){
      line.p1.dir.mult(-1);
    line.update(delta);
    }
    if(bitka.checkCollision(line.p2.pos)){
      line.p2.dir.mult(-1);
    line.update(delta);
    }
  }
  chain.update(delta);
  bitka.update(delta);
  grid.update(delta);  
}

void keyPressed() {
  if (key == 'q') {
    processExit();
  }
  if(key == 'a'){
    for(int i = 0; i < 10; i++){
      lines.add(new MovingLine(grid.width, grid.height, render));
      println(lines.size());
    }
  }
  if(key == 'c'){
    chain.addPoint();
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
