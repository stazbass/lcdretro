class GridRenderer{
  ImpulseGrid grid;
  
  GridRenderer(ImpulseGrid grid){
    this.grid = grid;
  }
  
  void point(int x, int y, float impulse){
    grid.getCellAt(x, y).applyImpulse(impulse);
  }
  
  void point(int x, int y){
    point(x, y, 1.0);
  }
/**
  plotLineLow(x0,y0, x1,y1)
    dx = x1 - x0
    dy = y1 - y0
    yi = 1
    if dy < 0
      yi = -1
      dy = -dy
    end if
    D = 2*dy - dx
    y = y0
  
    for x from x0 to x1
      plot(x,y)
      if D > 0
         y = y + yi
         D = D - 2*dx
      end if
      D = D + 2*dy
      
  plotLineHigh(x0,y0, x1,y1)
  dx = x1 - x0
  dy = y1 - y0
  xi = 1
  if dx < 0
    xi = -1
    dx = -dx
  end if
  D = 2*dx - dy
  x = x0

  for y from y0 to y1
    plot(x,y)
    if D > 0
       x = x + xi
       D = D - 2*dy
    end if
    D = D + 2*dx
    
    plotLine(x0,y0, x1,y1)
  if abs(y1 - y0) < abs(x1 - x0)
    if x0 > x1
      plotLineLow(x1, y1, x0, y0)
    else
      plotLineLow(x0, y0, x1, y1)
    end if
  else
    if y0 > y1
      plotLineHigh(x1, y1, x0, y0)
    else
      plotLineHigh(x0, y0, x1, y1)
    end if
  end if
**/
  private void plotLineLow(int x0, int y0, int x1, int y1){
    int dx = x1 - x0;
    int dy = y1 - y0;
    
    int yi = 1;
    if(dy < 0){
      yi = -1;
      dy = -dy;
    }
    
    int D = 2*dy - dx;
    int y = y0;
    
    for(int x = x0; x < x1; x++){
      point(x, y);
      if(D > 0){
        y = y + yi;
        D = D - 2 * dx;
      }
      D = D + 2*dy;
    }
  }

  private void plotLineHigh(int x0, int y0, int x1, int y1){
    int dx = x1 - x0;
    int dy = y1 - y0;
    int xi = 1;
    if(dx < 0){
      xi = -1;
      dx = -dx;
    }
    int D = 2 * dx - dy;
    int x = x0;
    
    for(int y = y0; y < y1; y++){
      point(x, y);
      if(D > 0){
        x = x + xi;
        D = D - 2 * dy;
      }
      D = D + 2 * dx;
    }
  }

  void line(int x0, int y0, int x1, int y1){
    if(abs(y1 - y0) < abs(x1 - x0)){
      if(x0 > x1){
        plotLineLow(x1,y1,x0,y0);
      }else{
        plotLineLow(x0,y0,x1,y1);
      }
    }else{
      if(y0 > y1){
        plotLineHigh(x1,y1,x0,y0);
      }else{
        plotLineHigh(x0,y0,x1,y1);
      }
    }
  }
}