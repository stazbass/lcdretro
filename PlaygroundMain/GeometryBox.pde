class Box {
  PVector lu, ru, ld, rd;
  PVector position;
  PVector[] vertices;
  float angle = 0;

  Box(float bWidth, float bHeight) {
    lu = new PVector(-bWidth/2.0, -bHeight/2.0);
    ru = new PVector(bWidth/2.0, -bHeight/2.0);
    rd = new PVector(bWidth/2.0, bHeight/2.0);
    ld = new PVector(-bWidth/2.0, bHeight/2.0);
    position = new PVector(0, 0);
    calculateVertices();
  }

  void moveTo(float x, float y) {
    position.set(x, y);
    calculateVertices();
  }

  void rot(float angle) {
    if (this.angle != angle) {
      this.angle = angle;
      calculateVertices();
    }
  }
  void calculateVertices() {
    vertices = new PVector[]{lu.copy().rotate(angle), ru.copy().rotate(angle), rd.copy().rotate(angle), ld.copy().rotate(angle)};
    for (PVector v : vertices) {
      v.add(position);
    }
  }

  Edge [] getEdges() {
    return new Edge[] {new Edge(vertices[0], vertices[1]), new Edge(vertices[1], vertices[2]), 
      new Edge(vertices[2], vertices[3]), new Edge(vertices[3], vertices[0])};
  }

  PVector [] getVertices() {
    return vertices;
  }
}