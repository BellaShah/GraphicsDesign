class Ghost {
  PImage o = loadImage("OrangeGhost.png");
  PImage r = loadImage("RedGhost.png");
  PImage p = loadImage("PinkGhost.png");
  PImage b = loadImage("BlueGhost.png");
  PImage vul = loadImage("vulnerable.png");
  
  String type;
  float x,y,vy,ks,m,ry,w,h;
  int direction, v;
  boolean show = true;
  Ghost(String _type, float _x, float _y,float _w, float _h,float _vy, float _ks,float _m, float _ry, boolean _show, int _direction, int _v) {
    type = _type;
    x = _x;
    y = _y;
    vy = _vy;
    show = _show;
    ks = _ks;
    m = _m;
    ry = _ry;
    w = _w;
    h = _h;
    direction = _direction;
    v = _v;
  }
  
  void start() {
    float f = -(ks * (y - ry));
    float j = f/m;
    vy += j;
    y += vy;
    if(type == "orange" || type == "0") {
      image(o,x,y,w,h);
    }
    else if(type == "red" || type == "1") {
      image(r,x,y,w,h);
    }
    else if(type == "pink" || type == "2") {
      image(p,x,y,w,h);
    }
    else if(type == "blue" || type == "3") {
      image(b,x,y,w,h);
    }
  } 
 
 void chase(){
    if(direction == 1){
     //move right
     x += v;
    } else if(direction == 2){
      //move up
      y -= v;
    } else if(direction == 3){
      //move left
      x -= v;
    } else if(direction == 4){
      //move down
      y += v;
    }
    if(show == true){
      if(type == "orange" || type == "0") {
        image(o,x,y,w,h);
      }
      else if(type == "red" || type == "1") {
        image(r,x,y,w,h);
      }
      else if(type == "pink" || type == "2") {
        image(p,x,y,w,h);
      }
      else if(type == "blue" || type == "3") {
        image(b,x,y,w,h);
      }
    } else {
      image(vul,x,y,w,h);
    }
  }
}