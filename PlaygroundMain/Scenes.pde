class Scenes{
  SceneSand sand;
  SceneMovingPoint sceneMovingPoint;
  SceneLife sceneLife;
  
  Scenes(GridRenderer render){
    sand = new SceneSand(render.grid.width, render.grid.height);
    sceneMovingPoint = new SceneMovingPoint();
    sceneLife = new SceneLife();
    
    sand.enabled = false;
    sceneMovingPoint.enabled = false;
    sceneLife.enabled = true;
  }
  
  void draw(GridRenderer render){
    sceneLife.draw(render);
    sceneMovingPoint.draw(render);
    sand.draw(render);
  }
  
  void update(float dt){
    sceneLife.update(dt);
    sceneMovingPoint.update(dt);
    sand.update(dt);
  }
}
