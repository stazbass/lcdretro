
class ImpulseCell{
  final float HIDE_SPEED = 2;
  final float SHOW_SPEED = 5;
  final float MIN_SIZE = 0.08;
  float size = MIN_SIZE;
  float impulse;
  float width;
  float height;
  int x, y;

  ImpulseCell(float width, float height, int x, int y, float value){
    this.width = width;
    this.height = height;
    this.size = value;
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
    if(size != MIN_SIZE || impulse != 0){
      if(impulse == 0){
        setSize(size - HIDE_SPEED * deltaTime);
      }else{
        float delta = deltaTime*SHOW_SPEED;
        setImpulse(impulse - delta);
        setSize(size + delta);
      }
    }
  }
  
  void setSize(float value){
    if(value < MIN_SIZE)value = MIN_SIZE;
    if(value > 0.99)value = 1;
    this.size = value;
  }
  void setImpulse(float value){
    if(value < 0.001)value = 0;
    if(value > 0.99)value = 1;
    this.impulse = value;
  }  
  void applyImpulse(float impulseValue){
    impulse = impulseValue;
  }
  
  void draw(){
    rect(x*width, y * height, width*size, height * size);
  }
}