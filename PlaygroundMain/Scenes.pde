
class Scenes {
  ArrayList<BaseObject> actors = new ArrayList();

  Scenes(GridRenderer render) {
    actors.add(new SceneSand(render.grid.width, render.grid.height));
    actors.add(new SceneImage());
    //actors.add(new SceneMovingPoint());
    //actors.add(new SceneLife());
  }

  void draw(GridRenderer render) {
    for (BaseObject b : actors) {
      b.draw(render);
    }
  }

  void update(float dt) {
    for (BaseObject b : actors) {
      b.update(dt);
    }
  }
}

class BaseObject {
  void draw(GridRenderer r) {
  }

  void update(float deltaTime) {
  }
}
