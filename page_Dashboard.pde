Cardd card1, card2, card3, card4;
Cards carda, cardb;

String pathppc="C:/Users/Win 10 Pro/Documents/Processing/amount ppc.csv";
String pathopc="C:/Users/Win 10 Pro/Documents/Processing/amount opc.csv";
String pathprice="C:/Users/Win 10 Pro/Documents/Processing/factorydata.csv";;
String pathorder="C:/Users/Win 10 Pro/Documents/Processing/orders/DANGOTE.csv";

void  initpageDashboard() {
  Table tableppc=loadTable(pathppc, "header");
  Table tableopc=loadTable(pathopc, "header");
  Table tableprice=loadTable(pathprice, "header");
  Table tableorder=loadTable(pathorder, "header");
  String availableppc=tableppc.getString(tableppc.getRowCount()-1, "Remaining-PPC");
  String availableopc=tableopc.getString(tableopc.getRowCount()-1, "Remaining-OPC");
  String priceppc=tableprice.getString(0, "DANGOTE");
  String priceopc=tableprice.getString(1, "DANGOTE");
  int Amountppc=0;
  int Amountopc=0;
  for (int x=0; x<tableorder.getRowCount(); x++) {
    if (tableorder.getString(x, "type").equals("ppc")) {
      Amountppc+=int(tableorder.getString(x, "amount"));
    }
    if (tableorder.getString(x, "type").equals("opc")) {
      Amountopc+=int(tableorder.getString(x, "amount"));
    }
  }
  int Totalamount=Amountppc+Amountopc;
  card1 = new Cardd ("/data/image/PPC.png", "Dangote 3X 42.5R", availableppc, priceppc, str(Amountppc), "PPC", blue, 360, 146);
  card2 = new Cardd ("/data/image/PPC2.png", "Dangote 3X 42.5N", availableopc, priceopc, str(Amountopc), "OPC", red, 587.08, 146);
  card3 = new Cardd ("/data/image/OPC.png", "Dangote Falcon", "233", "223", "242", "pp", purple, 823.9, 146);
  card4 = new Cardd ("/data/image/OPC2.png", "Dangote BlocMaster", "492", "247", "234", "opc", gray, 1060.91, 146);
  carda=new Cards("Total Orders", "QUINTALS", str( Totalamount), 617, 584, "/data/image/ICON1.png",darkGreen,midGreen,gree,"/data/image/greengra.png");
 cardb=new Cards("Total Payments", "ETB", "89", 978, 584, "/data/image/ICON2.png",darkOrange,midOrange,Orange, "/data/image/gra.png");
}
void  pageDashBoardDraw() {
  card1.draw();
  card2.draw();
  card3.draw();
  card4.draw();
 carda.draw();
 cardb.draw();
}
