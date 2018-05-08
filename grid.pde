
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
        cells[j*width + i] = new Cell(cellWidth, cellHeight, i, j, 1);
      }
    }
  }

  Cell getCell(int x, int y){
    return cells[y*width + x];
  }
  
  void setValue(float x, float y){
    x -= originX;
    y -= originY;
    for(int i = 0; i < cells.length; i++){
      Cell c = cells[i];
      if(abs(c.getRealX() - x) <= c.width*2 && abs(c.getRealY() - y) <= c.height*2){
        c.setValue(1.0 - (abs(c.getRealX() - x)/ c.width + abs(c.getRealY() - y)/ c.height)/2.0);
      }
    }
  }
  
  void clearCells(){
    for(int i = 0; i < cells.length; i++){
      cells[i].clear();
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
