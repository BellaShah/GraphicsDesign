PFont txt;
void setup(){
  size(800,600);
  txt = createFont("Arial", 12, true);
  background(255);
  String[] words = loadStrings("letterfrequency.txt");
  //x axis: letter
  //y axis: relative frequency
  float x = 0;
  float y = 575;
  float inc = 30;
  int max = 0;
  for(int i = 0; i < words.length; i++){
    String temp[] = words[i].split(":");
    if(int(temp[1]) > max){
      max = int(temp[1]); 
    }
  }
  for(int i = 0; i < words.length; i++){
    String line[] = words[i].split(":");
    String letter = line[0];
    float h = float(line[1])/max*575;
    y = y - h;
    stroke(0);
    rect(x,y,inc,h);
    fill(0);
    text(letter,x+inc/2,590);
    noFill();
    x = x+inc;
    y = 575;
  }
}