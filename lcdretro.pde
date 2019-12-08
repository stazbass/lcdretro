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
  fullScreen(P3D, 1);

  background(0);

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
  
  //float delta = ((mouseX /  (float)SCREEN_WIDTH) * 100) /1000.0;
  //println(delta);
  float delta = frameRate/5000.0;
  drawAll();
  updateAll(delta);
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
