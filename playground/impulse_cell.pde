
class ImpulseCell{
  final float HIDE_SPEED = 10;
  final float SHOW_SPEED = 10;
  final float MIN_SIZE = 0.1;
  final float MAX_SIZE = 1.00;
  float size = MIN_SIZE;
  float targetSize = 0.0;
  float width;
  float height;
  int x, y;

  ImpulseCell(float width, float height, int x, int y, float size){
    this.width = width;
    this.height = height;
    this.size = size;
    this.x = x;
    this.y = y;
    this.targetSize = 0.0;
  }

  float getRealX(){
    return x * width;
  }
  
  float getRealY(){
    return y * height;
  }
  
  void update(float deltaTime){
    if(size < targetSize){
      setSize(size + deltaTime*SHOW_SPEED);
      if(size >= targetSize){
        targetSize = MIN_SIZE;
      }
    }else{
      setSize(size - deltaTime*HIDE_SPEED);
    }
  }
  
  void setSize(float size){
    if(size < MIN_SIZE)size = MIN_SIZE;
    if(size > MAX_SIZE)size = MAX_SIZE;
    this.size = size;
  }
  
  void show(float targetSize){
    if(targetSize > MAX_SIZE)targetSize = MAX_SIZE;
    if(targetSize < MIN_SIZE)targetSize = MIN_SIZE;
    if(targetSize > this.targetSize){
      this.targetSize = targetSize;
    }
  }
  
  void draw(){
    rect(x*width, y * height, width*size, height * size);
  }
}