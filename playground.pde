
int screenWidth = 640;
int screenHeight = 480;
int cellWidth = 10;
int cellHeight = 10;
int gridWidth = screenWidth / cellWidth;
int gridHeight = screenHeight / cellHeight;

class Cell{
  float value = 0.5;
  float width = 10;
  float height = 10;
  int x, y;

  Cell(float width, float height, int x, int y, float value){
    this.width = width;
    this.height = height;
    this.value = value;
    this.x = x;
    this.y = y;
  }

  void setValue(float newValue){
    value = newValue;
    if(value > 1)value = 1;
    if(value < 0)value = 0;
  }
  
  float getRealX(){
    return x * width;
  }
  
  float getRealY(){
    return y * height;
  }
  
  void draw(){
    pushMatrix();
    translate(x*width, y * height);
    rect(0, 0, width*value, height * value);
    popMatrix();
  }
}

class Grid{
  int width;
  int height;
  int originX, originY;
  float cellWidth = 10;
  float cellHeight = 10;
  Cell[] cells;
  
  Grid(int width, int height, int originX, int originY){
    this.width = width;
    this.height = height;
    this.originX = originX;
    this.originY = originY;
    cells = new Cell[width*height];
    for(int i = 0; i < width; i++){
      for(int j = 0; j < height; j++){
        cells[j*width + i] = new Cell(cellWidth, cellHeight, i, j, 0.9);
      }
    }
  }

  Cell getCell(int x, int y){
    return cells[y*width + x];
  }
  
  void setValue(float x, float y, float value){
    x -= originX;
    y -= originY;
    for(int i = 0; i < cells.length; i++){
      Cell c = cells[i];
      if(abs(c.getRealX() - x) < c.width && abs(c.getRealY() - y) < c.height){
        c.value = (abs(c.getRealX() - x)/ c.width + abs(c.getRealY() - y)/ c.height)/2.0;
      }
    }
  }
  
  void draw(){
    pushMatrix();
    translate(originX, originY);
    for(int i = 0; i < width; i++){
      for(int j = 0; j < height; j++){
        Cell cell = getCell(i, j);        
        cell.draw();
      }
    }
    popMatrix();
  }
}

Grid grid = new Grid(640/10, 480/10, 100, 100);

void setup(){
  size(640, 480, P2D);
  stroke(100, 100);
  fill(200);
  rectMode(CENTER);
  background(200);
}

void draw(){
  grid.setValue(mouseX, mouseY, 0.5);
  grid.draw();
}
