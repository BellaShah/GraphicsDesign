class Burner {
  float x, y;
  PShape b;
 
  Burner(float _x, float _y) {
    x = _x;
    y = _y;
    b = createShape();
    b.beginShape();
    b.fill(#6F6E6E);
    b.noStroke();
    b.vertex(x-30, y);
    b.vertex(x-100, y);
    b.vertex(x-100, y+70);
    b.vertex(x-30, y+40);
    b.vertex(x-30, y+70);
    b.vertex(x+30, y+70);
    b.vertex(x+30, y+40);
    b.vertex(x+100, y+70);
    b.vertex(x+100, y);
    b.vertex(x+30, y);
    b.vertex(x+30, y-200);
    b.vertex(x+15, y-200);
    b.vertex(x+15, y);
    b.vertex(x-15, y); 
    b.vertex(x-15, y-200);
    b.vertex(x-30, y-200);
    b.endShape(CLOSE);
  }
  
  void display() {
    shape(b, x, y);
  }
}