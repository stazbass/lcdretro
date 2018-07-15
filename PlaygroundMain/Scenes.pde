
class Scenes extends BaseObject{
  Scenes() {
    super();
    //actors.add(new SceneSand());
    //actors.add(new SceneImage());
    addChild(new SceneMovingPoint());
    //actors.add(new SceneLife());
    addChild(new SceneBitka());
  }
  
  void update(float dt){
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