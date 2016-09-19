PFont basic;
String[] words;
IntList allIndexList;

void setup() {
  size(700, 600);
  background(#FFFFFF);
  basic = createFont("Times New Roman", 30);
  textSize(30);
  textFont(basic);
  float xpos = 10;
  float ypos = 30;
  float yinc = 40;
  float w = 0;
  String[] words = loadStrings("uniquewords.txt");
  allIndexList = new IntList();
  int randInd = 0;
  for (int i = 0; i < words.length; i++) {
    allIndexList.append(i);
  }
  
  while(ypos < 600) {
    randInd = round(random(0, allIndexList.size()-1));
    w = textWidth(words[randInd] + " ");
    if(words[randInd].length() > 9) {
      fill(#FFAA29);
    }
    else if(words[randInd].length() > 6) {
      fill(#8E9AFF);
    }
    else {
      fill(#1AAA05);
    }
    if(xpos + w <= 700) {
      text(words[randInd] + " ", xpos, ypos); 
      xpos += w;
    }
    else {
      ypos += yinc;
      xpos = 10;
      text(words[randInd] + " ", xpos, ypos); 
      xpos += w;
    }  
    allIndexList.remove(randInd);
  } 
  
}

void draw() {
  if(mousePressed == true){
    setup();
  }
}