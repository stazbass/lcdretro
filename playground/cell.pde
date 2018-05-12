
class Cell{
  final float DEFAULT = 0.0;
  
  float value = DEFAULT;
  float width = 10;
  float height = 10;
  int x, y;

  Cell(float width, float height, int x, int y, float value){
    this.width = width;
    this.height = height;
    this.value = value;
    this.x = x;
    this.y = y;
  }

  void setValue(float newValue){
    if(newValue > value)value = newValue;
    if(value > 1)value = 1;
    if(value < 0)value = 0;
  }
  
  float getRealX(){
    return x * width;
  }
  
  float getRealY(){
    return y * height;
  }
  
  void clear(){
    value = DEFAULT;
  }
  
  void draw(){
    pushMatrix();
    translate(x*width, y * height);
    rect(0, 0, width*value, height * value);
    popMatrix();
  }
}
