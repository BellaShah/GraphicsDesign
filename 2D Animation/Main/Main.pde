Dollar[] dolladolla;
boolean isRolling = false;
boolean hasWon = false;
boolean playAgain = false;
String[] iconTypes;
Icon[] slot1;
Icon[] slot2;
Icon[] slot3;
int time1 = 0;
int time2 = 0;
int time3 = 0;
int playCounter = 0;
String winning;

void setup () {
  size(600, 500);
  playCounter += 1;
  dolladolla = new Dollar[50];
  for(int i = 0; i < dolladolla.length; i++){
    dolladolla[i] = new Dollar(random(90,255), random(355,385), random(2*PI), random(10,15), random(50 ,70));  
  }
  iconTypes = new String[5];
  iconTypes[0] = "bomb";
  iconTypes[1] = "cherry";
  iconTypes[2] = "seven";
  iconTypes[3] = "bar";
  iconTypes[4] = "face";
  frameRate(40);
  println(playCounter);
  if(playCounter == 3){
    time1 = 100;
    time2 = 200;
    time3 = 300;
    winning = iconTypes[getRandom(0,4)];
  } else {
    time1 = getRandom(5,10)*10;
    time2 = getRandom(15,20)*10;
    time3 = getRandom(25,30)*10;
  }
  slot1 = new Icon[23];
  slot1[0] = new Icon(185,300,iconTypes[getRandom(0,4)],10,time1);
  for(int i = 1; i < slot1.length; i++){ 
    String temp1 = iconTypes[getRandom(0,4)];
    while(temp1 == slot1[i-1].type){
       temp1 = iconTypes[getRandom(0,4)];
    }
    if(playCounter == 3 && i == 21){ 
      slot1[i] = new Icon(185,300-i*50,winning,10,time1);
    } 
    else {
      slot1[i] = new Icon(185,300-i*50,temp1,10,time1);
    }
  }
  slot2 = new Icon[43];
  slot2[0] = new Icon(300,300,iconTypes[getRandom(0,4)],10,time2);
  for(int i = 1; i < slot2.length; i++){ 
    String temp1 = iconTypes[getRandom(0,4)];
    while(temp1 == slot2[i-1].type){
       temp1 = iconTypes[getRandom(0,4)];
    }
    if(playCounter == 3 && i == 41){ 
      slot2[i] = new Icon(300,300-i*50,winning,10,time2);
    } 
    else {
      slot2[i] = new Icon(300,300-i*50,temp1,10,time2);
    } 
  }
  slot3 = new Icon[63];
  slot3[0] = new Icon(415,300,iconTypes[getRandom(0,4)],10,time3);
  for(int i = 1; i < slot3.length; i++){ 
    String temp1 = iconTypes[getRandom(0,4)];
    while(temp1 == slot3[i-1].type){
       temp1 = iconTypes[getRandom(0,4)];
    }
    if(playCounter == 3 && i == 61){ 
      slot3[i] = new Icon(415,300-i*50,winning,10,time3);
    } 
    else {
      slot3[i] = new Icon(415,300-i*50,temp1,10,time3);
    } 
  }
}

void draw (){
     background(255);
     if(isRolling){
      for(int i = 0; i < slot1.length; i++){ 
        slot1[i].display();
        slot1[i].update();
      }
      for(int i = 0; i < slot2.length; i++){ 
        slot2[i].display();
        slot2[i].update();
      }
      for(int i = 0; i < slot3.length; i++){ 
        slot3[i].display();
        slot3[i].update();
      }
      if(slot3[slot3.length-1].limit == 0){
        if(slot1[time1/5+1].type == slot2[time2/5+1].type && slot2[time2/5+1].type == slot3[time3/5+1].type){
          hasWon = true; 
        }
        else if(playPressed()){
          setup();
        }
      }
    }
    //slot machine
    fill(#5D5959);
    noStroke();
    rect(0, 0, 600, 175);
    rect(0,175,150,150);
    rect(220,175,45,150);
    rect(335,175,45,150);
    rect(450,175,150,150);
    rect(0,325,600,175);
    if(!isRolling){
      fill(#C4BEBE);
    } else {
      fill(#ffff00); 
    }
    rect(75,75,450,70,7);
    fill(0);
    textSize(15);
    text("SUPER", 275, 100);
    textSize(25);
    if(hasWon){text("WINNER", 260, 130);}
    else{text("SLOTS", 260, 130);}
    fill(#37C450);
    //play button
    ellipse(500, 400, 70, 70);
    fill(#F0560F);
    textSize(15);
    text("PLAY", 484, 405);
    for (int i = 40; i < 575; i = i+40) {
          fill(#F73737);
          ellipse(i, 25, 30, 30);
          ellipse(i, 475, 30, 30);
    }
    fill(#4B4949);
    noStroke();
    rect(70,350,300,90);
    stroke(0);
    fill(63,183,48);
    if(isRolling == false && playPressed()){
      isRolling = true;
    }
    if(hasWon){
      makeItRain();
    } 
}

void makeItRain(){
  //draw dollar bills
  rect(90, 355, 100, 50);
  rect(100, 365, 100, 50);
  rect(110, 375, 100, 50);
  rect(120, 385, 100, 50);
  rect(225, 355, 100, 50);
  rect(235, 365, 100, 50);
  rect(245, 375, 100, 50);
  rect(255, 385, 100, 50);
  fill(0);
  text("$100",150,430);
  text("$100",285,430);
  for (int i = 0; i < dolladolla.length; i++){
    dolladolla[i].display();
    dolladolla[i].update();
  }
}

int getRandom(int min, int max) {
  return (int)(Math.random() * (max - min) + min);
}

boolean playPressed(){
  return (mousePressed == true && mouseX >= 465 && mouseX <= 535 && mouseY <= 435 && mouseY >= 365); 
}