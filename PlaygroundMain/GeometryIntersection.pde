static class Intersection {  
  static PVector checkLineIntersection(PVector l1p1, PVector l1p2, PVector l2p1, PVector l2p2){
    return checkLineIntersection(l1p1.x, l1p1.y, l1p2.x, l1p2.y, l2p1.x, l2p1.y, l2p2.x, l2p2.y);
  }
  
  static PVector checkLineIntersection(float p0_x, float p0_y, float p1_x, float p1_y, 
    float p2_x, float p2_y, float p3_x, float p3_y)
  {
    float s1_x, s1_y, s2_x, s2_y;
    s1_x = p1_x - p0_x;     
    s1_y = p1_y - p0_y;
    s2_x = p3_x - p2_x;     
    s2_y = p3_y - p2_y;

    float s, t;
    s = (-s1_y * (p0_x - p2_x) + s1_x * (p0_y - p2_y)) / (-s2_x * s1_y + s1_x * s2_y);
    t = ( s2_x * (p0_y - p2_y) - s2_y * (p0_x - p2_x)) / (-s2_x * s1_y + s1_x * s2_y);

    if (s >= 0 && s <= 1 && t >= 0 && t <= 1)
    {
      // Collision detected
      return new PVector(p0_x + (t * s1_x), p0_y + (t * s1_y)) ;
    }

    return null; // No collision
  }
  static boolean checkLineCircleIntersect(PVector start, PVector end, PVector sphereCenter, float radius) {
    PVector d = PVector.sub(end, start);
    PVector f = PVector.sub(start, sphereCenter) ;
    float a = PVector.dot(d, d ) ;
    float b = 2*PVector.dot(f, d);
    float c = PVector.dot(f, f) - radius*radius ;

    float discriminant = b*b-4*a*c;
    if ( discriminant > 0 )
    {
      // ray didn't totally miss sphere,
      // so there is a solution to
      // the equation.

      discriminant = sqrt( discriminant );

      // either solution may be on or off the ray so need to test both
      // t1 is always the smaller value, because BOTH discriminant and
      // a are nonnegative.
      float t1 = (-b - discriminant)/(2*a);
      float t2 = (-b + discriminant)/(2*a);

      // 3x HIT cases:
      //          -o->             --|-->  |            |  --|->
      // Impale(t1 hit,t2 hit), Poke(t1 hit,t2>1), ExitWound(t1<0, t2 hit), 

      // 3x MISS cases:
      //       ->  o                     o ->              | -> |
      // FallShort (t1>1,t2>1), Past (t1<0,t2<0), CompletelyInside(t1<0, t2>1)

      if ( t1 >= 0 && t1 <= 1 )
      {
        // t1 is the intersection, and it's closer than t2
        // (since t1 uses -b - discriminant)
        // Impale, Poke
        return true ;
      }

      // here t1 didn't intersect so we are either started
      // inside the sphere or completely past it
      if ( t2 >= 0 && t2 <= 1 )
      {
        // ExitWound
        return true ;
      }

      // no intn: FallShort, Past, CompletelyInside
    }
    return false;
  }

  static PVector[] checkLineBoxIntersection(PVector start, PVector end, Box box) {
    Edge[] edges = box.getEdges();
    for(Edge edge: edges){
      PVector vector = checkLineIntersection(start,end,edge.vectors[0], edge.vectors[1]);
      if(vector != null)return new PVector[]{vector, getLineNormal(edge.vectors[0], edge.vectors[1])};
    }
    return null;
  }

  static PVector getCollisionNormal(PVector vec, PVector sphereCenter) {
    return PVector.sub(vec, sphereCenter).normalize();
  }

  static PVector getReflectedVector(PVector v, PVector normal) {
    return PVector.sub(v, normal.mult(2.0*PVector.dot(v, normal)));
  }
  
  static PVector getLineNormal(PVector p1, PVector p2){
    return (new PVector(- p2.y + p1.y, p2.x - p1.x)).normalize();
  }
}