class Cards {
  Button cdetail;
  String label1;
  String label2;
   String label3;
  float x, y;
  float w=244.39, h=134.42;
  PImage image1;
  PImage image2;
  Cards(String label1, String label2,String label3, float x, float y, String imagepath,color pressed,color hovered,color normal,String pathimage2) {
    this.label1=label1;
    this.label2=label2;
    this.label3=label3;
    this.x=x;
    this.y=y;
    image1=loadImage(imagepath);
     image2=loadImage(pathimage2);
    cdetail=new Button("See Details",x+67,y+90,pressed,hovered,normal);
  }
  void draw() {
    noStroke();
    fill(#09223E);
    rect(x, y, w, h, 5);
    noStroke();
    imageMode(CORNER);
    image(image2,x-28, y-28.58);
    fill(255);
    textAlign(LEFT, TOP);
    textSize(18.429);
    text(label1, x+74, y+5.42);
    textSize(24.53);
    textAlign(CENTER);
    text(label2, x+58+131/2, y+64.42+28/2);
    textAlign(CENTER);
    fill(#1D9321);
    text(label3,x+122,y+50);
    cdetail.draw();
    imageMode (CENTER);
    image (image1, x - 10 + image1.width/2, y + image1.height/2);
  }
}
