import com.hamoid.*;

final boolean PERFORM_RECORDING = false;
final int SCREEN_WIDTH = 1920;
final int SCREEN_HEIGHT = 1200;
final int CELL_WIDTH = 20;
final int CELL_HEIGHT = CELL_WIDTH;

final int MAX_LINES = 20;

VideoExport videoExport;
long lastFrame;

ImpulseGrid grid;
GridRenderer render;
ArrayList<MovingLine> lines = new ArrayList<MovingLine>(100);


// ------------
void setup() {
  //size(1024, 768);
  fullScreen();
  background(0);
  //fullScreen(P2D );
  stroke(70);
  fill(200);
  rectMode(CENTER);
  frameRate(100);
  lastFrame = millis();
  
  grid = new ImpulseGrid(width/CELL_WIDTH, height/CELL_HEIGHT, CELL_WIDTH, CELL_HEIGHT, CELL_WIDTH/2, CELL_HEIGHT/2);
  render = new GridRenderer(grid);
  for(int i =0 ;i < MAX_LINES; i++){
    lines.add(new MovingLine(grid.width, grid.height, render));
  }
  
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

void videoCapture(){
  if(PERFORM_RECORDING){
    videoExport.saveFrame();
  }
}

void printfps(){
  if(frameCount%100 == 0){
    println("FPS : " + frameRate);
  }
}

void drawAll(){
  for(MovingLine line : lines){
    line.draw();
  }
  grid.draw();
}

void updateAll(float delta){
  for(MovingLine line : lines){
    line.update(delta);
  }
  grid.update(delta);  
}

void processExit() {
  exit();
}

void keyPressed() {
  if (key == 'q') {
    processExit();
  }
  if(key == 'a'){
    lines.add(new MovingLine(grid.width, grid.height, render));
    println(lines.size());
  }
}