import websockets.*;
import de.looksgood.ani.*;

final int SCREEN_WIDTH = 1500;
final int SCREEN_HEIGHT = 1000;

//VideoRecorder videoRecorder;
Grid grid;
GridRenderer render;
Scenes scenes;
HashMap<Character, Boolean> keys = new HashMap();
PVector mouseSmooth = new PVector();
long lastTime = 0;
WebsocketClient wsc;
int meditation = 0;
int maxMeditation = 100;
int poorSignal = 0;
int attention = 0;
JSONObject recentMessage = null;

boolean isKeyPressed(char key){
  return keys.get(key) != null && keys.get(key) == true;
}

// ------------
void setup() {
  //fullScreen(P3D, 1);
  size(1024, 768);
//colorMode(RGB, 255);
  background(0);

  rectMode(CENTER);
  imageMode(CENTER);
  Ani.init(this);
  Ani.setDefaultEasing(Ani.EXPO_OUT);
  frameRate(60);

  mouseSmooth.x = mouseX;
  mouseSmooth.y = mouseY;
  grid = new Grid(width/Config.CELL_SIZE, height/Config.CELL_SIZE, Config.CELL_SIZE, Config.CELL_SIZE, Config.CELL_SIZE/2, Config.CELL_SIZE/2);
  render = new GridRenderer(grid, Config.RENDER_TYPE);
  scenes = new Scenes(this);
  lastTime = millis();
  wsc= new WebsocketClient(this, "ws://localhost:8025/mind");
}

void webSocketEvent(String msg) {
  println("Got message");
  println(msg);
  JSONObject  message = parseJSONObject(msg);
  recentMessage = message;
  println("WEBSOCKET");
  println("---------");
  println(message);
  println("---------");
  //meditation = message.getInt("meditation");
  //poorSignal = message.getInt("poorSignal");
  //attention = message.getInt("attention");
      setMeditation(message.getInt("meditation"));
    setPoorSignal(message.getInt("poorSignal"));
    setAttention(message.getInt("attention"));
}
void setMeditation(int val){
  Ani.to(this,  2.5, "meditation", val);
}

void setPoorSignal(int val){
  Ani.to(this,  0.5, "poorSignal", val);
}
void setAttention(int val){
  Ani.to(this,  0.5, "attention", val);
}
void draw() {
  clear();
  
  //fxzzxloat delta = ((mouseX /  (float)SCREEN_WIDTH) * 100) /1000.0;
  //float delta = 1.0/frameRate;///5000.0;//
  long time = millis();
  float delta = (time - lastTime)/1000.0;
  lastTime = time;
  println(frameRate);
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
  
  if( key == 'p'){
    saveFrame();
  }
}

void keyReleased(){
  keys.put(key, false);
}
