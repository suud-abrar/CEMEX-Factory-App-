class Cardd {
  Button cdetails;
  float x, y;
  float w = 200, h = 349;
  float headerH = 50;
  float radius = 5.51;

  String label1, label2, label3, label4, label5;

  PImage image;
  String imagepath;
  
  color headerColor;
  Cardd (String imagepath, String label1, String label2, String label3, String label4, String label5, color headerColor, float x, float y) {
    this.label1 = label1;
    this.label2 = label2;
    this.label3 = label3;
    this.label4 = label4;
    this.label5 = label5;
    this.imagepath=imagepath;
    image = loadImage (imagepath);

    this.x = x;
    this.y = y;
    this.headerColor = headerColor;
      
    cdetails=new Button("See Details",x+45,y+300,Bblue3,Bblue2,Bblue);
  }

  void draw () {
    rectMode (CORNER);
    // Container rectangle
    noStroke ();
    fill (darkBlue);
    rect (x, y, w, h, radius);

    // Header rectangle
    fill (headerColor);
    rect (x, y, w, headerH, radius, radius, 0, 0);

    fill (255);
    textAlign (LEFT, CENTER);
    textSize (16.23);
    text (label1, x + 24.26, y + headerH/2);
    textAlign(CORNER);
    text(label2, x+111.9, y+ 239); 
    text(label3, x+111.9, y+ 241+13);
    text(label4, x+111.9, y+ 258.19+27/2 );
    text(label5, x+111.9, y+ 276+27/2);
    imageMode (CENTER);
    image (image, x + 45.76 + image.width/2, y + 59 +image.height/2);

    //
    textAlign(CENTER);
    text("Available: ", x + 66, y+ 239);
    text("Price: ", x + 59+21, y+ 241+13);
    text("Ordered: ", x + 34+71/2, y+ 258.19+27/2);
    text("Type: ", x + 59+45/2, y+ 276+27/2);
 cdetails.draw();
  }
}
