int screenWidth = 640;
int screenHeight = 480;
int cellWidth = 10;
int cellHeight = 10;
int gridWidth = screenWidth / cellWidth;
int gridHeight = screenHeight / cellHeight;

Grid grid = new Grid(640/10, 480/10, 5, 5);

void setup(){
  size(640, 480);
  stroke(100, 100);
  fill(200);
  rectMode(CENTER);
  background(100);
}

PVector pos = new PVector(320, 240);
PVector dir = new PVector(50*random(0, 1), 50*random(0, 1));

long lastFrame = millis();

float lastMouseX = mouseX;

void draw(){
  long frame = millis();
  float delta = (frame - lastFrame)/1000.0;
  lastFrame = frame;
  clear();
  grid.clearCells();
  grid.setValue(pos.x, pos.y);
  
  float newMouseX = lastMouseX + (mouseX - lastMouseX)*delta;
  lastMouseX = newMouseX;
  
  float bitPos = newMouseX - newMouseX%10;
  grid.setValue(bitPos, 105);
  grid.setValue(bitPos+10, 105);
  grid.setValue(bitPos+20, 105);
  grid.setValue(bitPos+30, 105);
  grid.setValue(bitPos+40, 105);
  grid.setValue(bitPos+50, 105);
  
  pos.x += dir.x*delta;
  pos.y += dir.y*delta;
  if(pos.x > 640){
    pos.x = 640;
    dir.x = -dir.x;
  }
  if(pos.x < 0){
    pos.x = 0;
    dir.x = -dir.x;
  }
  if(pos.y > 480){
    pos.y = 480;
    dir.y = -dir.y;
  }
  if(pos.y < 0){
    pos.y = 0;
    dir.y = -dir.y;
  }
  grid.draw();
}
