class SceneSand {
  int[][] sandpiles;
  int w;
  int h;

  SceneSand(int sceneWidth, int sceneHeight) {
    this.w = sceneWidth;
    this.h = sceneHeight;
    sandpiles = new int[this.w][this.h];
    sandpiles[this.w/2][this.h/2] = 1000000000;
    topple();
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

  void draw(GridRenderer render) {
    render.point(10, 10, 0.5);
    render.line(0,0, 10, 10, 1.0);
    for (int x = 0; x < w; x++) {
      for (int y = 0; y < h; y++) {
        int num = sandpiles[x][y];
        float col = 0.0;//color(255, 0, 0);
        if (num == 0) {
          col = 0.0;// color(255, 255, 0);
        } else if (num == 1) {
          col = 0.2;//color(0, 185, 63);
        } else if (num == 2) {
          col = 0.6;//color(0, 104, 255);
        } else if (num == 3) {
          col = 1.0;//color(122, 0, 229);
        }

        render.point(x, y, col);
        //pixels[x+y*width] = col;
      }
    }
    for(int i = 0; i < 100; i++){
      topple();
    }
  }

  void update(float dt) {
    //if (frameCount%5 == 0)topple();
  }
}
