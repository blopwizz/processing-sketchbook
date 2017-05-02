Button b;
color colorBackground = 0;

void setup() {
  size (400, 400);
  frameRate(25);
  b = new Button();
}

void draw() {
  background(colorBackground);
  b.draw();
  text("FPS " + int(frameRate), 5, 15);

}

class Button {
  color basecolor = 140;
  color highlight = 210;
  int x = width/2;
  int y = height/2;
  int w = 100;
  int h = 100;
  
  boolean mouseIsOver() {
    return (((mouseX > x ) && (mouseX < x+w)) && ((mouseY > y) && (mouseY < y + h)));
  }

  void draw() {
    if (this.mouseIsOver()) {
      fill(highlight);
    }
    else {fill(basecolor);}
    rect (x, y, w, h);
  }
}

void mouseClicked() {
  if(b.mouseIsOver()) {
    colorBackground = 255 - colorBackground;
  }
}

