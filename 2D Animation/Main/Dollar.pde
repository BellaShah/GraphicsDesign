class Dollar extends Move {
  float loc; 
  Dollar(float _x, float _y, float _angle, float _speed, float _loc) {
    super(_x, _y, _angle, _speed);
    loc = _loc;
  }
  void display() {
    pushMatrix();
    translate(x, y);
    fill(63,183,48);
    rect(-loc, 0, loc*2, loc);
    fill(0);
    text("$100", loc-70, loc-10);
    popMatrix();
  }
}