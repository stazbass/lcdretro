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
//WebsocketClient wsc;
Websocket websocket;

int meditation = 0;
int meditationSmooth = 0;
int maxMeditation = 100;
int poorSignal = 0;
int attention = 0;
JSONObject recentMessage = null;

boolean isKeyPressed(char key){
  return keys.get(key) != null && keys.get(key) == true;
}

// ------------
void setup() {
  fullScreen(P3D, 1);
  //size(1024, 768);
//colorMode(RGB, 255);
  colorMode(RGB, 255, 255, 255);
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
  if(Config.WEBSOCKETS_ENABLED){
    websocket = new Websocket();
    websocket.setup("ws://localhost:8025/mind", this);
  }
  //wsc= new WebsocketClient(this, "ws://localhost:8025/mind");
}

void webSocketEvent(String msg) {
  websocket.webSocketEvent(msg);
}
void setMeditation(int val){
    if(meditation != val){
      Ani.to(this,  0.5, "meditationSmooth", val);
    }
    meditation = val;
}

void setPoorSignal(int val){
  //Ani.to(this,  0.5, "poorSignal", val);
  poorSignal = val;
}
void setAttention(int val){
  //Ani.to(this,  0.5, "attention", val);
  attention = val;
}
void draw() {
  clear();
  long time = millis();
  float delta = (time - lastTime)/10000.0;
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
  if(!Config.WEBSOCKETS_ENABLED){
    setMeditation(100);
    setPoorSignal(0);
    setAttention(33);
  }
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
