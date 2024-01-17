class Rows {
  String labels [];

  float Xs [] = {345, 450, 641, 820, 1050}, y=117;
  float Ws [] = {96, 208, 180, 180, 230}, h=58;
  Button button;

  int type = 1;
  Rows (String labels []) {
    this.labels = labels;

    type = 1;
  }

  Rows (String label1, String label2, String label3, String label4, String label5) {
    labels = new String [] {label1, label2, label3, label4, label5};
  }

  Rows (String labels [], Button button) {
    this.button=button;
    this.labels=labels;
    type = 2;
  }

  public void draw (float y) {
    if (type == 1) {
      for (int i=0; i < 5; i++) {
        fill (255);
        textAlign (CENTER, CENTER);
        text(labels [i], Xs [i] + Ws [i]/2, y + h/2);

        strokeWeight (1);
        stroke (255);
        line (Xs [0], y, Xs [4] + Ws[4], y);
        line (Xs [0], y + h, Xs [4] + Ws[4], y + h);
      }
    } else {

      for (int i=0; i < 4; i++) {
        fill (255);
        textAlign (CENTER, CENTER);
        text(labels [i], Xs [i] + Ws [i]/2, y + h/2);

        strokeWeight (1);
        stroke (255);
        line (Xs [0], y, Xs [4] + Ws[4], y);
        line (Xs [0], y + h, Xs [4] + Ws[4], y + h);
      }

      button.draw (Xs [4] + Ws[4]/2 - button.w/2, y + h/2 - button.h/2);
    }
  }

  boolean buttonHovered () {
    if (button == null)
      return false;
    return button.hovered ();
  }
}
