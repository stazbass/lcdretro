import com.hamoid.*;

int screenW = 1920;
int screenH = 1200;
int cellWidth = 13;
int cellHeight = 13;
int gridWidth = screenW / cellWidth;
int gridHeight = screenH / cellHeight;
int KOMETKAS_COUNT = 0;
int INITIAL_SIZE = 50;

ArrayList<Kometka> kometkas = new ArrayList();
long lastFrame = millis();
float lastMouseX = mouseX;
ImpulseGrid grid = new ImpulseGrid(gridWidth, gridHeight, cellWidth, cellHeight, 0, 0);
Bitka bitka = new Bitka(grid);
VideoExport videoExport;

// ------------
void setup() {
  size(1024, 768);
  //fullScreen();
  stroke(200, 200, 200);
  fill(70);
  rectMode(CENTER);
  background(100);
  frameRate(100);

  for (int i = 0; i < INITIAL_SIZE; i++) {
    kometkas.add(new Kometka(grid));
  }
}

void draw() {
  clear();

  long frame = millis();
  float delta = (frame - lastFrame)/1000.0;
  lastFrame = frame;

  double creationSinus = abs((float)Math.sin((millis()/ 3.0)%(Math.PI*2)));
  println(creationSinus);
  if (Math.random()*2 > creationSinus) {
    println("Adding");
    kometkas.add(new Kometka(grid));
    kometkas.add(new Kometka(grid));
    kometkas.add(new Kometka(grid));
  } else {
    println("Removing");
    if (kometkas.size() > 0) {
      kometkas.remove(0);
    }
  }
  for (Kometka k : kometkas) {
    k.draw();
    k.update(delta);
  }

  //drawMouse();

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