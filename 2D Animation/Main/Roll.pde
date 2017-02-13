class Roll {
 float x, y, speed, limit;
 Roll() {
  x = 0;
  y = 0;
  speed = 0;
  limit = 0;
 }
 Roll(float _x, float _y, float _speed, int _l) {
   x = _x;
   y = _y;
   speed = _speed;
   limit = _l;   
 }
 void update() {
  if(limit > 0) 
  {
    limit -= 1;
    y += speed;
  }
 }
}