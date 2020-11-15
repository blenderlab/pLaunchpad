void draw_squares(){
    fill(0, 0, 200);
    rect(int(random(width)), int(random(width)),10 , 10); 
}

void draw_circles(){

}


void draw_lines(){
  //background(0, 0, 90);
  fill(frameCount % 120, frameCount % 200, frameCount % 255);
  strokeWeight(0);
  stroke(0);
  float offset = width / 20;
  int margin = 0;
  int cells = 10;
  float d = (width - offset * 2 - margin * (cells - 1)) / cells;
  strokeWeight(d/30);
  randomSeed(0);
  for (int j = 0; j < cells; j++) {
    for (int i = 0; i < cells; i++) {
      float x = offset + i * (d + margin);
      float y = offset + j * (d + margin);
      if (random(100) > 50) {
        drawFreqLine(x, y, x + d, y + d);
      } else {
        drawFreqLine(x + d, y, x, y + d);
      }
    }
  }
}



void drawFreqLine(float x1, float y1, float x2,float y2) {

  float d = dist(x1, y1, x2, y2);
  float a = atan2(y2 - y1, x2 - x1);
  float h1 = random(1, 3)  * (random(100) > 50 ? -1 : 1);
  float h2 = random(1, 3)  * (random(100) > 50 ? -1 : 1);
  float f1 = map(sin(x1 + y1 * width + frameCount * h1/100), -1, 1, 0, 1);
  float f2 = map(cos(x2 + y2 * width + frameCount * h2/100), -1, 1, 0, 1);
  float s1 = d * f1;
  float s2 = d * f2;
  float t = dist(s1, 0, s2, 0) / d;
  push();
  translate(x1, y1);
  rotate(a);
  line(0, 0, d, 0);
  line(s1, 0, s2, 0);
  circle(s1, 0, d /2 * t);
  circle(s2, 0, d /2 * t);
  pop();

}
