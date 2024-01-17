TextField CompName, CompID, Password;
Fonts fonts;
Button Login;
String cmexPath="/data/image/logim.png";
PImage cemx;
float w= 1366;
float h=768;
void initpagelogein() {
  fonts = new Fonts ();
  fullScreen();
  CompName = new TextField("Enter Company Name", 807, 263, 423, 60);
  CompName.allowedInputChars = CompName.LETTERS + " ";
  CompID = new TextField("Enter Company ID", 807, 347, 423, 60);
  CompID.allowedInputChars = CompID.LETTERS + CompID.NUMBERS;
  Password = new TextField("Password", 807, 431, 423, 60);
  Login = new Button("Login", 807, 527, darkOrange, midOrange, Orange);
  cemx = loadImage(cmexPath);
}
void logeinDraw() {
  background(#012348);
  imageMode(CORNER);
  image(cemx, 43, 254, 494, 207);
  noStroke();
  fill(#000721);
  rect(671, 0, 695, 768);
  fill(white);
  textAlign(CENTER);
  textFont(fonts.roboto.bold);
  textSize(33.25);
  text("Welcome Back !", 886 + 273/2, 173 +57/2);
  CompName.draw();
  CompID.draw();
  Password.draw();
  Login.draw();
}
void pagelogeinKeyPressed() {
  CompName.keyPressed();
  CompID.keyPressed();
  Password.keyPressed();
}
void pageLoginmousePressed() {
  CompName.mousePressed();
  CompID.mousePressed();
  Password.mousePressed();
  Login.mousePressed();
}
