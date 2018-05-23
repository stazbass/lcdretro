import com.hamoid.*;

int screenW = 1920;
int screenH = 1200;
int cellWidth = 10;
int cellHeight = 10;
int gridWidth = screenW / cellWidth;
int gridHeight = screenH / cellHeight;
int KOMETKAS_COUNT = 0;
int INITIAL_SIZE = 3000;

ArrayList<Kometka> kometkas = new ArrayList();
long lastFrame = millis();
float lastMouseX = mouseX;
ImpulseGrid grid = new ImpulseGrid(gridWidth, gridHeight, cellWidth, cellHeight, 0, 0);
Bitka bitka = new Bitka(grid);
VideoExport videoExport;

// ------------
void setup() {
  //size(1024, 768);
  fullScreen();
  stroke(100, 100);
  fill(200);
  rectMode(CENTER);
  background(100);
  frameRate(100);

  for (int i = 0; i < INITIAL_SIZE; i++) {
    kometkas.add(new Kometka(grid));
  }
}

void drawMouse(){
  grid.getCellAt(mouseX, mouseY).applyImpulse(1.0);
}

void draw() {
  clear();

  long frame = millis();
  float delta = (frame - lastFrame)/1000.0;
  lastFrame = frame;

  double creationSinus = abs((float)Math.sin((millis()/ 100.0)%(Math.PI*2)));
  if (Math.random() > creationSinus/2.0) {
    kometkas.add(new Kometka(grid));
  } else {
    if (kometkas.size() > 0) {
      kometkas.remove(0);
    }
  }
for (Kometka k : kometkas) {
    k.draw();
    k.update(delta);
  }
  
  drawMouse();

  grid.draw();
  grid.update(delta);
}

void processExit() {
  exit();
}

void keyPressed() {
  if (key == 'q') {
    processExit();
  }
}