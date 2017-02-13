// The class Slot is the object showing the Icon objects "rolling" in each slot
class Icon extends Roll {
  int xpos, ypos;
  String type;
  Icon(int _x, int _y, String s, int spd, int _l) {
    xpos = _x;
    ypos = _y;
    type = s;
    speed = spd;
    limit = _l;
  }
  void display() {
    pushMatrix();
    translate(x, y);
    if (type == "bomb") {
      fill(#010101);
      ellipse(xpos, ypos, 30, 30);
      noFill();
      bezier(xpos + 10, ypos - 25, xpos, ypos - 20, xpos + 10, ypos + 5, xpos + 15*cos(PI/3), ypos+5-15*sin(PI/3));
      fill(#FCFC33);
      triangle(xpos + 17, ypos - 14, xpos + 13, ypos - 12, xpos + 12, ypos - 23);
      fill(#ED691D);
      triangle(xpos + 20, ypos - 15, xpos + 10, ypos - 15, xpos + 15, ypos - 20);
    }
    else if(type == "cherry") {
      stroke(#010101);
      strokeWeight(1);
      fill(#FF1008);
      ellipse(xpos - 6, ypos + 1, 25, 25);
      ellipse(xpos + 7, ypos + 13, 20, 20);
      noFill();
      stroke(#10C604);
      strokeWeight(3);
      curve(xpos+7+7.5*cos(4*PI/3), ypos+11+7.5*sin(4*PI/3), xpos-6+7.5*cos(5*PI/3), ypos+1+7.5*sin(5*PI/3), xpos+18, ypos-23, xpos-25, ypos-28);
      curve(xpos+7+7.5*cos(4*PI/3), ypos+11+7.5*sin(4*PI/3), xpos+7+7.5*cos(5*PI/3), ypos+11+7.5*sin(5*PI/3), xpos+18, ypos-23, xpos-25, ypos-28);
    }
    else if (type == "bar") {
      fill(#010101);
      textSize(32);
      text("BAR", xpos-29, ypos+11);
      strokeWeight(3);
      line(xpos-26, ypos-16, xpos+27, ypos-16);
      line(xpos-26, ypos+15, xpos+27, ypos+15);
    }
    else if (type == "face") {
      fill(#FEFF0A);
      ellipse(xpos, ypos, 45, 45);
      stroke(#010101);
      strokeWeight(2);
      line(xpos-7,ypos-15,xpos-7,ypos-5);
      line(xpos+7,ypos-15,xpos+7,ypos-5);
      arc(xpos, ypos, 25, 25, PI/5, 4*PI/5);
    }
    else if (type == "seven") {
      fill(#FF9E0A);
      ellipse(xpos, ypos, 50, 50);
      fill(#F6FF0A);
      ellipse(xpos, ypos, 40, 40);
      fill(#FF3B0A);
      textSize(42);
      text("7", xpos-12, ypos+17);
    }
    popMatrix();
  }
}