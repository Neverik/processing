final String normal_path = "normal.jpeg";
final String image_path = "image.jpeg";
final float blur = 0.7;
PImage normal_img;
PImage img;
boolean drawn = true;
color[] colors = {
  color(255)
};

void setup () {
  normal_img = loadImage(normal_path);
  img = loadImage(image_path);
  surface.setSize(normal_img.width, normal_img.height);
  surface.setVisible(false);
}

void draw() {
  if (drawn) {
    image(normal_img, 0, 0);
    filter(BLUR, blur);
    loadPixels();
    for (int t = 0; t < width * height; t++) {
      color c1 = pixels[t];
      color c2 = normal_img.pixels[t];
      float r = red(c2) - red(c1);
      float g = green(c2) - green(c1);
      float b = blue(c2) - blue(c1);
      if (r + g + b > 10) {
        pixels[t] = color(0);
      } else {
        float minDist = 500;
        color c4 = color(255);
        for (color c3: colors) {
          float dist = dist(red(c1), green(c1), blue(c1), red(c3), green(c3), blue(c3));
          if (dist < minDist) {
            c4 = c3;
            minDist = dist;
          }
        }
        pixels[t] = c4;
      }
    }
    updatePixels();
    saveFrame("output.jpeg");
    exit();
    drawn = false;
  }
}