class SceneSand extends BaseObject {
  int[][] sandpiles;
  int w;
  int h;
  final int SKIP_FIRST = 100000;

  SceneSand() {
    this.w = render.grid.width;
    this.h = render.grid.height;
    sandpiles = new int[this.w][this.h];
    sandpiles[this.w/2][this.h/2] = 1000000000;
    for (int i = 0; i < SKIP_FIRST; i++) {
      topple();
    }
  }

  void topple() {
    int[][] nextpiles = new int[this.w][this.h];  
    for (int x = 0; x < this.w; x++) {
      for (int y = 0; y < this.h; y++) {
        int num = sandpiles[x][y];
        if (num < 4) {
          nextpiles[x][y] = sandpiles[x][y];
        }
      }
    }

    for (int x = 0; x < this.w; x++) {
      for (int y = 0; y < this.h; y++) {
        int num = sandpiles[x][y];
        if (num >= 4) {
          nextpiles[x][y] += (num - 4);
          if (x+1 < this.w)
            nextpiles[x+1][y]++;
          if (x-1 >= 0)
            nextpiles[x-1][y]++;
          if (y+1 < this.h) 
            nextpiles[x][y+1]++;
          if (y-1 >= 0) 
            nextpiles[x][y-1]++;
        }
      }
    }

    sandpiles = nextpiles;
  }

  void draw() {

    //if (frameCount%10 == 0) {
      for (int x = 0; x < w; x++) {
        for (int y = 0; y < h; y++) {
          int num = sandpiles[x][y];
          float col = 0.0;//color(255, 0, 0);
          color colorObject;
          if (num == 0) {
            col = 0.0;// color(255, 255, 0);
            colorObject = color(0, 180, 20);
            render.point(x, y, 1, colorObject);
          } else if (num == 1) {
            col = 0.2;//color(0, 185, 63);
            colorObject = color(200, 0, 0);
            render.point(x, y, 1, colorObject);
          } else if (num == 2) {
            col = 0.7;//color(0, 104, 255);
            colorObject = color(0, 150, 0);
            render.point(x, y, 1, colorObject);
          } else if (num == 3) {
            col = 1.0;//color(122, 0, 229);
            colorObject = color(20, 70, 200);
            render.point(x, y, 1, colorObject);
          }else{
            colorObject = color(220, 10, 30);
            render.point(x, y, 1, colorObject);
          }

        }
        
      }
  }

  void update(float dt) {

    if (frameCount%10 == 0)topple();
  }
}
