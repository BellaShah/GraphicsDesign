int currentChannel = 0;
XML root;
int articleStart = 0;
int articleNumber = 10;
int selectedArticle = 0;
color[] Colors = {#66D9EF, #A6E22E, #FD971F, #F92672, #AE81FF};
String[] Channels = {"UK","WORLD","POLITICS","BUSINESS","SCIENCE"};
XML[] articles = new XML[20];
XML[] descriptions = new XML[20];
XML[] links = new XML[20];
Radio[] radioButtons = new Radio[5];

void setup(){
  size(800,800);
  background(#272822);
  //radio buttons
  for (int i = 0; i < radioButtons.length; i++) {
    textSize(10);
    fill(Colors[i]);
    int y = 75 + i*50;
    text(Channels[i],700,y);
    radioButtons[i] = new Radio(770, y, 10, Colors[i], color(0), i, radioButtons);
    if(i == currentChannel){
      radioButtons[i].isChecked = true;
    } 
  }
  //check for channel
  switch(currentChannel){
  case 0: root = loadXML("http://feeds.bbci.co.uk/news/uk/rss.xml");
    break;
  case 1: root = loadXML("http://feeds.bbci.co.uk/news/world/rss.xml");
    break;
  case 2: root = loadXML("http://feeds.bbci.co.uk/news/politics/rss.xml");
    break;
  case 3: root = loadXML("http://feeds.bbci.co.uk/news/business/rss.xml");
    break;
  case 4: root = loadXML("http://feeds.bbci.co.uk/news/science_and_environment/rss.xml");
    break;
  default: root = loadXML("http://feeds.bbci.co.uk/news/world/rss.xml");
    break;
  }
  //get titles, descriptions, links
  articles = root.getChildren("channel/item/title");
  descriptions = root.getChildren("channel/item/description");
  links = root.getChildren("channel/item/guid");
  fill(Colors[currentChannel]);
  textSize(30);
  text(root.getChild("channel/title").getContent(),10,35);
  textSize(18);
  text(root.getChild("channel/lastBuildDate").getContent(), 20, 60);
  if(articles.length < articleStart + articleNumber){
    articleNumber = articles.length-articleStart;  
  }
  int temp_counter = 0;
  //draw articles
  for(int i = articleStart; i < articleStart + articleNumber; i++){
    text(articles[i].getContent(), 50, 100+temp_counter*60); 
    temp_counter++;
  }
}

void draw(){
  fill(Colors[currentChannel]);
  rect(0,700,800,100);
  fill(0);
  textSize(16);
  if(mouseY > 70 && mouseY < 700){
    selectedArticle = floor(mouseY-70.00)/60;
  }
  text(descriptions[selectedArticle].getContent(),20,720,800,100);
  fill(Colors[currentChannel]);
  rect(700,0,50,50);
  rect(750,0,50,50);
  fill(0);
  textSize(50);
  text("<",705,40);
  text(">",755,40);
  //check for radio button
  for (Radio r : radioButtons) {
    r.display();
  }
}

void mousePressed(){
    for (int i = 0; i < radioButtons.length; i++) {
      if(radioButtons[i].isPressed(mouseX, mouseY)){
        currentChannel = i;
        articleStart = 0;
        setup();
      }
    }
    if(mouseX > 700 && mouseX < 750 && mouseY > 0 && mouseY < 50){
      if(articleStart > 1){
        articleStart -= 10;
        articleNumber = 10;
        setup();
      }
    }
    if(mouseX > 750 && mouseX < 800 && mouseY > 0 && mouseY < 50){
      if(articleStart + 10 < articles.length){
        articleStart += 10;
        setup();
      }
    }
    if(mouseX > 0 && mouseX < 700 && mouseY > 70 && mouseY <700){
      link(links[selectedArticle].getContent());
    }
}