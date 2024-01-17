class Card {
  TextField amount;
  TextField price;

  Button save;
  Button Discard;

  float x, y;
  float w = 446, h = 251;
  float headerH = 51;
  float radius = 5.51;

  String label1, label2;

  PImage image;

  color headerColor;

  Card (String label1, String label2, String imagePath, color headerColor, float x, float y) {
    this.label1 = label1;
    this.label2 = label2;

    image = loadImage (imagePath);

    this.x = x;
    this.y = y;

    this.headerColor = headerColor;

    amount = new TextField ("Amount", x + 179, y + 90, 115, 55);
    price=new TextField("price", x+311, y+90, 115, 55);
    save = new Button ("Save", x + 181, y + h - 28 - 36,darkGreen,midGreen,green);
    Discard= new Button  ("Discard",x+311, y + h - 28 - 36,darkred,midred,red);
    
  }

  void draw () {
    rectMode (CORNER);

    // Container rectangle
    noStroke ();
    fill (blueLight);
    rect (x, y, w, h, radius);

    // Header rectangle
    fill (headerColor);
    rect (x, y, w, headerH, radius, radius, 0, 0);

    fill (255);
    textAlign (LEFT, CENTER);
    textSize (16.23);
    text (label1, x + 24.26, y + headerH/2);

    textAlign (RIGHT, CENTER);
    text (label2, x + w - 24.26, y + headerH/2);

    imageMode (CENTER);
    image (image, x + 24.26 + image.width/2, y + headerH + (h - headerH)/2);

    // Text Fields
    amount.draw ();
    price.draw();
    // Buttons
    save.draw ();
    Discard.draw();
  }

  void mousePressed () {
    amount.mousePressed();
    price.mousePressed();
    save.mousePressed();
   Discard.mousePressed();
  }

  void keyPressed () {
    amount.keyPressed();
    price.keyPressed();
  }
}
