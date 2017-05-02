Pattern tl, tr, bl, br; //top left, top right, bottom left, bottom right

void setup() {
  size(400, 400);
  tl = new Pattern(0, 0, 200, true, 0);        //top left
  tr = new Pattern(200, 0, 200, false, PI/2);  //top right
  bl = new Pattern(0, 200, 200, false, -PI/2); //bottom left
  br = new Pattern(200, 200, 200, true, PI);   //bottom right
}

void draw() {
  tl.update();
  tr.update();
  bl.update();
  br.update();
  tl.draw();
  tr.draw();
  bl.draw();
  br.draw();
  fill(255, 0, 0);
  text(int(frameRate), 5, 15);
}

void mouseClicked() {
  if ((mouseX < width/2) && (mouseY < height/2)) {
    tl.startAnimation();
  } else if ((mouseX >= width/2) && (mouseY < height/2)) {
    tr.startAnimation();
  } else if ((mouseX < width/2) && (mouseY >= height/2)) {
    bl.startAnimation();
  } else if ((mouseX >= width/2) && (mouseY >= height/2)) {
    br.startAnimation();
  }
}

class Pattern {
  int xp, yp, Size;
  boolean black;
  float angle;
  float x, y, w, h, r;
  float speed = 10;
  float wave = -125; //x-pos of the distortion 
  boolean animationRunning = false;
  boolean forwards = false;

  Pattern (int xp, int yp, int Size, boolean black, float angle) {
    this.xp = xp;
    this.yp = yp;
    this.Size = Size;
    this.black = black;
    this.angle = angle;
  }

  void update() {
    println("hellooo");
    if (animationRunning) {
      wave += forwards?1:-1;
      wave *= speed;
      if ((wave > -10) || (wave < -125)) {
        animationRunning = false;
      }
    }
  }

  void startAnimation() {
    animationRunning = true;
    forwards = !forwards;
  }

  void draw() {
    PGraphics pg = createGraphics(200, 200, JAVA2D);

    pg.beginDraw();
    pg.smooth();
    pg.noStroke();
    pg.background(black?0:255);

    pg.pushMatrix();
    pg.translate(Size/2, Size/2);
    pg.rotate(angle);

    // RECTANGLE 1
    pg.fill(black?255:0);
    pg.rect(-125, -100, Size+25, Size, 25, 25);

    // RECTANGLE 2
    pg.fill(black?0:255);
    pg.rect(-125, -100, Size, Size-25, 25, 25);

    // 4 RECTANGLES TO THE RIGHT
    for (int i=0; i<4; i++) {
      black=!black;
      pg.fill(black?0:255);
      x = wave;
      y = -Size/2+i*25;
      w = Size/2-i*25 - wave;
      h = (i==0)?Size/2:Size-(2*i)*25;
      r =  (w>25)?25:15;
      if (w>0) {
        pg.rect(x, y, w, h, r, r);
      }
    }

    //6 RECTANGLES TO THE LEFT
    for (int i=0; i<6; i++) {
      black=!black;
      pg.fill(black?0:255);
      pg.rect(-125, -125, Size/2+25+wave, 175-i*25, 25, 25);
    }

    pg.popMatrix();
    pg.endDraw();

    image(pg, xp, yp);
  }
}


