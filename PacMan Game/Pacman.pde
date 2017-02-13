class Pacman extends Entity{
  float r = 35;
  int toggle = 0;
  float angle = 0;
  
  Pacman(float _x, float _y, float _v, int _direction){
    super(_x, _y, _v, _direction);
    x = _x;
    y = _y;
    v = _v;
    direction = _direction;
  }
  
  void display(){
    //animate Pacman here
    if(direction == 1){
      //move right
      angle = 0;
      x+=v;
    } else if(direction == 2){
      //move up
      angle = 3*PI/2;
      y -= v;
    } else if(direction == 3){
      //move left
      angle = PI;
      x -= v;
    } else if(direction == 4){
      //move down
      angle = PI/2;
      y += v;
    }
    //animate Pacman here 
    fill(#FFEE00);
    if(toggle % 8 == 0 || toggle % 8 == 1) {
      arc(x, y, r, r, QUARTER_PI+angle, 2*PI-QUARTER_PI+angle, PIE);
    } else if (toggle % 8 == 2 || toggle % 8 == 3) {
      //rotate(angle);
      arc(x, y, r, r, PI/6+angle, 2*PI-PI/6+angle, PIE);
    } else if (toggle % 8 == 4 || toggle % 8 == 5){
      //rotate(angle);
      ellipse(x,y,r,r);
    } else if (toggle % 8 == 6 || toggle % 8 == 7){
      //rotate(angle);
      arc(x, y, r, r, PI/6+angle, 2*PI-PI/6+angle, PIE);
    } 
    toggle++;
  }
}