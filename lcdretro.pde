final int SCREEN_WIDTH = 1500;
final int SCREEN_HEIGHT = 1000;

//VideoRecorder videoRecorder;
Grid grid;
GridRenderer render;
Scenes scenes;
HashMap<Character, Boolean> keys = new HashMap();
PVector mouseSmooth = new PVector();

boolean isKeyPressed(char key){
  return keys.get(key) != null && keys.get(key) == true;
}

// ------------
void setup() {
  fullScreen(P2D);
  //size(1500, 1000, P3D);
  background(0);
  stroke(220, 200, 220);
  fill(250, 10, 250);
  //smooth(4);
  rectMode(CENTER);
  imageMode(CENTER);

  frameRate(100);

  mouseSmooth.x = mouseX;
  mouseSmooth.y = mouseY;
  grid = new Grid(width/Config.CELL_SIZE, height/Config.CELL_SIZE, Config.CELL_SIZE, Config.CELL_SIZE, Config.CELL_SIZE/2, Config.CELL_SIZE/2);
  render = new GridRenderer(grid, Config.RENDER_TYPE);
  scenes = new Scenes();
}

void draw() {
  clear();
  
  float delta = 10.0/1000.0;
  drawAll();
  updateAll(delta);
  println("Frame rate " + frameRate);
}

void drawAll() {
  scenes.draw();
  grid.draw();
}

void updateAll(float delta) {
  grid.update(delta);
  scenes.update(delta);
}

void keyPressed() {
  keys.put(key, true);
  
  if (key == 'q') {
    exit();
  }
}

void keyReleased(){
  keys.put(key, false);
}
