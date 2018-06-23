class LineChain{
  ArrayList<MovingPoint> points = new ArrayList(1000);
  int maxX;
  int maxY;
  GridRenderer render;
  MovingPoint last = null;
  
  LineChain(int maxx, int maxy, GridRenderer render){
    maxX = maxx;
    maxY = maxy;
    this.render = render;
  }

  void draw(){
    for(int i = 0; i < points.size()-1; i++){
      PVector p1 = points.get(i).pos;
      PVector p2 = points.get(i+1).pos;
      render.line(p1.x,p1.y,p2.x,p2.y, 1.0);
    }
  }
  
  void update(float delta){
    for(MovingPoint point : points){
      point.update(delta);
    }
  }
  
  void addPoint(){
    if(last == null){
      last = new MovingPoint(maxX, maxY);
      points.add(last);
    }
    points.add(last = new MovingPoint(last.pos, maxX, maxY));
      
  }
}