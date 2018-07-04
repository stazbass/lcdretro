class Scenes{
  SceneSand sand;
  SceneMovingPoint sceneMovingPoint;

  Scenes(GridRenderer render){
    sand = new SceneSand(render.grid.width, render.grid.height);
    sceneMovingPoint = new SceneMovingPoint();
  }
  
  void draw(GridRenderer render){
    sceneMovingPoint.draw(render);
    sand.draw(render);
  }
  
  void update(float dt){
    sceneMovingPoint.update(dt);
    sand.update(dt);
  }
}
