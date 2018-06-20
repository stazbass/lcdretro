
class ImpulseCell{
  final float HIDE_SPEED = 4;
  final float SHOW_SPEED = 20;
  final float MIN_SIZE = 0.0;
  final float MAX_SIZE = 1;
  final float MAX_IMPULSE = 0.5;
  float size = MIN_SIZE;
  float impulse = 0.0;
  float cellWidth;
  float cellHeight;
  float x, y;

  ImpulseCell(float width, float height, int x, int y, float size){
    this.cellWidth = width;
    this.cellHeight = height;
    this.size = size;
    this.x = x;
    this.y = y;
    this.impulse = 0.0;
  }

  float getRealX(){
    return x * width;
  }
  
  float getRealY(){
    return y * height;
  }
  
  void update(float deltaTime){
    if(impulse > 0){
      float delta = deltaTime * SHOW_SPEED;
      setImpulse(impulse - delta);
      setSize(size + delta);
    }else{
      setSize(size - deltaTime*HIDE_SPEED);
    }
  }
  
  void setImpulse(float val){
    if(val < 0)val = 0;
    if(val > MAX_IMPULSE)val = MAX_IMPULSE;
    this.impulse = val;
  }
  
  void setSize(float val){
    if(val <= MIN_SIZE)val = MIN_SIZE;
    if(val >= MAX_SIZE){
      val = MAX_SIZE;
      if(impulse > 0.5)
      setImpulse(0.5);
    }
    this.size = val;
  }
  
  void show(float brightness){
    //float impulse = brightness - size;
    //this.impulse = impulse > this.impulse?impulse:this.impulse;
    this.impulse += brightness;
  }
  
  void draw(){
    strokeWeight(size > 0.5 ? size : 0.5);
    rect(x*cellWidth, y * cellHeight, cellWidth* size, cellHeight * size);
  }
}