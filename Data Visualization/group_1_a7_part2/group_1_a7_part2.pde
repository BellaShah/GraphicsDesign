Table theTable;
int[] numArrests = new int[10];
int[] years = {2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015};

int[] child = new int[10];
int[] adolescent = new int[10];
int[] teen = new int[10];
int[] youngadult = new int[10];
int[] adult = new int[10];
int[] senior = new int[10];

int[] male = new int[10];
int[] female = new int[10];

int[] black = new int[10];
int[] hispanic = new int[10];
int[] other = new int[10];
int[] white = new int[10];

void organize_data(){
  theTable = loadTable("arrest_data_2006-2015.csv", "header");
  for (int i = 0; i < years.length; i++) {
    for (TableRow row : theTable.rows()) {
      if(row.getInt("YEAR") == years[i]) {
        numArrests[i] += row.getInt("F_TOTAL");
      }
    }
    for (TableRow row : theTable.findRows("Male", "GENDER")) {
      if(row.getInt("YEAR") == years[i]) {
        male[i] += row.getInt("F_TOTAL");
      }
    }
    for (TableRow row : theTable.findRows("Female", "GENDER")) {
      if(row.getInt("YEAR") == years[i]) {
        female[i] += row.getInt("F_TOTAL");
      }
    }
    for (TableRow row : theTable.findRows("Black", "RACE")) {
      if(row.getInt("YEAR") == years[i]) {
        black[i] += row.getInt("F_TOTAL");
      }
    }
    for (TableRow row : theTable.findRows("Hispanic", "RACE")) {
      if(row.getInt("YEAR") == years[i]) {
        hispanic[i] += row.getInt("F_TOTAL");
      }
    }
    for (TableRow row : theTable.findRows("White", "RACE")) {
      if(row.getInt("YEAR") == years[i]) {
        white[i] += row.getInt("F_TOTAL");
      }
    }
    for (TableRow row : theTable.findRows("Other", "RACE")) {
      if(row.getInt("YEAR") == years[i]) {
        other[i] += row.getInt("F_TOTAL");
      }
    }
    for (TableRow row : theTable.findRows("Under 10", "AGE_GROUP")) {
      if(row.getInt("YEAR") == years[i]) {
        child[i] += row.getInt("F_TOTAL");
      }
    }
    for (TableRow row : theTable.findRows("10 to 17", "AGE_GROUP")) {
      if(row.getInt("YEAR") == years[i]) {
        adolescent[i] += row.getInt("F_TOTAL");
      }
    }
    for (TableRow row : theTable.findRows("18 to 19", "AGE_GROUP")) {
      if(row.getInt("YEAR") == years[i]) {
        teen[i] += row.getInt("F_TOTAL");
      }
    }
    for (TableRow row : theTable.findRows("20 to 29", "AGE_GROUP")) {
      if(row.getInt("YEAR") == years[i]) {
        youngadult[i] += row.getInt("F_TOTAL");
      }
    }
    for (TableRow row : theTable.findRows("30 to 39", "AGE_GROUP")) {
      if(row.getInt("YEAR") == years[i]) {
        adult[i] += row.getInt("F_TOTAL");
      }
    }
    for (TableRow row : theTable.findRows("40 to 69", "AGE_GROUP")) {
      if(row.getInt("YEAR") == years[i]) {
        senior[i] += row.getInt("F_TOTAL");
      }
    }
  }
}

void part2_Graph() {
  textAlign(LEFT);
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
  textSize(20);
  text("Total Number of Annual Arrests in Los Angeles", 170, 60);
  textSize(12);
  textAlign(CENTER, CENTER);
  text("0",80,500);
  text("100",80,450);
  text("200",80,400);
  text("300",80,350);
  text("400",80,300);
  text("500",80,250);
  text("600",80,200);
  text("700",80,150); 
  text("800",80,100); 
}

