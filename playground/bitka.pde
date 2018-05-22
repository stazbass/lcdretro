class Bitka{
  ImpulseGrid grid;
  int segments = 15;
  int bitkaHeight = 5;
  float xpos;
  float ypos;
  
  Bitka(ImpulseGrid grid){
    this.grid = grid;
  }
  
  void draw(){
    xpos = mouseX;
    ypos = 700;
    
    for(int i = 0; i < segments; i++){
      for(int j = 0; j < bitkaHeight; j++){
        grid.getCellAt(xpos + grid.cellWidth*i - segments*grid.cellWidth/2, ypos + j* grid.cellHeight).applyImpulse(1);
      }
    }
  }
  
  void update(float dt){
  }
}