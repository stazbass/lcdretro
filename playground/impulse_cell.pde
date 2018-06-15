
class ImpulseCell{
  final float HIDE_SPEED = 5;
  final float SHOW_SPEED = 10;
  final float MIN_SIZE = 0.005;
  final float MAX_SIZE = 1;
  final float MAX_IMPULSE = 1.0;
  float size = MIN_SIZE;
  float impulse = 0.0;
  float width;
  float height;
  int x, y;

  ImpulseCell(float width, float height, int x, int y, float size){
    this.width = width;
    this.height = height;
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
      impulse = impulse - delta;
      if(impulse < 0)impulse = 0;
      setSize(size + delta);
    }else{
      setSize(size - deltaTime*HIDE_SPEED);
    }
  }
  
  void setSize(float size){
    if(size <= MIN_SIZE)size = MIN_SIZE;
    if(size >= MAX_SIZE)size = MAX_SIZE;
    this.size = size;
  }
  
  void show(float brightness){
    float impulse = brightness - size;
    this.impulse = impulse > this.impulse?impulse:this.impulse;
  }
  
  void draw(){
    rect(x*width, y * height, width*size, height * size);
  }
}