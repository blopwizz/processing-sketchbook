float wave = -125; //x-pos of the distortion 
float x, y, w, h, r;
boolean animationRunning = false;
boolean forward = false;
float speed = 10;

void setup() {
  size(400, 400);
  frameRate(60);
}

void draw() {
  if (animationRunning) {
    wave += forward?speed:-speed;
    if ((wave > -10) || (wave < -125)) {
    animationRunning = false;}
  }
  
  drawPattern(0, 0, 200, true, 0);
  drawPattern(200, 0, 200, false, PI/2);
  drawPattern(0, 200, 200, false, -PI/2);
  drawPattern(200, 200, 200, true, PI);
}


void mouseClicked() {
  animationRunning = true;
  forward = !forward;
}

void drawPattern(int xp, int yp, int Size, boolean black, float angle) {
  PGraphics pg = createGraphics(200, 200, JAVA2D);

  pg.beginDraw();
  pg.smooth();
  pg.noStroke();
  pg.background(black?0:255);

  pg.pushMatrix();
  pg.translate(Size/2, Size/2);
  pg.rotate(angle);
  
  pg.fill(black?255:0);
  pg.rect(-125, -100, Size+25, Size, 25, 25);
  
  pg.fill(black?0:255);
  pg.rect(-125, -100, Size, Size-25, 25, 25);
  
  for (int i=0; i<4; i++) {
    black=!black;
    pg.fill(black?0:255);
    x = wave;
    y = -Size/2+i*25;
    w = Size/2-i*25 - wave;
    h = (i==0)?Size/2:Size-(2*i)*25;
    r =  (w>25)?25:15;
    if (w>0) {pg.rect(x, y, w, h, r, r);} 
}

  for (int i=0; i<6; i++) {
    black=!black;
    pg.fill(black?0:255);
    pg.rect(-125, -125, Size/2+25+wave, 175-i*25, 25, 25);
  }

  pg.popMatrix();
  pg.endDraw();

  image(pg, xp, yp);
}


