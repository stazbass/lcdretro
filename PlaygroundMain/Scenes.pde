
class Scenes extends BaseObject{
  Scenes() {
    super();
    //actors.add(new SceneSand());
    //actors.add(new SceneImage());
    //actors.add(new SceneMovingPoint());
    //actors.add(new SceneLife());
    addChild(new SceneBitka());
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