class GridRenderer {
  ImpulseGrid grid;

  GridRenderer(ImpulseGrid grid) {
    this.grid = grid;
  }

  void point(float x, float y, float brightness) {
    grid.getCellAt(Math.round(x), Math.round(y)).show(brightness);
  }
  
  private void plotLineLow(int x0, int y0, int x1, int y1, float brightness) {
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
      point(x, y, brightness);
      if (D > 0) {
        y = y + yi;
        D = D - 2 * dx;
      }
      D = D + 2*dy;
    }
  }

  private void plotLineHigh(int x0, int y0, int x1, int y1, float brightness) {
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
      point(x, y, brightness);
      if (D > 0) {
        x = x + xi;
        D = D - 2 * dy;
      }
      D = D + 2 * dx;
    }
  }

  void line(float x0, float y0, float x1, float y1, float brightness) {
    int x0i = Math.round(x0);
    int y0i = Math.round(y0);
    int x1i = Math.round(x1);
    int y1i = Math.round(y1);
    
    if (abs(y1 - y0) < abs(x1 - x0)) {
      if (x0 > x1) {
        plotLineLow(x1i, y1i, x0i, y0i, brightness);
      } else {
        plotLineLow(x0i, y0i, x1i, y1i, brightness);
      }
    } else {
      if (y0 > y1) {
        plotLineHigh(x1i, y1i, x0i, y0i, brightness);
      } else {
        plotLineHigh(x0i, y0i, x1i, y1i, brightness);
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
  
  void rect(float x, float y, float rWidth, float rHeight, float brightness){
    line(x, y, x+rWidth, y, brightness);
    line(x+rWidth, y, x+rWidth, y, brightness);
    line(x+rWidth, y+rHeight, x,y+rHeight, brightness);
    line(x,y+rHeight, x, y, brightness);
  }
}