void normPlot() {
  int position = 160;
  int height = 0;
  for(int i = 0; i< years.length; i++) {
    height = floor (numArrests[i]/2000);
    fill(#198E98);
    rect(position, 500 - height, 20, height);
    position += 50;
  }
}

void genderPlot() {
  int position = 160;
  int m_height = 0;
  int f_height = 0;
  for(int i = 0; i< male.length; i++) {
    m_height = floor(male[i]/2000);
    f_height = floor(female[i]/2000);
    fill(#FFB624);
    rect(position, 500 - m_height, 20, m_height);
    fill(#24FFFD);
    rect(position, 500 - m_height - f_height, 20, f_height);
    position += 50;
  }
  fill(#D6D6D6);
  rect(500, 125, 200, 70);
  fill(#171717);
  text("Legend", 530, 140);
  text("Male", 570, 175);
  text("Female", 660, 175);
  fill(#FFB624);
  rect(530, 170, 10, 10);
  fill(#24FFFD);
  rect(610, 170, 10, 10);
} 

void racePlot() {
  int position = 160;
  int whi_height = 0;
  int bla_height = 0;
  int his_height = 0;
  int oth_height = 0;
  for(int i = 0; i< male.length; i++) {
    whi_height = floor(white[i]/2000);
    bla_height = floor(black[i]/2000);
    his_height = floor(hispanic[i]/2000);
    oth_height = floor(other[i]/2000);
    fill(#FFFCF7);
    rect(position, 500 - whi_height, 20, whi_height);
    fill(#121211);
    rect(position, 500 - whi_height - bla_height, 20, bla_height);
    fill(#31FF3C);
    rect(position, 500 - whi_height - bla_height - his_height, 20, his_height);
    fill(#FF31F5);
    rect(position, 500 - whi_height - bla_height - his_height - oth_height, 20, oth_height);
    position += 50;
  }
  fill(#D6D6D6);
  rect(500, 125, 200, 100);
  fill(#171717);
  text("Legend", 530, 140);
  text("White", 570, 175);
  text("Black", 660, 175);
  text("Hispanic", 570, 205);
  text("Other", 660, 205);
  fill(#FFFCF7);
  rect(525, 170, 10, 10);
  fill(#121211);
  rect(625, 170, 10, 10);
  fill(#31FF3C);
  rect(525, 200, 10, 10);
  fill(#FF31F5);
  rect(625, 200, 10, 10);
} 

void agePlot() {
  int position = 160;
  int young_height = 0;
  int teen_height = 0;
  int yadult_height = 0;
  int adult_height = 0;
  int old_height = 0;
  for(int i = 0; i< male.length; i++) {
    young_height = floor((child[i]+adolescent[i])/2000);
    teen_height = floor(teen[i]/2000);
    yadult_height = floor(youngadult[i]/2000);
    adult_height = floor(adult[i]/2000);
    old_height = floor(senior[i]/2000);
    fill(#FCFFB9);
    rect(position, 500 - young_height, 20, young_height);
    fill(#E1E57D);
    rect(position, 500 - teen_height - young_height, 20, teen_height);
    fill(#D0D636);
    rect(position, 500 - yadult_height - teen_height - young_height, 20, yadult_height);
    fill(#ACB212);
    rect(position, 500 - adult_height - yadult_height - teen_height - young_height, 20, adult_height);
    fill(#848904);
    rect(position, 500 - old_height - adult_height - yadult_height - teen_height - young_height, 20, old_height);
    position += 50;
  }
  fill(#D6D6D6);
  rect(500, 125, 200, 120);
  fill(#171717);
  text("Legend", 530, 140);
  text("Age < 18", 560, 165);
  text("18 to 19", 660, 165);
  text("20 to 29", 560, 195);
  text("30 to 39", 660, 195);
  text("40 to 69", 560, 225);
  fill(#FCFFB9);
  rect(515, 160, 10, 10);
  fill(#E1E57D);
  rect(615, 160, 10, 10);
  fill(#D0D636);
  rect(515, 190, 10, 10);
  fill(#ACB212);
  rect(615, 190, 10, 10);
  fill(#848904);
  rect(515, 220, 10, 10);
} 

void setup(){
  size(800, 600);
  organize_data();
  part2_Graph();
  normPlot();
}

void draw(){
  background(#C6C2C2);
  part2_Graph();
  normPlot();
  if(keyPressed == true)
  {
    if(key == '1'){
      background(#C6C2C2);
      part2_Graph();
      genderPlot();      
    }
    else if(key == '2') {
      background(#C6C2C2);
      part2_Graph();
      racePlot();
    }
    else if(key == '3') {
      background(#C6C2C2);
      part2_Graph();
      agePlot();
    }
  }
  
}