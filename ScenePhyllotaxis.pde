class ScenePhyllotaxis extends BaseObject {

  float angle = 137.5;

  float n = 0;
  float c = 3;
  float start = 0;

  void draw() {
    //rotate(n * 0.3);
    
    for (int i = 0; i < n; i++) {
      float a = i * radians(137.5);
      float r = c * sqrt(i);
      float x = r * cos(a) + grid.width/2;
      float y = r * sin(a) + grid.height/2;
      float hu = i+start;//sin(start + i * 0.5);
      hu = i/3.0 % 360;
      //fill(hu, 255, 255);
      //noStroke();
      render.point(x, y, 4);
    }
    n += 1;
    start += 5;
  }

  void update(float dt) {
  }
}
