float y = -45.0;
float x = 420;
float vel = 0.1;
float gravity2=0.03;
float friction = 0.995;
float yy;
float vyy;
float ry;
float m;
float ks;
float kd;
float xx = 0;
PShape aShape;
class Atom {
  Atom(float _yy, float _vyy, float _ry, float _m, float _ks, float _kd){
  yy = _yy;
  vyy = _vyy;
  ry = _ry;
  m = _m;
  ks = _ks;
  kd = _kd;
  }
  void display() {
  aShape = createShape(GROUP);
  fill(#F01307);
  PShape a = createShape(ELLIPSE,xx,yy,10,10);
  fill(#2507F0);
  PShape c = createShape(ELLIPSE,xx+15,yy-10,7,7);
  PShape e = createShape(ELLIPSE,xx-15,yy-10,7,7);
  PShape bb = createShape(ELLIPSE,xx+15,yy+10,7,7);
  PShape dd = createShape(ELLIPSE,xx-15,yy+10,7,7);
  noFill();
  PShape b = createShape(LINE,xx+5,yy,xx+15,yy-10);
  PShape d = createShape(LINE, xx-5,yy,xx-15,yy-10);
  PShape aa = createShape(LINE,xx+5,yy,xx+15,yy+10);
  PShape cc = createShape(LINE, xx-5,yy,xx-15,yy+10);
  aShape.addChild(a);
  aShape.addChild(b);
  aShape.addChild(c);
  aShape.addChild(d);
  aShape.addChild(e);
  aShape.addChild(aa);
  aShape.addChild(bb);
  aShape.addChild(cc);
  aShape.addChild(dd);
  shape(aShape,x,y);
 }
 
void fallDown(){
 if (y<260){ 
 vel += gravity2;
 vel *= friction;
 x -= vel/2;
 y += vel*vel;
 }
}

void applyForce() {
   float f = -(ks * (yy - ry));
   float j = f/m;
   vyy += j;
   yy += vyy;
   translate(320,yy);
}
}