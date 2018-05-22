
class ImpulseGrid{
  int width;
  int height;
  int originX, originY;
  float cellWidth = 8;
  float cellHeight = 8;
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
        cells[j*width + i] = new ImpulseCell(cellWidth, cellHeight, i, j, 1);
      }
    }
  }

  ImpulseCell getCellAt(float x, float y){
    int gridx = (int)(x/cellWidth);
    int gridy = (int)(y/cellHeight);
    if(gridx >= width)gridx = width-1;
    if(gridx < 0)gridx = 0;
    if(gridy >= height)gridy = height-1;
    if(gridy < 0)gridy = 0;
    return cells[gridy*width + gridx];
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