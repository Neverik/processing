float xpos = 100;
float ypos = 100;

float xspeed = randomTwo();
float yspeed = randomTwo();

float speedMultiplier = 1;

float rightYpos = 250;

int score = 0;

void setup () {
  background(0);
  size(500,500);
  
  stroke (255);
  fill (255);
}

void draw () {
  
  rightYpos = mouseY;
  
  background(0);
  
  if (xpos < 0 || xpos > width) {
    if (xpos > width) {
      xpos = 250;
      ypos = 250;
      xspeed = randomTwo();
      yspeed = randomTwo();
      speedMultiplier = 1;
    } else {
      xspeed *= -1;
      if (speedMultiplier <= 7.5) {
        speedMultiplier += 0.5;
      }
    }
  }
  
  if (ypos < 0 || ypos > width) {
    yspeed *= -1;
    if (speedMultiplier <= 7.5) {
      speedMultiplier += 0.5;
    }
  }
  
  if (xpos >= 470 && (ypos - rightYpos) > 0 && (ypos - rightYpos) < 50 && xpos <= 480) {
    xspeed = xspeed * -1;
    xpos = 470;
    score = score + 1;
    if (speedMultiplier <= 7.5) {
      speedMultiplier += 1;
    }
  }
  
  xpos += (xspeed * speedMultiplier);
  ypos += (yspeed * speedMultiplier);
  
  rect (xpos, ypos, 10, 10);
  
  rect (475, rightYpos, 10, 50);
  
  /*
  textSize (30);
  text ("SCORE: " + score, 250, 50);
  */
  
}

float randomTwo () {
  float getrand = random (0.0, 2.0);
  
  if (getrand > 1) {
    return random (-0.5, -1.0);
  } else {
    return random (0.5, 1.0);
  }
}