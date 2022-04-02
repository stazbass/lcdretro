
class Scenes extends BaseObject{
  Scenes(PApplet p) {
    super();
    //addChild(new SceneSand());
    //addChild(new SceneImage());
    //addChild(new SceneLife());
    //addChild(new SceneMovingPoint());
    addChild(new ScenePhyllotaxis());
    //addChild(new SceneBitka());
    //addChild(new StarzScene());
    //addChild(new SceneRectangles());
    //addChild(new SceneWebcam(p));
    //addChild(new SceneLighting());
  }
  
  void update(float dt){
    if(isKeyPressed('j')){
      Config.CELL_SIZE--;
    }
    if(isKeyPressed('k')){
      Config.CELL_SIZE++;
    }
    if(isKeyPressed('p')){
      saveFrame();
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
