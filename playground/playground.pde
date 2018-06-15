import com.hamoid.*;
import shiffman.box2d.*;

import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;


final boolean PERFORM_RECORDING = false;
final int SCREEN_WIDTH = 1024;
final int SCREEN_HEIGHT = 768;
final int CELL_WIDTH = 7;
final int CELL_HEIGHT = CELL_WIDTH;

VideoExport videoExport;
long lastFrame;

ImpulseGrid grid;
GridRenderer render;
Box2DProcessing box2d;

// A list we'll use to track fixed objects
ArrayList<Boundary> boundaries;
// A list for all of our rectangles
ArrayList<Box> boxes;


// ------------
void setup() {
  size(1024, 768, P2D);
  //fullScreen();
  background(0);
  //fullScreen(P2D );
  stroke(70);
  fill(200);
  rectMode(CENTER);
  frameRate(100);
  lastFrame = millis();

  grid = new ImpulseGrid(width/CELL_WIDTH, height/CELL_HEIGHT, CELL_WIDTH, CELL_HEIGHT, CELL_WIDTH/2, CELL_HEIGHT/2);
  println("Grid size: " + grid.width + " : " + grid.height);
  render = new GridRenderer(grid);

  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, -10);

  // Create ArrayLists  
  boxes = new ArrayList<Box>();
  boundaries = new ArrayList<Boundary>();

  // Add a bunch of fixed boundaries
  boundaries.add(new Boundary(width/4, height-5, width/2-50, 10));
  boundaries.add(new Boundary(3*width/4, height-50, width/2-50, 10));


  if (PERFORM_RECORDING) {
    videoExport = new VideoExport(this, "interactive.mp4");
    videoExport.startMovie();
  }
}

void draw() {
  long frame = millis();
  //float delta = (frame - lastFrame)/1000.0;
  lastFrame = frame;


  clear();

  drawAll();
  updateAll(1.0/60.0);

  videoCapture();
  printfps();
}

void drawAll() {
  // We must always step through time!
  box2d.step();

  // Boxes fall from the top every so often
  if (random(1) < 0.2) {
    Box p = new Box(width/2,30);
    boxes.add(p);
  }

  // Display all the boundaries
  for (Boundary wall: boundaries) {
    wall.display(render);
  }

  // Display all the boxes
  for (Box b: boxes) {
    b.display(render);
  }

  // Boxes that leave the screen, we delete them
  // (note they have to be deleted from both the box2d world and our list
  for (int i = boxes.size()-1; i >= 0; i--) {
    Box b = boxes.get(i);
    if (b.done()) {
      boxes.remove(i);
    }
  }
  grid.draw();
}

void updateAll(float delta) {
  grid.update(delta);
}

void keyPressed() {
  if (key == 'q') {
    processExit();
  }
  if (key == 'a') {
  }
  if (key == 'c') {
  }
}

void printfps() {
  if (frameCount%100 == 0) {
    println("FPS : " + frameRate);
  }
}
void processExit() {
  exit();
}

void videoCapture() {
  if (PERFORM_RECORDING) {
    videoExport.saveFrame();
  }
}
