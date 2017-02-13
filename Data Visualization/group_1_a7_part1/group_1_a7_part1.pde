Table theTable;
int[] numArrests = new int[10];
int[] years = {2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015};
XML news;

void part1_Graph(){
  theTable = loadTable("arrest_data_2006-2015.csv", "header");
  for (int i = 0; i < years.length; i++){
    for (TableRow row : theTable.rows()) {
      if(row.getInt("YEAR") == years[i]) {
        numArrests[i] += row.getInt("F_TOTAL");
      }
    }
  }
}

void setup(){
  size(800, 600);
  part1_Graph();
  print(numArrests[0]);
}

void draw(){
  background(#96F5F7);
  textSize(13);
  line(100,75,95,90);
  line(100,75,100,500);
  line(100,500,700,500);
  line(700,500,685,505);
  fill(50);
  text("2006",150,520);
  text("2007",200,520);
  text("2008",250,520);
  text("2009",300,520);
  text("2010",350,520);
  text("2011",400,520);
  text("2012",450,520);
  text("2013",500,520);
  text("2014",550,520);
  text("2015",600,520);
  text("Year",400,540);
  text("200",70,475);
  text("250",70,425);
  text("300",70,375);
  text("350",70,325);
  text("400",70,275);
  text("450",70,225);
  text("500",70,175);
  text("550",70,125); 
  pushMatrix();
  translate(30, 325);
  rotate(-HALF_PI);
  text("Arrests", 0, 0);
  popMatrix();
  pushMatrix();
  translate(50, 350);
  rotate(-HALF_PI);
  text("(in thousands)", 0, 0);
  popMatrix();
  int xpos = 170;
  for (int total : numArrests){
    ellipse(xpos, -total/1000 + 675, 10, 10);
    xpos += 50;
  }
  xpos = 170;
  noFill();
  beginShape();
  for (int total : numArrests){
    vertex(xpos, -total/1000 + 675);
    xpos += 50;
  }
  endShape();
  textSize(20);
  text("Total Number of Annual Arrests in Los Angeles", 170, 60);
  if(dist(mouseX,mouseY,170,(-numArrests[0]/1000)+675)<10){
    fill(#EA0505);
    textSize(11);
    text(numArrests[0]+" arrests",mouseX-20,mouseY-10);
  }
  if(dist(mouseX,mouseY,220,(-numArrests[1]/1000)+675)<10){
    fill(#EA0505);
    textSize(11);
    text(numArrests[1]+" arrests",mouseX-20,mouseY-10);
  }
 if(dist(mouseX,mouseY,270,(-numArrests[2]/1000)+675)<10){
    fill(#EA0505);
    textSize(11);
    text(numArrests[2]+" arrests",mouseX-20,mouseY-10);
  }
 if(dist(mouseX,mouseY,320,(-numArrests[3]/1000)+675)<10){
    fill(#EA0505);
    textSize(11);
    text(numArrests[3]+" arrests",mouseX-20,mouseY-10);
  }
 if(dist(mouseX,mouseY,370,(-numArrests[4]/1000)+675)<10){
    fill(#EA0505);
    textSize(11);
    text(numArrests[4]+" arrests",mouseX-20,mouseY-10);
  }
 if(dist(mouseX,mouseY,420,(-numArrests[5]/1000)+675)<10){
    fill(#EA0505);
    textSize(11);
    text(numArrests[5]+" arrests",mouseX-20,mouseY-10);
  }
 if(dist(mouseX,mouseY,470,(-numArrests[6]/1000)+675)<10){
    fill(#EA0505);
    textSize(11);
    text(numArrests[6]+" arrests",mouseX-20,mouseY-10);
  }
if(dist(mouseX,mouseY,520,(-numArrests[7]/1000)+675)<10){
    fill(#EA0505);
    textSize(11);
    text(numArrests[7]+" arrests",mouseX-20,mouseY-10);
  }
if(dist(mouseX,mouseY,570,(-numArrests[8]/1000)+675)<10){
    fill(#EA0505);
    textSize(11);
    text(numArrests[8]+" arrests",mouseX-20,mouseY-10);
  }
if(dist(mouseX,mouseY,620,(-numArrests[9]/1000)+675)<10){
    fill(#EA0505);
    textSize(11);
    text(numArrests[9]+" arrests",mouseX-20,mouseY-10);
  }

}