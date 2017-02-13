int rpnum = 100;
int num_planets = 20;
RegenParticle[] regen = new RegenParticle[rpnum];
RegenParticle[] planets = new RegenParticle[num_planets];
float gravity = -0.3;
Atom atom;
int simulation_type = 3; //0 for bella, 1 for Ken, 2 for Kyle, 3 for none
int planet_type = 1; //1 for space, -1 for earth

void setup() {
  size(600, 600);
  if(simulation_type == 0){
  atom = new Atom(250,0,260,1,0.001,0.001);
  }
  if(simulation_type == 1){
    for (int i = 0; i < regen.length; i++) {
      float ox = 300;
      float oy = 500;
      float vx = random(-3, 3);
      float vy = random(0, 2);
      regen[i] = new RegenParticle(ox, oy, vx, vy, 4.0, ox, oy);
    }
  }
  if(simulation_type == 2){
    for (int i = 0; i < planets.length; i++) {
      float ox = random(20,580);
      float oy = random(20,580);
      planets[i] = new RegenParticle(ox, oy, random(-5,5), random(-5,5), random(5,40), ox, oy);
    }
  }
}

void mouseClicked() {
  if(simulation_type == 1){
    rpnum += 100;
    if (rpnum == 500) { rpnum = 100; }
    y = -45.0;
    x = 420;
    xx=0;
    vel = 0.1;
    regen = new RegenParticle[rpnum];
    setup();
    redraw();
  }
}

void draw() {
  background(#FFFFFF);
  if(simulation_type == 0){
    beakers();
  } else if(simulation_type == 1){
    bunsen();
  } else if(simulation_type == 2){
    background(0);
    stroke(255);
    planets();
  } else{
    textSize(24);
    fill(0);
    text("Press 0 for Pouring Simulation", 50, 100);
    text("Press 1 for Bunsen Burner Simulation", 50, 200);
    text("Press 2 for Planets Simulation", 50, 300); 
  }
}

void keyPressed(){
  if(key =='1'){
    simulation_type = 1;
    setup();
  } else if(key == '0'){
    simulation_type = 0;
    setup();
  } else if(key == '2'){
    simulation_type = 2;
    setup();
    frameRate(40);
  } else if(key == 'g'){
    planet_type *= -1;
  }
}

void planets(){
  for (int i = 0; i < planets.length; i++) {
    float x = (mouseX-planets[i].x);
    float y = (mouseY-planets[i].y);
    float force_y = 0;
    float force_x = 0;
    if(planet_type == 1){
      if(mousePressed){
      float theta = atan(y/x);
      if(planets[i].x < mouseX){
        theta = PI + theta;}
      float distance = dist(planets[i].x,planets[i].y,mouseX,mouseY);
      float force = 30*planets[i].r/distance;
      strokeWeight(floor(force)%50);
      line(planets[i].x, planets[i].y, planets[i].x - distance*cos(theta), planets[i].y - distance*sin(theta));
      strokeWeight(1);
      force_x += -force*cos(theta);
      force_y += -force*sin(theta);
      }
      for(int j = 0; j < planets.length; j++){
        if(i == j){
        } else {
          float x_2 = (planets[j].x-planets[i].x);
          float y_2 = (planets[j].y-planets[i].y);
          float distance_2 = dist(planets[i].x,planets[i].y,planets[j].x,planets[j].y);
          if(distance_2 < planets[i].r+planets[j].r){
              //planets[i].vx *= -0.8;
              //planets[i].vy *= -0.8;
          } else{
            float theta_2 = atan(y_2/x_2);
            if(planets[j].x < planets[i].x){
              theta_2 = PI + theta_2;}
            float force_2 = 5*planets[j].r/(distance_2);
            strokeWeight(floor(force_2));
            line(planets[i].x, planets[i].y, planets[i].x + distance_2*cos(theta_2), planets[i].y + distance_2*sin(theta_2));
            strokeWeight(1);
            force_x += force_2*cos(theta_2);
            force_y += force_2*sin(theta_2); 
            }
          }
       }
    } else if(planet_type == -1){
      force_y = 10;
    }
    planets[i].applyForces_Planets(force_x, force_y);
    planets[i].display();
    planets[i].keep();
  }
  
}

void beakers(){
  if(key=='0'){  
  background(#E6B4FF); 
  //BEAKERS
  noFill();
  stroke(0);
  strokeWeight(1);
  rect(425,170,100,54);
  fill(#F59125);
  stroke(#F59125);
  quad(550, 100, 550, 300, 500, 220, 500, 170);
  triangle(500, 171, 500, 222, 480, 223);
  ellipse(490,200,15,15);
  ellipse(500,180,15,15);
  ellipse(480,215,15,15);
  ellipse(470,216,15,15);
  ellipse(460,216,15,15);
  ellipse(450,216,15,15);
  ellipse(440,216,15,15);
  ellipse(475,215,15,15);
  stroke(0);
  strokeWeight(2);
  line(440,223,440,205);
  line(460,223,460,205);
  line(480,223,480,205);
  line(500,223,500,205);
  noFill();
  strokeWeight(1);
  rect(240,420,140,170,1);
  fill(#25AEF5);
  noStroke();
  rect(243,485,135,105);
  stroke(0);
  strokeWeight(2);
  line(240,490,260,490);
  line(240,460,260,460);
  line(240,520,260,520);
  line(240,550,260,550);
  line(240,580,260,580);
  strokeWeight(1);
      //FUNCTIONS
  atom.fallDown();
  atom.display();
  atom.applyForce();
  }
}

void bunsen(){
  Burner buns = new Burner(150, 250);
  buns.display();
  for (RegenParticle particle : regen) {
    particle.applyForces_Bunsen(0.0, gravity);
    particle.regen(random(-3, 3), random(-17, 1));
    particle.display();
  }
}