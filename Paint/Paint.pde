PImage img;
final float minWidth = 3;
final float maxWidth = 7;
final float minJump = 5;
final float maxJump = 10;
final float len = 4;
final float map_mul = 10;
final String img_path = "/Users/svs/Desktop/Code/Processing/Paint/frog.jpeg";
final int multiplier = 3;
final int iter = 500;
final float opacity = 2.5;
 
void setup () {
  img = loadImage(img_path);
  fullScreen();
  img.loadPixels();
  for (int none = 0; none < iter; none++) {
    for (int nx = 0; nx < img.width; nx += random(minJump, maxJump)) {
      for (int ny = 0; ny < img.height; ny += random(minJump, maxJump)) {
        color c = img.pixels[ny * img.width + nx];
        float r = red(c);
        float g = green(c);
        float b = blue(c);
        float w = random(minWidth, maxWidth);
        stroke(r, g, b, random(100) / w * opacity);
        strokeWeight(w);
        int x = nx * multiplier;
        int y = ny * multiplier;
        float angle = noise((float)nx / img.width * map_mul, (float)ny / img.height * map_mul) * TWO_PI;
        line(x, y, x + sin(angle) * w, y + cos(angle) * w);
      }
    }
  }
}