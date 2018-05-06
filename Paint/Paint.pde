PImage img;
final float minWidth = 3;
final float maxWidth = 6;
final float minJump = 10;
final float maxJump = 15;
final float len = 3;
final float map_mul = 10;
//final String img_path = "input.jpeg";
final String img_path = "https://www.nature.com/polopoly_fs/7.44180.1495028629!/image/WEB_GettyImages-494098244.jpg_gen/derivatives/landscape_630/WEB_GettyImages-494098244.jpg";
final int iter = 500;
final float opacity = 1.5;

boolean drawn = true;

void setup () {
  img = loadImage(img_path);
  surface.setSize(img.width, img.height);
  surface.setVisible(false);
}

void draw() {
  if (drawn) {
      img.loadPixels();
      for (int none = 0; none < iter; none++) {
        for (int x = 0; x < img.width; x += random(minJump, maxJump)) {
          for (int y = 0; y < img.height; y += random(minJump, maxJump)) {
            color c = img.pixels[y * img.width + x];
            float r = red(c);
            float g = green(c);
            float b = blue(c);
            float w = random(minWidth, maxWidth);
            stroke(r, g, b, random(100) / w * opacity);
            strokeWeight(w);
            float angle = noise((float)x / img.width * map_mul + random(200, 2000), (float)y / img.height * map_mul + random(200, 2000)) * TWO_PI;
            line(x, y, x + sin(angle) * w * len * noise(x), y + cos(angle) * w * len * noise(y));
          }
        }
      }
      saveFrame("output.jpeg");
      drawn = false;
      exit();
  }
}