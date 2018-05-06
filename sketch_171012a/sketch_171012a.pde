void setup () {
  size(400,400);
}
void draw () {
  background(125);
  pushMatrix();
    translate(200,200);
    rotate(15);
    rect(0,0,10,10);
  popMatrix();
}