class Ordercard {
  String label1;
  float x, y;
  float w=244.39, h=134.42;
  PImage imageicon;
  PImage imagegreenblue;
  Ordercard(String label1, float x, float y, String imPath, String imagePath) {
    this.label1=label1;
    this.x=x;
    this.y=y;
    imageicon = loadImage (imPath);
    imagegreenblue = loadImage (imagePath);
  }
  void draw() {
    rectMode (CORNER);
    noStroke();
    fill(#09223E);
    rect(x, y, w, h, 5);
    imageMode(CORNER);
    image(imagegreenblue, x-28, y-28.58);
    fill(255); 
    textSize(26.4);
    textAlign(LEFT, TOP);
    textSize(24);
    text("Total orders", x+ 74, y+5.42);
    text(label1, x+96, y+25.42);
    textAlign(LEFT, TOP);
    text("PPC :", x+74, y+51.42);
    text("OPC :", x+74, y+75.42);
    text("Count :", x+58, y+99.42);
    imageMode(CORNER);
    image (imageicon, x -11.42, y - 5.42);
    waitingAmount();
    pendingAmount();
  }
  void waitingAmount() {
    int waitingAmountPPC=0;
    int waitingAmountOPC=0;
    int count=0;
    for (int i=0; i < tableOrder.getRowCount(); i++) {
      if (tableOrder.getString(i, "state").equals("Waiting") && tableOrder.getString(i, "type").equals("ppc")) {
        waitingAmountPPC+=int(tableOrder.getString(i, "amount"));
      } else if (tableOrder.getString(i, "state").equals("Waiting") && tableOrder.getString(i, "type").equals("opc")) {
        waitingAmountOPC+=int(tableOrder.getString(i, "amount"));
      }
      if (tableOrder.getString(i, "state").equals("Waiting")) {
        count++;
      }
    }
    textAlign(LEFT, TOP);
    text(str(waitingAmountPPC)+" (q)", 663, 662);
    text(str(waitingAmountOPC)+" (q)", 663, 686);
    text(str(count), 663, 710);
  }
  void pendingAmount() {
    int pendingAmountPPC=0;
    int pendingAmountOPC=0;
    int count=0;
    for (int i=0; i < tableOrder.getRowCount(); i++) {
      if (tableOrder.getString(i, "state").equals("pending") && tableOrder.getString(i, "type").equals("ppc")) {
        pendingAmountPPC+=int(tableOrder.getString(i, "amount"));
      } else if (tableOrder.getString(i, "state").equals("pending") && tableOrder.getString(i, "type").equals("opc")) {
        pendingAmountOPC+=int(tableOrder.getString(i, "amount"));
      } 
      if (tableOrder.getString(i, "state").equals("pending")) {

        count++;
      }
    }
    textAlign(LEFT, TOP);
    text(str(pendingAmountPPC)+" (q)", 996, 662);
    text(str(pendingAmountOPC)+" (q)", 996, 686);
    text(str(count), 996, 710);
  }
}
