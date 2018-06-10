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
function line(x0, y0, x1, y1)
     real deltax := x1 - x0
     real deltay := y1 - y0
     real deltaerr := abs(deltay / deltax)    // Assume deltax != 0 (line is not vertical),
           // note that this division needs to be done in a way that preserves the fractional part
     real error := 0.0 // No error at start
     int y := y0
     for x from x0 to x1 
         plot(x,y)
         error := error + deltaerr
         while error ≥ 0.5 then
             y := y + sign(deltay) * 1
             error := error - 1.0
**/
  void line(int startX, int startY, int endX, int endY){
  }
}