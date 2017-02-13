class RegenParticle extends Particle {
  float ox, oy;
  
  RegenParticle(float _x, float _y, float _vx, float _vy, 
  float _r, float _ox, float _oy) {
    super(_x, _y, _vx, _vy, _r);
    ox = _ox;
    oy = _oy;
  }
  
  void regen(float _vx, float _vy) {
    if (x > width || x < 0 || y > height || y < 0) {
      x = ox;
      y = oy;
      vx = _vx;
      vy = _vy;
    }
  }
                         
}