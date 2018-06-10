
class ImpulseGrid{
  int width;
  int height;
  int originX, originY;
  float cellWidth;
  float cellHeight;
  ImpulseCell[] cells;
  
  ImpulseGrid(int width, int height, int cellWidth, int cellHeight, int originX, int originY){
    this.width = width;
    this.height = height;
    this.cellWidth = cellWidth;
    this.cellHeight = cellHeight;
    this.originX = originX;
    this.originY = originY;
    cells = new ImpulseCell[width*height];
    for(int i = 0; i < width; i++){
      for(int j = 0; j < height; j++){
        cells[j*width + i] = new ImpulseCell(cellWidth, cellHeight, i, j, 0);
      }
    }
  }

  ImpulseCell getCellAt(int x, int y){
    if(x >= width)x = width-1;
    if(x < 0)x = 0;
    if(y >= height)y = height-1;
    if(y < 0)y = 0;
    return cells[y*width + x];
  }
  
  void draw(){
    pushMatrix();
    translate(originX, originY);
    for(int i =0; i < cells.length; i++){
      cells[i].draw();
    }
    popMatrix();
  }
  
  void update(float deltaTime){
    for(int i =0; i < cells.length; i++){
      cells[i].update(deltaTime);
    }
  }
}