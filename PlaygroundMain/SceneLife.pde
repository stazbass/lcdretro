class SceneLife {
  int[][] cells; 
  // Buffer to record the state of the cells and use this while changing the others in the interations
  int[][] cellsBuffer; 
  int mapWidth;
  int mapHeight;
  float probabilityOfAliveAtStart = 35;
  boolean initialized = false;
  boolean enabled = true;

  SceneLife() {
  }

  void draw(GridRenderer render) {
    if (!enabled)return;
    if (!initialized) {
      initLife(render.grid.width, render.grid.height);
    }
    for (int x=0; x<mapWidth; x++) {
      for (int y=0; y<mapHeight; y++) {
        if (cells[x][y]==1) {
          render.point(x, y, 1);
        } else {
          //render.point(x,y,1);
        }
      }
    }
    for (int x=0; x<mapWidth; x++) {
      for (int y=0; y<mapHeight; y++) {
        cellsBuffer[x][y] = cells[x][y];
      }
    }
  }

  void update(float dt) {
    if (!enabled || !initialized)return;
    // Iterate if timer ticks
    if (frameCount%1 == 0) {
      iteration();
      randomLiveCell();
      randomLiveCell();
      randomLiveCell();
      randomLiveCell();
      randomLiveCell();
      randomLiveCell();
      randomLiveCell();
      randomLiveCell();
      randomLiveCell();
      randomLiveCell();
      randomLiveCell();
      randomLiveCell();
      randomLiveCell();
      randomLiveCell();
      randomLiveCell();
            randomLiveCell();
      randomLiveCell();
      randomLiveCell();
      randomLiveCell();
      println("iteration");
    }
  }

  void initLife(int sceneWidth, int sceneHeight) {
    this.mapWidth = sceneWidth;
    this.mapHeight = sceneHeight;
    cells = new int[mapWidth][mapHeight];
    cellsBuffer = new int[mapWidth][mapHeight];

    for (int x=0; x<mapWidth; x++) {
      for (int y=0; y<mapHeight; y++) {
        float state = random (100);
        if (state > probabilityOfAliveAtStart) { 
          state = 0;
        } else {
          state = 1;
        }
        cells[x][y] = int(state); // Save state of each cell
      }
    }
    initialized = true;
  }

  void randomLiveCell() {
    cells[(int)random(0, mapWidth-1)][(int)random(0, mapHeight-1)] = 1; // Save state of each cell
  }

  void iteration() { // When the clock ticks
    // Save cells to buffer (so we opeate with one array keeping the other intact)
    for (int x=0; x<mapWidth; x++) {
      for (int y=0; y<mapHeight; y++) {
        cellsBuffer[x][y] = cells[x][y];
      }
    }

    // Visit each cell:
    for (int x=0; x<mapWidth; x++) {
      for (int y=0; y<mapHeight; y++) {
        // And visit all the neighbours of each cell
        int neighbours = 0; // We'll count the neighbours
        for (int xx=x-1; xx<=x+1; xx++) {
          for (int yy=y-1; yy<=y+1; yy++) {  
            if (((xx>=0)&&(xx<mapWidth))&&((yy>=0)&&(yy<mapHeight))) { // Make sure you are not out of bounds
              if (!((xx==x)&&(yy==y))) { // Make sure to to check against self
                if (cellsBuffer[xx][yy]==1) {
                  neighbours ++; // Check alive neighbours and count them
                }
              } // End of if
            } // End of if
          } // End of yy loop
        } //End of xx loop
        // We've checked the neigbours: apply rules!
        if (cellsBuffer[x][y]==1) { // The cell is alive: kill it if necessary
          if (neighbours < 2 || neighbours > 3) {
            cells[x][y] = 0; // Die unless it has 2 or 3 neighbours
          }
        } else { // The cell is dead: make it live if necessary      
          if (neighbours == 3 ) {
            cells[x][y] = 1; // Only if it has 3 neighbours
          }
        } // End of if
      } // End of y loop
    } // End of x loop
  } // End of function
}
