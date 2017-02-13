class Fruits {
  PImage Apple = loadImage("Apple.png");
  PImage Cherry = loadImage("Cherry.png");
  PImage Orange = loadImage("Orange.png");
  PImage Strawberry = loadImage("Strawberry.png");
  float x,y;
  int h,w,type;
  boolean show;

  Fruits(int _type, float _x, float _y, int _w, int _h, boolean _show ){
    type = _type;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    show = _show;
  }
  
  void displayFruit() {
    if(show){
      if(type == 0) {
        image(Apple,x,y,w,h);
      }
      else if(type == 1) {
        image(Cherry,x,y,w,h);
      }
      else if(type == 2) {
        image(Orange,x,y,w,h);
      }
      else if(type == 3) {
        image(Strawberry,x,y,w,h);
      }
    }  
  }
}