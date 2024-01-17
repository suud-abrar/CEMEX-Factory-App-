class NavButton {
  float x, y;
  float w = 246, h = 48;
  float radius = 4;
  float shapeToLabelGapX = 21.26;

  String label;

  PShape shape;

  color activeFill = #162560;

  boolean active = false;
  boolean activeable = true;

  NavButton (String label, PShape shape, float x, float y) {
    this.label = label;

    shape.disableStyle();
    this.shape = shape;

    this.x = x;
    this.y = y;
  }

  void draw () {
    // Container
    if (hovered ()) {
      if (mousePressed) {
        fill (activeFill, 255 * 0.8);
      } else {
        fill (activeFill, 255 * 0.4);
      }
    } else {
      noFill ();
    }
    if (active) {
      fill (activeFill);
    }

    noStroke ();
    rectMode (CORNER);
    rect (x, y, w, h, radius, 0, 0, radius);

    // Shape
    shapeMode (CORNER);
    fill (white);
    shape (shape, x + 24.3, y + h/2 - shape.height/2);
    
    // Text
    fill (white);
    textAlign (LEFT, CENTER);
    textSize (22);
    text (label, x + 72.89, y + h/2 - textDescent ()/2);
  }

  boolean hovered () {
    return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
  }
}

class Button {
  float x, y;
  float w = 113, h = 36;
  float radius = 5.25;
  String label;
  color dark, mid, normal;

  Button (String label, float x, float y, color dark, color mid, color normal) {
    this.label = label;
    this.x = x;
    this.y = y;
    this.dark=dark;
    this.mid=mid;
    this.normal=normal;
  }

  Button (String label, color dark, color mid, color normal) {
    this.label = label;
    this.dark=dark;
    this.mid=mid;
    this.normal=normal;
  }

  void draw (float x, float y) {
    this.x = x;
    this.y = y;
    draw ();
  }

  void draw () {
    rectMode (CORNER);

    if (hovered ()) {
      if (mousePressed) {
        fill (dark);
      } else {
        fill (mid);
      }
    } else {
      fill (normal);
    }
    noStroke ();
    rect (x, y, w, h, radius);
    fill (255);
    textSize (15.38);
    textAlign (CENTER, CENTER);
    text (label, x + w/2, y + h/2 - textDescent ()/2);
  }

  boolean hovered () {
    return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
  }

  void mousePressed () {
  }

  void keyPressed() {
  }
}
