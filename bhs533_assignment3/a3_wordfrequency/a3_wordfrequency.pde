void setup(){
  size(800,600);
  background(255);
  String[] words = loadStrings("wordfrequency.txt");
  //y axis: frequency
  //x axis: # of words per frequency
  float x = 400;
  float y = 600;
  float inc = 5;
  int max = 0;
  for(int i = 0; i < words.length; i++){
    String temp[] = words[i].split(":");
    if(int(temp[1]) > max){
      max = int(temp[1]); 
    }
  }
  for(int i = 0; i < words.length; i++){
    String line[] = words[i].split(":");
    float w = float(line[1])/max*800;
    x = x - w/2;
    y = y-inc;
    stroke(0);
    rect(x,y,w,inc);
    x = 400;
  }
}