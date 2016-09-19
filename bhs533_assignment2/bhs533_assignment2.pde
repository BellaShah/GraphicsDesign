//Name: Bella Shah
//Date: September 9, 2016

PImage img;
PImage display_img; 
float[][] gaussianMatrix = 
{{0.0071,   0.007427,  0.007691,  0.007886,  0.008005,  0.008045,  0.008005,  0.007886 , 0.007691,  0.007427,  0.0071},
{0.007427,  0.007768,  0.008045,  0.008248,  0.008373,  0.008415,  0.008373,  0.008248 , 0.008045 , 0.007768,  0.007427},
{0.007691,  0.008045,  0.008331,  0.008542,  0.008671,  0.008714,  0.008671,  0.008542 , 0.008331 , 0.008045,  0.007691},
{0.007886,  0.008248,  0.008542,  0.008758,  0.00889 , 0.008935 , 0.00889,  0.008758 , 0.008542 , 0.008248,  0.007886},
{0.008005,  0.008373,  0.008671,  0.00889,  0.009025 , 0.00907,  0.009025,  0.00889 , 0.008671,  0.008373,  0.008005},
{0.008045,  0.008415,  0.008714,  0.008935,  0.00907 , 0.009115,  0.00907 , 0.008935 , 0.008714,  0.008415,  0.008045},
{0.008005,  0.008373,  0.008671,  0.00889,   0.009025,  0.00907,  0.009025 , 0.00889 , 0.008671,  0.008373,  0.008005},
{0.007886,  0.008248,  0.008542,  0.008758,  0.00889 , 0.008935,  0.00889 , 0.008758 , 0.008542,  0.008248,  0.007886},
{0.007691,  0.008045,  0.008331,  0.008542,  0.008671,  0.008714,  0.008671,  0.008542 , 0.008331,  0.008045,  0.007691},
{0.007427,  0.007768,  0.008045,  0.008248,  0.008373,  0.008415, 0.008373 , 0.008248 , 0.008045,  0.007768,  0.007427},
{0.0071,    0.007427,  0.007691,  0.007886,  0.008005,  0.008045,  0.008005 , 0.007886,  0.007691,  0.007427,  0.0071}};

void setup(){
  surface.setResizable(true);
  img = loadImage("Austin.png");
  display_img = loadImage("Austin.png");
  surface.setSize(img.width, img.height);
}

void draw(){
  image(display_img, 0, 0);
  if (keyPressed== true && key=='0'){
    display_img.copy(img,0,0,img.width,img.height,0,0,img.width,img.height);
  }
  else if (keyPressed== true && key=='1'){
    grayscale(img,display_img);
  }
  else if (keyPressed== true && key=='2'){
    brighten(img,display_img);
  }
  else if (keyPressed== true && key=='3'){
    gaussianBlur(img,display_img);
  }
  else if (keyPressed== true && key=='4'){
    edgeDetectionColor(img, display_img);
  }
  else if (keyPressed== true && key=='5'){
    edgeDetection(img, display_img);
  }
  else if (keyPressed== true && key=='6'){
    blue_Rainbow(img, display_img);
    red_Rainbow(img, display_img);
    green_Rainbow(img,display_img);
  }
  }
  
void grayscale(PImage img, PImage display_img) {
  img.loadPixels();
  display_img.loadPixels();
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y <img.height; y++) {
      int index = x + y*img.width;
      float red = red(img.pixels[index]);
      float green = green(img.pixels[index]);
      float blue = blue(img.pixels[index]);
      //access pixel at index and its value to c
      float c = (red+green+blue)/3;
      display_img.pixels[index] = color(c, c, c, 255);
    }
   }
  display_img.updatePixels();
}

void brighten(PImage img, PImage display_img){
  display_img.loadPixels();
  img.loadPixels();
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      int threshold = 90;
      int index = x + y*img.width;
      float factor = (259*(threshold + 255)) / (255*(259-threshold));
      float red = red(img.pixels[index]);
      float green = green(img.pixels[index]);
      float blue = green(img.pixels[index]);
      red = (factor*(red-threshold) +threshold);
      green = (factor*(green-threshold) +threshold);
      blue = (factor*(blue-threshold) +threshold);
      red = constrain(red, 0, 255);
      green = constrain(green, 0, 255);
      blue = constrain(blue, 0, 255);
      display_img.pixels[index] = color(red, green, blue);
    }
  }
   display_img.updatePixels();
}

void gaussianBlur(PImage img, PImage display_img) {
  display_img.loadPixels();
  img.loadPixels();
  int matrixSize = 11;
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++ ) {
      color c = convolutionMatrix(x, y, gaussianMatrix, matrixSize, img);
      int index = x + y*img.width;
      display_img.pixels[index] = c;
    }
  }
  display_img.updatePixels();
  image(display_img, 0, 0);
}

