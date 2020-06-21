class SceneLighting extends BaseObject {
  class MovingPoint {
    PVector position = new PVector(random(0, grid.width), random(0, grid.height));
    PVector velocity = new PVector(random(0, 40), random(0, 40));
    void update(float dt) {
      position.add(velocity.x*dt, velocity.y*dt);
      if (position.x > grid.width) {
        position.x = grid.width;
        velocity.x *= -1;
      }
      if (position.y > grid.height) {
        position.y = grid.height;
        velocity.y *= -1;
      }
      if (position.x  < 0) {
        position.x = 0;
        velocity.x *= -1;
      }
      if (position.y < 0) {
        position.y = 0;
        velocity.y *= -1;
      }
    }

    void draw() {
      render.circleAlt(position, 5, 1.0, color(255, 0, 0));
    }
  }
  MovingPoint mp = new MovingPoint();

  SceneLighting() {
  }

  void draw() {
    //drawNode(new PVector(random(0, grid.width), random(0, grid.height)), new PVector(random(0, grid.width), random(0, grid.height)) );
    mp.draw();
  }

  void update(float dt) {
    mp.update(dt);
    for (int i = 0; i < 10; i++) {
      drawNode(new PVector(random(0, grid.width), 0), mp.position );
      drawNode(new PVector(0, random(0, grid.height)), mp.position );
      drawNode(new PVector(random(0, grid.width), grid.height), mp.position );
      drawNode(new PVector(grid.width, random(0, grid.height)), mp.position );
    }
  }

  PVector getNextPoint(PVector from, PVector to, float distance, float leftDeviation, float rightDeviation) {
    PVector dir = PVector.sub(to, from);
    dir.normalize();
    dir.rotate(random(leftDeviation, rightDeviation));
    dir.setMag(distance*random(0, 1));
    return PVector.add(from, dir);
  }

  PVector[] getLighting(PVector from, PVector to) {
    final int segCount = 30;
    PVector [] result = new PVector [segCount];
    for (int i = 0; i < segCount; i++) {
      float time = ((float)i/segCount);
      result[i] = getNextPoint(from, to, PVector.dist(to, from)*time*random(0, 1), (-PI/2)*random(0, 1), (PI/2)*random(0, 1));
      //result[i] = getNextPoint(from, to, PVector.dist(to,from)*time, (-PI/2.0), (PI/2.0));
      from = result[i];
    }
    return result;
  }

  void drawNode(PVector from, PVector to) {
    if (PVector.dist(from, to) > 10) {
      PVector nextPoint = getNextPoint(from, to, PVector.dist(to, from)*random(0, 1)/2.0, (-PI/2)*random(0, 1), (PI/2)*random(0, 1));
      render.line(from.x, from.y, nextPoint.x, nextPoint.y, 1, color(random(10, 150), 0, random(110, 255))); 
      drawNode(nextPoint, to);
      if (random(0, 100)>95)drawNode(nextPoint, to);
    }
  }
}
