class Move {
 float x, y, speed, angle;
 Move(float _x, float _y, float _angle, float _speed) {
   x = _x;
   y = _y;
   speed = _speed;
   angle = _angle;
 }
 void update() {
  x += speed*cos(angle);
  y += speed*sin(angle);
 }
}