String logoutImgPath= "/data/image/logim.png";
PImage logoutImage; 
float x = 446, y = 220;
Button yes, no;
void initlogeout() {
  logoutImage = loadImage(logoutImgPath);
  yes = new Button( "Yes", x + 88, y + 250, darkGreen, midGreen, green);
  no = new Button( "NO", x + 304, y + 250, darkred, midred, red);
}
void pagelogeoutDraw() {
  fill (#000721);
  noStroke ();
  rectMode(CORNER);
  rect (x, y, 500, 330, 9);
  imageMode (CORNER);
  image(logoutImage, 535, 254); 
  yes.draw();
  no.draw();
  textAlign(LEFT,TOP);
  textSize(22.17);
   text("Are you sure you want to logout?",520,397);
}
