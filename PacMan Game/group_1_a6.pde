Pacman pac;
int rpnum = 200;
Fruits fruit;
RegenParticle[] regen = new RegenParticle[rpnum];
Ghost[] Ghosts = new Ghost[4];
int phase = 0;
boolean superPellet = false;
boolean gameOver = false;
boolean winner = false;
int score = 0;
int lives = 3;
int fruited = 0;
int vulnerable_timer = 300;
int pac_v = 5;
int numberPellets = 0;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
 
Minim minim;
AudioPlayer song;

Ghost r_g;
Ghost b_g;
Ghost p_g;
Ghost o_g;

/*
0 = wall
1 = pellet
2 = empty
3 = ghost spawn
4 = superpellet
5 = fruit spawn
Screen will be divided into 19 squares (20x20 px) 
*/

Pellet[][] Pellets = new Pellet[20][20];
int[][] map = {{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0},
    {0,4,0,0,1,0,0,0,1,0,1,0,0,0,1,0,0,4,0},
    {0,1,0,0,1,0,0,0,1,0,1,0,0,0,1,0,0,1,0},
    {0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0},
    {0,1,0,0,1,0,1,0,0,0,0,0,1,0,1,0,0,1,0},
    {0,1,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,1,0},
    {0,0,0,0,1,0,0,0,2,0,2,0,0,0,1,0,0,0,0},
    {0,0,0,0,1,0,0,3,2,0,2,3,0,0,1,0,0,0,0},
    {2,2,2,2,1,2,2,2,3,2,3,2,2,2,1,2,2,2,2},
    {0,0,0,0,1,0,2,0,0,0,0,0,2,0,1,0,0,0,0},
    {0,1,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,1,0},
    {0,1,0,0,1,0,0,0,1,0,1,0,0,0,1,0,0,1,0},
    {0,4,1,0,1,1,1,1,1,5,1,1,1,1,1,0,1,4,0},
    {0,0,1,0,1,0,1,0,0,0,0,0,1,0,1,0,1,0,0},
    {0,1,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,1,0},
    {0,1,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,1,0},
    {0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}};
    
int[][] map_original = map;
    
void setup() {
  size(760,800);
  frameRate(30);
  minim = new Minim(this);
  // this loads mysong.wav from the data folder
  song = minim.loadFile("PacMan.mp3");
  song.play();
  song.loop();
  for (int i = 0; i < regen.length; i++) {
    float ox = 380;
    float oy = 450;
    float vx = random(-3, 3);
    float vy = random(-3, 3);
    regen[i] = new RegenParticle(ox, oy, vx, vy, 5.0, ox, oy);
    pac = new Pacman(ox-30,oy,0,0);
  }
}

/* phase keeps track of state of the game
0 - title
1 - initial game state
*/

void draw() {
  if(phase == 0) {
    titleScreen();
    if(key == ' ') {
      lives = 3;
      score = 0;
      phase = 1;
      map = map_original;
    }
  }
  if(phase == 1) {
    generateStage();
    if(keyCode == RIGHT || keyCode == LEFT || keyCode == UP || keyCode == DOWN) {
      phase = 2;
    }
  }
  if (phase == 2) {
    updateGame();
  }  
}

// displays title screen and its animations

