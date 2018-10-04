
class Scenes extends BaseObject{
  Scenes() {
    super();
    //addChild(new SceneSand());
    //addChild(new SceneImage());
    //addChild(new SceneLife());
    addChild(new SceneMovingPoint());
    //addChild(new SceneBitka());
    //addChild(new SceneRectangles());
    //addChild(new SceneWebcam());
  }
  
  void update(float dt){
    if(isKeyPressed('j')){
      Config.CELL_SIZE--;
    }
    if(isKeyPressed('k')){
      Config.CELL_SIZE++;
    }
    if(isKeyPressed('b')){
      Config.SHOW_SPEED-=0.1;
      Config.HIDE_SPEED = Config.SHOW_SPEED/4;
    }
    if(isKeyPressed('n')){
      Config.SHOW_SPEED+=0.1;
      Config.HIDE_SPEED = Config.SHOW_SPEED/4;
    }
    
    super.update(dt);
  }
}

class BaseObject {
  ArrayList<BaseObject> children = new ArrayList();
  
  BaseObject addChild(BaseObject child){
     children.add(child);
     return this;
  }
  
  void draw() {
    for(BaseObject o : children){
      o.draw();
    }
  }

  void update(float deltaTime) {
    for(BaseObject o : children){
      o.update(deltaTime);
    }
  }
}