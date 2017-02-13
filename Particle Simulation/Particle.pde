class Particle {
  float x, y;
  float vx, vy;
  float r;
 
  Particle(float _x, float _y, float _vx, float _vy, float _r) {
    x = _x;
    y = _y;
    vx = _vx;
    vy = _vy;
    r = _r;
  }
  
  void applyForces_Bunsen(float _fx, float _fy) {
    vy += _fy;
    float xdir = _fx*random(-1,1);
    if(x > 285 && x < 315) {
      vx += xdir;
    } else {
      vx = -vx;
    }
    y += vy;
    x += vx;
  }
  
  void applyForces_Planets(float _fx, float _fy){
    vy += _fy/r;
    vx += _fx/r;
    y += vy;
    x += vx;
  }
  
  void display() {
    fill(#FA0000);
    ellipse(x, y, r, r);
  }
}