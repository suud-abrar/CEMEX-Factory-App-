class Payedcard {
  String label1;
  String label2;
  float x, y;
  float w=244.39, h=134.42;
  color col;
  PImage imageicon;
   PImage imagegra;
  Payedcard(String label1, String label2, float x, float y, color col, String imPath,String pathgra) {
    this.label1=label1;
    this.label2=label2;
    this.x=x;
    this.y=y;
    this.col=col;
    imageicon = loadImage (imPath);
     imagegra = loadImage (pathgra);
  }
  void draw() {
    rectMode (CORNER);
    noStroke();
    fill(#09223E);
    rect(x, y, w, h, 5);
    fill(col);
    image(imagegra,x-28, y-28.58);
    rect(x+77, y+70.28, 138, 26.42, 7.37);
    fill(255); 
    textSize(26.4);
    textAlign(LEFT, TOP);
    textSize(24);
    text("Total Payments", x+ 60, y+5.42);
    text(label1, x+96, y+30);
    textAlign(LEFT, TOP);
    fill(#E49C13);
    text("ETB", x+118, y+103.42);
    fill(255);
    textAlign(CENTER);
    text(label2, x+144  , y+92);
    imageMode(CORNER);
    image (imageicon, x -11.42, y - 5.42);
  }
}
