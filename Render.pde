/// ----------------------------------------------------------------------------------------------------------------------- //<>//
////    GRID
/// -----------------------------------------------------------------------------------------------------------------------
class Grid{
  int width;
  int height;
  int originX, originY;
  float cellWidth;
  float cellHeight;
  ImpulseCell[] cells;
  PImage cellImage;
  
  Grid(int width, int height, int cellWidth, int cellHeight, int originX, int originY){
    this.width = width;
    this.height = height;
    this.cellWidth = cellWidth;
    this.cellHeight = cellHeight;
    this.originX = originX;
    this.originY = originY;
    if(Config.cellImageMode)
      cellImage = loadImage(Config.cellImagePath);
    PGraphics g = createGraphics((int)width, (int)height);
    g.beginDraw();
    g.stroke(0,0,0);
    g.strokeWeight(Config.BORDER_WIDTH);
    g.fill(255, 255, 255);
    g.ellipse(width/2.0,height/2.0,width,height);       //<>//
    g.endDraw();
    g.updatePixels();
    g.loadPixels();
    cellImage = createImage((int)width, (int)height, ARGB);
    //cellImage.loadPixels();
    int [] gPixels = g.pixels;
    for(int i = 0; i < gPixels.length; i++){
      cellImage.pixels[i] = color(red(gPixels[i]), green(gPixels[i]), blue(gPixels[i]));
    }
    cellImage.updatePixels();
    
      
    cells = new ImpulseCell[width*height];
    for(int i = 0; i < width; i++){
      for(int j = 0; j < height; j++){
        cells[j*width + i] = new ImpulseCell(cellWidth, cellHeight, i, j, cellImage);
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
    blendMode(ADD);
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

enum Render{
  LOAD_IMAGE,
  GENERATE_IMAGE,
  VECTOR
}

interface RenderImageSupplier{
  PImage getImage();
}

class FileImage implements RenderImageSupplier{
  PImage image;
  
  FileImage(String path){
    image = loadImage(path);    
  }
  
  PImage getImage(){
    return image;
  }
}

/// -----------------------------------------------------------------------------------------------------------------------
////    IMPULSE CELL
/// -----------------------------------------------------------------------------------------------------------------------

class ImpulseCell{
  float size = Config.MIN_CELL_SIZE;
  float targetSize = Config.MIN_CELL_SIZE;
  float cellWidth;
  float cellHeight;
  float x, y;
  PImage cellImage;
  AnimatedColor currentColor = new AnimatedColor(color(10, 10, 10));

  ImpulseCell(float width, float height, int x, int y, PImage image){
    this.cellWidth = width;
    this.cellHeight = height;
    this.x = x;
    this.y = y;
    this.cellImage = image; //<>//
  }

  float getRealX(){
    return x * width;
  }
  
  float getRealY(){
    return y * height;
  }
  
  float getGridX(int realX){
    return (realX - this.x)/cellWidth;
  }
  float getGridY(int realY){
    return (realY - this.y)/cellHeight;
  }
  
  void update(float deltaTime){
    currentColor.update(deltaTime);
    if(size <= targetSize){
      float sizeDelta = deltaTime * Config.SHOW_SPEED;
      setSize(size + sizeDelta);
      //float colorScale = size/Config.MAX_CELL_SIZE;
      //currentColor = color(red(targetColor)*colorScale, green(targetColor)*colorScale, blue(targetColor)*colorScale, size/Config.MAX_CELL_SIZE*255);
      //currentColor = targetColor;
      if(size >= targetSize){
        size = targetSize;
        targetSize = Config.MIN_CELL_SIZE;
      }
    }else{
      if(size != targetSize){
        setSize(size - deltaTime*Config.HIDE_SPEED);
         float colorScale = size/Config.MAX_CELL_SIZE;
      //currentColor = targetColor;
        //currentColor = color(red(targetColor)*colorScale, green(targetColor)*colorScale, blue(targetColor)*colorScale, size/Config.MAX_CELL_SIZE*255);
        if(size <= targetSize)size = targetSize;
      }
    }
  }
  
  void setTargetSize(float targetSize){
    if(targetSize > this.targetSize)
      this.targetSize = constrain(targetSize, Config.MIN_CELL_SIZE, Config.MAX_CELL_SIZE);
  }
  
  void setSize(float size){
    this.size = constrain(size, Config.MIN_CELL_SIZE, Config.MAX_CELL_SIZE);
  }
  
  void show(float brightness){
    setTargetSize(brightness);
  }
  
  void paint(color targetColor){
    this.currentColor.setTargetColor(targetColor);
  }
  
  void draw(){
    switch(Config.currentRender){
      
    }
    //if(Config.cellImageMode){
      //scale(size);
      tint(currentColor.value);
      image(cellImage, x*cellWidth, y *cellHeight, cellWidth * size*Config.CELL_SCALE, cellHeight * size*Config.CELL_SCALE);
    //}{
    //  strokeWeight(Config.BORDER_WIDTH);
    //  fill(currentColor.value);
    //  //rect(x*cellWidth, y * cellHeight, cellWidth* size*Config.CELL_SCALE, cellHeight * size * Config.CELL_SCALE);
    //  ellipse(x*cellWidth, y * cellHeight, cellWidth* size*Config.CELL_SCALE, cellHeight * size * Config.CELL_SCALE);
    //}
  }
}


/// -----------------------------------------------------------------------------------------------------------------------
////    RENDER
/// -----------------------------------------------------------------------------------------------------------------------

class GridRenderer {
  Grid grid;

  GridRenderer(Grid grid) {
    this.grid = grid;
  }

  void point(float x, float y, float brightness) {
    grid.getCellAt(Math.round(x), Math.round(y)).show(brightness);
  }
  
  void point(float x, float y, float brightness, color col) {
    grid.getCellAt(Math.round(x), Math.round(y)).paint(col);
    grid.getCellAt(Math.round(x), Math.round(y)).show(brightness);
  }
  
  private void plotLineLow(int x0, int y0, int x1, int y1, float brightness, color lineColor) {
    int dx = x1 - x0;
    int dy = y1 - y0;

    int yi = 1;
    if (dy < 0) {
      yi = -1;
      dy = -dy;
    }

    int D = 2*dy - dx;
    int y = y0;

    for (int x = x0; x <= x1; x++) {
      point(x, y, brightness, lineColor);
      if (D > 0) {
        y = y + yi;
        D = D - 2 * dx;
      }
      D = D + 2*dy;
    }
  }

  private void plotLineHigh(int x0, int y0, int x1, int y1, float brightness, color lineColor) {
    int dx = x1 - x0;
    int dy = y1 - y0;
    int xi = 1;
    if (dx < 0) {
      xi = -1;
      dx = -dx;
    }
    int D = 2 * dx - dy;
    int x = x0;

    for (int y = y0; y <= y1; y++) {
      point(x, y, brightness, lineColor);
      if (D > 0) {
        x = x + xi;
        D = D - 2 * dy;
      }
      D = D + 2 * dx;
    }
  }

  void line(float x0, float y0, float x1, float y1, float brightness, color lineColor) {
    int x0i = Math.round(x0);
    int y0i = Math.round(y0);
    int x1i = Math.round(x1);
    int y1i = Math.round(y1);
    
    if (abs(y1 - y0) < abs(x1 - x0)) {
      if (x0 > x1) {
        plotLineLow(x1i, y1i, x0i, y0i, brightness, lineColor);
      } else {
        plotLineLow(x0i, y0i, x1i, y1i, brightness, lineColor);
      }
    } else {
      if (y0 > y1) {
        plotLineHigh(x1i, y1i, x0i, y0i, brightness, lineColor);
      } else {
        plotLineHigh(x0i, y0i, x1i, y1i, brightness, lineColor);
      }
    }
  }
  
  void circle(PVector pos, float radius, float brightness){
    circle(pos.x, pos.y, radius, brightness);
  }
  void circleAlt(PVector pos, float r, float  brightness){
    circleAlt(pos.x, pos.y, r, brightness);
  }
  void circle(float x0, float y0, float radius, float bright){
    int x = (int)(radius-1);
    int y = 0;
    int dx = 1;
    int dy = 1;
    int intr = (int)radius;
    int err = dx - (intr << 1);

    while (x >= y)
    {
        point(x0 + x, y0 + y, bright);
        point(x0 + y, y0 + x, bright);
        point(x0 - y, y0 + x, bright);
        point(x0 - x, y0 + y, bright);
        point(x0 - x, y0 - y, bright);
        point(x0 - y, y0 - x, bright);
        point(x0 + y, y0 - x, bright);
        point(x0 + x, y0 - y, bright);

        if (err <= 0)
        {
            y++;
            err += dy;
            dy += 2;
        }
        
        if (err > 0)
        {
            x--;
            dx += 2;
            err += dx - (intr << 1);
        }
    }
  }
  
  private void drawCirclePoints(float xc, float yc, float x, float y, float brightness)
  {
      point(xc+x, yc+y, brightness);
      point(xc-x, yc+y, brightness);
      point(xc+x, yc-y, brightness);
      point(xc-x, yc-y, brightness);
      point(xc+y, yc+x, brightness);
      point(xc-y, yc+x, brightness);
      point(xc+y, yc-x, brightness);
      point(xc-y, yc-x, brightness);
  }
  
  void circleAlt(float xc, float yc, float r, float brightness)
  {
      int x = 0, y = (int)r;
      int d = (int)(3 - 2 * r);
      while (y >= x)
      {
          // for each pixel we will
          // draw all eight pixels
          drawCirclePoints(xc, yc, x, y, brightness);
          x++;
   
          // check for decision parameter
          // and correspondingly 
          // update d, x, y
          if (d > 0)
          {
              y--; 
              d = d + 4 * (x - y) + 10;
          }
          else
              d = d + 4 * x + 6;
          drawCirclePoints(xc, yc, x, y, brightness);
      }
  }
  
  void rect(float x, float y, float rWidth, float rHeight, float brightness, color rectColor){
    line(x, y, x+rWidth, y, brightness, rectColor);
    line(x+rWidth, y, x+rWidth, y, brightness, rectColor);
    line(x+rWidth, y+rHeight, x,y+rHeight, brightness, rectColor);
    line(x,y+rHeight, x, y, brightness, rectColor);
  }
}

class AnimatedColor{
  color value;
  color previousValue;
  color targetValue;
  float changeProgress = 0;
  
  AnimatedColor(color value){
    this.value = value;
    this.previousValue = value;
    this.targetValue = value;
  }
  
  void update(float dt){
    if(changeProgress != 0){
      changeProgress-=dt;
      changeProgress = changeProgress>0 ? changeProgress:0;
      value = lerpColor(previousValue, targetValue, 1.0-changeProgress);
    }
  }
  
  void setTargetColor(color target){
    if(target != targetValue){
      this.previousValue = value;
      this.changeProgress = 1.0;
      this.targetValue = target;
    }
  }
}