color convolutionMatrix(int x, int y, float[][] matrix, int matrixSize, PImage img){
  float red = 0.0;
  float green = 0.0;
  float blue = 0.0;
  int offset = 1;
  for (int i = 0; i < matrixSize; i++){
    for (int j= 0; j < matrixSize; j++){
      // What pixel are we testing
      int xidx = x+i-offset;
      int yidx = y+j-offset;
      int index = xidx+ img.width*yidx;
      index = constrain(index,0,img.pixels.length-1);
      red += (red(img.pixels[index]) * matrix[i][j]);
      green += (green(img.pixels[index]) * matrix[i][j]);
      blue += (blue(img.pixels[index]) * matrix[i][j]);
    }
  }
  red = constrain(red, 0, 255);
  green = constrain(green, 0, 255);
  blue = constrain(blue, 0, 255);
  return color(red, green, blue);
}

void edgeDetection(PImage img, PImage display_img){
  float[][] sobel_x = {{-1,0,1},
           {-2,0,2},
           {-1,0,1}};

  float[][] sobel_y = {{-1,-2,-1},
           {0,0,0},
           {1,2,1}};
  display_img.loadPixels();
  img.loadPixels();
     
  for (int i = 1; i < img.height - 1; i++) {
    for (int j = 1; j < img.width - 1; j++) {
      float sum_x = 0;
      float sum_y = 0;
      
      for (int k = -1; k < 2; k++) {
        for (int l = -1; l < 2;l++) {
           int index = img.width * (i + k) + (j + l);
           float brightness = red(img.pixels[index]);
           sum_x += sobel_x[l+1][k+1] * brightness;
           sum_y += sobel_y[l+1][k+1] * brightness;
        }
      }

      float brightness = sqrt(sum_x*sum_x + sum_y*sum_y);
      display_img.pixels[i * img.width + j] = color(brightness, brightness, brightness);
    }
  }
  display_img.updatePixels();
}

void edgeDetectionColor(PImage img, PImage display_img){
  float[][] sobel_x = {{-1,0,1},
           {-2,0,2},
           {-1,0,1}};

  float[][] sobel_y = {{-1,-2,-1},
           {0,0,0},
           {1,2,1}};
  display_img.loadPixels();
  img.loadPixels();
     
  for (int i = 1; i < img.height - 1; i++) {
    for (int j = 1; j < img.width - 1; j++) {
      float sumred_x = 0;
      float sumred_y = 0;
      float sumgreen_x = 0;
      float sumgreen_y = 0;
      float sumblue_x = 0;
      float sumblue_y = 0;
      
      for (int k = -1; k < 2; k++) {
        for (int l = -1; l < 2;l++) {
           int index = img.width * (i + k) + (j + l);
           float brightness = red(img.pixels[index]);
           sumred_x += sobel_x[l+1][k+1] * brightness;
           sumred_y += sobel_y[l+1][k+1] * brightness;
           float brightness1 = green(img.pixels[index]);
           sumgreen_x += sobel_x[l+1][k+1] * brightness1;
           sumgreen_y += sobel_y[l+1][k+1] * brightness1;
           float brightness2 = blue(img.pixels[index]);
           sumblue_x += sobel_x[l+1][k+1] * brightness2;
           sumblue_y += sobel_y[l+1][k+1] * brightness2;
        }
      }
      float brightness = sqrt(sumred_x*sumred_x + sumred_y*sumred_y);
      float brightness1 = sqrt(sumgreen_x*sumgreen_x + sumgreen_y*sumgreen_y);
      float brightness2 = sqrt(sumblue_x*sumblue_x + sumblue_y*sumblue_y);
      display_img.pixels[i * img.width + j] = color(brightness, brightness1, brightness2);
    }
  }
  display_img.updatePixels();
}

//EXTRA CREDIT
void blue_Rainbow(PImage img, PImage display_img){
  display_img.loadPixels();
  img.loadPixels();
  for (int x = 0; x < img.width/3; x++) {
    for (int y = 0; y <img.height; y++) {
      int index = x + y*img.width/3;
      float b = random(0,255);
      float blue = blue(img.pixels[index])+b;
      blue = constrain(blue, 0, 255);
      display_img.pixels[index] = color(0,0, blue);
    }
  }
  display_img.updatePixels();
}

void red_Rainbow(PImage img, PImage display_img){
  display_img.loadPixels();
  img.loadPixels();
  for (int x = 0; x < img.width; x++) {
    for (int y = img.height/3; y <2*img.height/3; y++) {
      int index = x + y*img.width;
      float r = random(0,255);
      float red = red(img.pixels[index])+r;
      red = constrain(red, 0, 255);
      display_img.pixels[index] = color(red, 0, 0);
    }
  }
  display_img.updatePixels();
}

void green_Rainbow(PImage img, PImage display_img){
  display_img.loadPixels();
  img.loadPixels();
  for (int x = 0; x < img.width; x++) {
    for (int y = 2*img.height/3; y <img.height; y++) {
      int index = x + y*img.width;
      float g = random(0,255);
      float green = green(img.pixels[index])+g;
      green = constrain(green, 0, 255);
      display_img.pixels[index] = color(0, green, 0);
    }
  }
  display_img.updatePixels();
}