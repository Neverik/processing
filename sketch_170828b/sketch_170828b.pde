PVector position = new PVector (250, 250);
PVector velocity = new PVector (-20, 10);
PVector acceleration = new PVector (0, 0);

void setup () {
  size (500, 500);
}

void draw () {
  background (50);
  ellipse (position.x, position.y, 5, 5);
  position.add(velocity.x, velocity.y);
  velocity.add(acceleration.x, acceleration.y);
  if (position.x < 0 || position.x > width) {
    velocity.x = -velocity.x;
  }
  if (position.y < 0 || position.y > height) {
    velocity.y = -velocity.y;
  }
}