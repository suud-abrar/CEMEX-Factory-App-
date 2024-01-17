class Tablepayed {
  String headers[];
  Rows header;
  Rows rows [];

  float x, y;
  float startY;
  float scrollHeight = 353;
  float scrollBrickHeight = 63;
  float scrollBrickY;
  Tablepayed (String headers [], float x, float y) {
    this.x = x;
    this.y = y;

    this.headers = headers;

    header = new Rows (headers);
    rows = new Rows [0];

    startY = y + header.h;
    scrollBrickY = y + header.h;
  }
  void addRow (String l2, String l3, String l4, String l5) {
   Rows row = new Rows (str (rows.length + 1), l2, l3, l4, l5);
    rows = (Rows []) append (rows, row);
  }

  void draw () {
    int x=0;
    for (int r = rows.length-1; r >= 0; r--) {
      rows [r].labels [0] = "" + (x + 1);
      rows [r].draw (startY + header.h*x);
      x++;
    }

    fill(#020F1D);
    noStroke ();
    rect(342, 0, 948, y+header.h);
    fill(255);
    header.draw (y);
    
    
     noStroke ();
    fill (lightGray);
    rect (1310, y + header.h, 15, scrollHeight, 7.5);

    fill (blue);
    rect (1310, scrollBrickY, 15, scrollBrickHeight, 7.5);
  }

  void mouseWheel (MouseEvent e) {
     if (rows.length > 6) {
      float count = e.getCount ();
      startY -= count;
      float minStartY = (header.h*- (rows.length-6))+ y + header.h;
      float maxStartY = y + header.h;
      startY = constrain (startY, minStartY, maxStartY);

      float minBrickY = y + header.h;
      float maxBrickY = y + header.h + scrollHeight - scrollBrickHeight;
      scrollBrickY = map (startY, minStartY, maxStartY, maxBrickY, minBrickY);
    }
  }
}
