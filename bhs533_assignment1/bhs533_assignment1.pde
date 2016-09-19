// Name: Bella Shah
// Date: September 2, 2016

void setup() {
       //Setup
       size(700,500);
       background(166,227,245); 
}
void draw(){
       //Sun
       stroke(250,13,5); 
       strokeWeight(2);
       line(630,25,630,2);
       line(630,115,630,138);
       line(585,70,562,70);
       line(675,70,698,70);
       stroke(250,116,5);
       line(660,40,680,20);
       line(600,40,580,20);
       line(660,100,680,120);
       line(600,100,580,120);
       noStroke();
       fill(245,250,10);
       ellipse(630,70,90,90); 
       
       //Ocean 
       noStroke();
       fill(10,104,250); 
       rect(0,350,700,700); 
       bezier(0,350,42.5,300,75,400,100,350);
       bezier(100,350,142.5,300,175,400,200,350);
       bezier(200,350,242.5,300,275,400,300,350);
       bezier(300,350,342.5,300,375,400,400,350);
       bezier(400,350,442.5,300,475,400,500,350);
       bezier(500,350,542.5,300,575,400,600,350);
       bezier(600,350,642.5,300,675,400,700,350);
       
       //Boat
       noStroke();
       fill(175,103,58); 
       arc(330,310,125,125,0,PI);
       stroke(0);
       strokeWeight(6);   
       line(330,308,330,225);
       strokeWeight(3); 
       stroke(255);
       fill(247,135,15);
       triangle(330,175,370,280,290,280); 
       
       //UT text
       textSize(35);
       fill(255,160);
       text("U",313,246);
       text("T",328,259);
       
       //Birds
       noFill();
       stroke(0);
       strokeWeight(2);
       beginShape();
       curveVertex(200,100);
       curveVertex(200,100);
       curveVertex(220,75);
       curveVertex(240,100);
       curveVertex(240,100);
       curveVertex(260,75);
       curveVertex(280,100);
       curveVertex(280,100);
       endShape();
       
       beginShape();
       curveVertex(500,250);
       curveVertex(500,250);
       curveVertex(515,225);
       curveVertex(535,250);
       curveVertex(535,250);
       curveVertex(555,225);
       curveVertex(575,250);
       curveVertex(575,250);
       endShape();
       
       beginShape();
       curveVertex(50,300);
       curveVertex(50,300);
       curveVertex(65,275);
       curveVertex(85,300);
       curveVertex(85,300);
       curveVertex(105,275);
       curveVertex(125,300);
       curveVertex(125,300);
       endShape();
} 