void titleScreen() {
  background(#191970);
  fill(#FFEE00);
  textAlign(CENTER);
  textSize(48);
  text("PAC-MAN:", width*0.50, height*0.40);
  textSize(32);
  if(winner){
    text("Congrats! You won! Score: " + score, width*0.50, height*0.40+50);  
  } else if(gameOver){
    text("You lost! Press SPACE to try again", width*0.50, height*0.40+50);  
  } else {
    text("A High Score and Beyond", width*0.50, height*0.40+50);
    textSize(20);
    text("Press the SPACE bar to start game", width*0.50, height*0.80);
    pac.display();
  }
  noFill();
  for (RegenParticle particle : regen) {
    particle.applyForces(0.0, 0);
    particle.regen(random(-380, 380), random(-20, 20));
    particle.display();
  }
}

void generateStage() {
  background(#191970);
  // displays walls and pellets
  int[] ghostSpawn_x = new int[4];
  int[] ghostSpawn_y = new int[4];
  int i = 0;
  background(#191970);
  // displays Player HUD
  fill(#FFEE00);
  textAlign(LEFT);
  textSize(20);
  text("Score:" + str(score), 10, 790);
  if (lives <= 5) {
    for (int numL = 0; numL < lives; numL++) {
      arc(width - numL*40 - 20, 780, 30, 30, QUARTER_PI, 2*PI-QUARTER_PI, PIE);
    }
  }
  else {
    arc(700, 780, 30, 30, QUARTER_PI, 2*PI-QUARTER_PI, PIE);
    text("x" + str(lives), 715, 790);
  }
  // displays walls and pellets
  for(int y = 0; y < map.length; y++){
    for(int x = 0; x < map[y].length; x++){
      if(map[y][x] == 0){
        //change to appropriate color
        fill(#0000CD);
        rect(x*40,y*40,40,40);
      } else if(map[y][x] == 1){
        fill(#FFEE00);
        ellipse(float(x*40+20), float(y*40+20), 14, 14);
        numberPellets++;
      } else if(map[y][x] == 4){
        fill(#FFEE00);
        ellipse(float(x*40+20), float(y*40+20), 28, 28);
      } else if(map[y][x] == 3){
        ghostSpawn_x[i] = y;
        ghostSpawn_y[i] = x;
        i++;
      }
    }
  }
  // displays ghosts
  o_g = new Ghost("orange",ghostSpawn_y[0]*40,ghostSpawn_x[0]*40,40,40,0,0.0011,2,200,true,int(random(3)+1),5);
  r_g = new Ghost("red",ghostSpawn_y[1]*40,ghostSpawn_x[1]*40,40,40,0,0.001,2,175,true,int(random(3)+1),5);
  p_g = new Ghost("pink",ghostSpawn_y[2]*40,ghostSpawn_x[2]*40,40,40,0,0.0012,2,370,true,int(random(3)+1),5);
  b_g = new Ghost("blue",ghostSpawn_y[3]*40,ghostSpawn_x[3]*40,40,40,0,0.001,2,200,true,int(random(3)+1),5);
  Ghosts[0] = o_g;
  Ghosts[1] = r_g;
  Ghosts[2] = p_g;
  Ghosts[3] = b_g;
  fruit = new Fruits(int(random(4)),9*40,13*40,40,40,false);
  pac = new Pacman(380, 540, pac_v, 0);
}

void updateGame() {
  background(0);
  // displays Player HUD
  fill(#FFEE00);
  textAlign(LEFT);
  textSize(20);
  text("Score:" + str(score), 10, 790);
  numberPellets = 0;
  if (lives <= 5) {
    for (int numL = 0; numL < lives; numL++) {
      arc(width - numL*40 - 20, 780, 30, 30, QUARTER_PI, 2*PI-QUARTER_PI, PIE);
    }
  }
  else {
    arc(700, 780, 30, 30, QUARTER_PI, 2*PI-QUARTER_PI, PIE);
    text("x" + str(lives), 715, 790);
  }
  // displays walls and pellets
  for(int y = 0; y < map.length; y++){
    for(int x = 0; x < map[y].length; x++){
      if(map[y][x] == 0){
        //change to appropriate color
        fill(#0000CD);
        rect(x*40,y*40,40,40);
      } else if(map[y][x] == 1){
        fill(#FFEE00);
        ellipse(float(x*40+20), float(y*40+20), 14, 14);
        numberPellets++;
      } else if(map[y][x] == 4){
        fill(#FFEE00);
        if(second() % 2 == 0){
          ellipse(float(x*40+20), float(y*40+20), 28, 28);
        }
      }
    }
  }
  if(pac.y == 380){
    if(pac.x == 60){
      pac.x = width-60;
    } else if(pac.x == width-60){
      pac.x = 60;  
    }
  }
  // check if pac is colliding
  if(pac.x % 40 == 20 && pac.y % 40 == 20){ 
    if(checkCollision(pac.x,pac.y,pac.direction) == true){
      pac.v = 0; 
    }
  }
  if(numberPellets % 25 == 0 && fruit.show == false){
    fruit.type = (fruit.type+1)%4;
    fruit.show = true;  
  }
  fruit.displayFruit();
  //map locations of pac
  int pxl_X = int((pac.x-20)/40);
  int pxl_Y = int((pac.y-20)/40);
  //check for user input
  checkInput();
  if(map[pxl_Y][pxl_X] == 1){
    score += 100;
    map[pxl_Y][pxl_X] = 2;
  } 
  if(map[pxl_Y][pxl_X] == 4){
    superPellet = true;
    for(int i = 0; i < Ghosts.length; i++){
      Ghosts[i].show = false;
    }
    map[pxl_Y][pxl_X] = 2;
  }
  if(map[pxl_Y][pxl_X] == 5 && fruit.show == true){
    fruit.show = false;
    score += 500;
    fruited = 30;
  }
  pac.display();
  if(fruited > 0){
    fill(155);
    text("+500",pac.x-20,pac.y-20);
    fruited -= 1;
  }
  for(int j = 0; j < Ghosts.length; j++){
    //check for teleportation
    //println("Ghost: " + j + " x: " + Ghosts[j].x + " y: " + Ghosts[j].y);
    if(Ghosts[j].y == 360){
      if(Ghosts[j].x < 45){
        Ghosts[j].x = width - 45;
      } else if(Ghosts[j].x > width - 45){
        Ghosts[j].x = 45;  
      }
    }
    //check for collisions
    if(Ghosts[j].x % 40 == 0 && Ghosts[j].y % 40 == 0){
      int[] directions = {0,0,0,0};
      int num = 0;
      for(int i = 0; i < 4; i++){
        if(checkCollision(Ghosts[j].x+20, Ghosts[j].y+20,i+1) == false){
          directions[i] = 1;
          num++;
        }
      }
      //println(directions[0],directions[1],directions[2],directions[3]);
      if(num > 2){
        int rando = int(random(100))%3;
        int prev_direction = 0;
        prev_direction = Ghosts[j].direction;
        while(rando == 0 || directions[Ghosts[j].direction-1] == 0){
          Ghosts[j].direction += 1;
          if(Ghosts[j].direction > 4){
            Ghosts[j].direction = Ghosts[j].direction%4;
          }
          if((directions[Ghosts[j].direction-1] == 1) && (Ghosts[j].direction != prev_direction)){
            break;
          }
        }
      } else if(num == 2 && (directions[0] != directions[2] || directions[1] != directions[3])){
        //2 paths at a right angle
        Ghosts[j].direction += 1;
        if(Ghosts[j].direction > 4){
          Ghosts[j].direction = Ghosts[j].direction%4;
        }
        if(checkCollision(Ghosts[j].x+20, Ghosts[j].y+20,Ghosts[j].direction)){
          Ghosts[j].direction += 2;
        }
        if(Ghosts[j].direction > 4){
          Ghosts[j].direction = Ghosts[j].direction%4;
        } 
      } else if(checkCollision(Ghosts[j].x+20, Ghosts[j].y+20,Ghosts[j].direction)){
        for(int i = 0; i < 4; i++){
          if(directions[i] == 1){
            Ghosts[j].direction = i+1;  
          }
        }
      }
    //display and move
    }
    Ghosts[j].chase();
    if((pac.x > Ghosts[j].x && pac.x < Ghosts[j].x + 40) && (pac.y > Ghosts[j].y && pac.y < Ghosts[j].y + 40)){
      if(superPellet == false){
        lives -= 1;
        generateStage();
        if(lives == 0){
          gameOver = true;
          phase = 0;  
        }
      } else {
        score += 500;
        fruited = 60;
        Ghosts[j].x = 240;
        Ghosts[j].y = 360;
        Ghosts[j].show = true;
      }
    }    
  } 
  if(superPellet==true){
    vulnerable_timer -= 1;
    if(vulnerable_timer == 0){
      superPellet = false;  
      for(int i = 0; i < 4; i++){
        Ghosts[i].show = true;  
        vulnerable_timer = 300;
      }
    }
  }
  if(numberPellets == 0){
    winner = true;
    phase = 0;
  }
}

boolean checkCollision(float x, float y, int direction){
  int pxl_X = int((x-20)/40);
  int pxl_Y = int((y-20)/40);
  if(direction == 1){
    if(map[pxl_Y][pxl_X+1] == 0){
      return true;
    }  
  }
  if(direction == 2){
    if(map[pxl_Y-1][pxl_X] == 0){
      return true;  
    }  
  }
  if(direction == 3){
    if(map[pxl_Y][pxl_X-1] == 0){
      return true;  
    }  
  }
  if(direction == 4){
    if(map[pxl_Y+1][pxl_X] == 0){
      return true;  
    }  
  }
  return false;
}

void checkInput(){
  int pxl_X = int((pac.x-20)/40);
  int pxl_Y = int((pac.y-20)/40);
  if(pac.x % 20 == 0 && pac.y % 20 == 0 && pac.x % 40 != 0 && pac.y % 40 != 0){
    if(keyCode == UP) {
      if(map[pxl_Y-1][pxl_X] == 0){
      //pac can't move that way
      } else{
        pac.v = pac_v;
        pac.direction = 2;
      }
    }
    if(keyCode == DOWN) {
      if(map[pxl_Y+1][pxl_X] == 0){
      //pac can't move that way    
      } else{
        pac.v = pac_v;
        pac.direction = 4;
      }
    }
    if(keyCode == LEFT) {
      if(map[pxl_Y][pxl_X-1] == 0){
      //pac can't move that way    
      } else{
        pac.v = pac_v;
        pac.direction = 3;
      }
    }
    if(keyCode == RIGHT) {
      if(map[pxl_Y][pxl_X+1] == 0){
      //pac can't move that way    
      } else{
        pac.v = pac_v;
        pac.direction = 1;
      }
    } 
  }
}