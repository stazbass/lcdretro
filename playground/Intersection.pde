static class Intersection {

  static boolean checkLineCircleIntersect(PVector start, PVector end, PVector sphereCenter, float radius) {
    PVector d = end.sub(end, start);
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
  
  
  static PVector getCollisionNormal(PVector vec, PVector sphereCenter){
    return PVector.sub(vec, sphereCenter).normalize();
  }
  
  static PVector getReflectedVector(PVector v, PVector normal){
    return PVector.sub(v, normal.mult(2*PVector.dot(v, normal)));
  }
}
