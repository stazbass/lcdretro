int screenW = 1524;
int screenH = 768;
int cellWidth = 10;
int cellHeight = 10;
int gridWidth = screenW / cellWidth;
int gridHeight = screenH / cellHeight;
int KOMETKAS_COUNT = 200;
PVector pos = new PVector(320, 240);
float speed = 1550;
PVector dir = new PVector(speed*random(0, 1), speed*random(0, 1));
Kometka [] kometkas = new Kometka[KOMETKAS_COUNT];
long lastFrame = millis();

float lastMouseX = mouseX;
ImpulseGrid grid = new ImpulseGrid(gridWidth, gridHeight, 5, 5);
Bitka bitka = new Bitka(grid);

void setup(){
  size(1524, 768);
  stroke(100, 100);
  fill(200);
  rectMode(CENTER);
  background(100);
  for(int i = 0; i < KOMETKAS_COUNT; i++){
    kometkas[i] = new Kometka(grid);
  }
}
void draw(){
  clear();
  
  long frame = millis();
  float delta = (frame - lastFrame)/1000.0;
  lastFrame = frame;
  for(int i = 0 ; i < KOMETKAS_COUNT; i++){
    kometkas[i].draw();
    kometkas[i].update(delta);
  }
  grid.getCellAt(mouseX, mouseY).applyImpulse(0.2);
  

  grid.draw();
  grid.update(delta);
  
  bitka.draw();
  bitka.update(delta);
}