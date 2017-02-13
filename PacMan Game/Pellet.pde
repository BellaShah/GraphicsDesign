class Pellet{
  float x, y, r;
  boolean Eaten;
  boolean Super;
  int ticker = 0;
  
  Pellet(float _x, float _y, float _r, boolean _Eaten, boolean _Super){
    x = _x;
    y = _y;
    r = _r;
    Eaten = _Eaten;
    Super = _Super;
  }
  
  void display(){
    if(Super && ticker == 1){
      fill(255);
      ellipse(x,y,r*2,r*2);
      ticker *= -1;
    } else{
      fill(255);
      ellipse(x, y, r, r);
    }
  }
}