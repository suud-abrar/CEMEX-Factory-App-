import java.time.LocalDate;
String todayStr = year () + "-" + (month () < 10? 0 + "" + month () : month ()) + "-" + (day () < 10? 0 + "" + day () : day ());
LocalDate today = LocalDate.parse (todayStr);
int priceweek=0;
int pricemonth=0;
int priceyear=0;
Payedcard weekly, monthly, yearly;
String tablepath="C:/Users/Win 10 Pro/Documents/Processing/paids/Dangote.csv";
Table tableprice;
Tablepayed tablep;
String ordersTheader [] = {"No.", "Type", "Amount(q)", "Price", "Date/Time"};
void initPagePaid() {
  tableprice=loadTable(tablepath, "header");
  tablep = new Tablepayed (ordersTheader, 200, 137);
  String types  [] = tableprice.getStringColumn ("types");
  String dates  [] = tableprice.getStringColumn ("time");
  String date2  [] = tableprice.getStringColumn ("time2");
  String amounts [] = tableprice.getStringColumn ("amount");
  String price [] = tableprice.getStringColumn ("price");
  for (int a =0; a < types.length; a ++) {
    tablep.addRow (types [a], amounts [a], price [a], dates [a] );
  }
  String last7Days [] = new String [0];
  int index=0;
  for (int x=0; x<7; x++) {
    today = today.minusDays (1);
    last7Days = append (last7Days, today.getMonthValue ()+ "/" + today.getDayOfMonth() + "/" + today.getYear ());
  }
  for (int x=last7Days.length-1; x>=0; x--) {
    if (!(tableprice.findRowIndex( last7Days[x], 4)==-1)) {
      index=tableprice.findRowIndex( last7Days[x], 4);
      break;
    }
  }
  for (int x=index; x<tableprice.getRowCount(); x++) {
    String price1=tableprice.getString(x, "price");
    priceweek+=int(price1);
  }
  String last30Days [] = new String [0];
  int indexofmonth=0;
  for (int x=0; x<30; x++) {
    today = today.minusDays (1);
    last30Days =append (last30Days, today.getMonthValue ()+ "/" + today.getDayOfMonth() + "/" + today.getYear ());
  }
  for (int x=last30Days.length-1; x>=0; x--) {
    if (!(tableprice.findRowIndex( last30Days[x], 4)==-1)) {
      indexofmonth=tableprice.findRowIndex( last30Days[x], 4);
      break;
    }
  }
  for (int x=indexofmonth; x<tableprice.getRowCount(); x++) {
    String price1=tableprice.getString(x, "price");
    pricemonth+=int(price1);
  }
  String last365Days [] = new String [0];
  int indexofyear=0;
  for (int x=0; x<365; x++) {
    today = today.minusDays (1);
    last365Days =append (last365Days, today.getMonthValue ()+ "/" + today.getDayOfMonth() + "/" + today.getYear ());
  }
  for (int x=last365Days.length-1; x>=0; x--) {
    if (!(tableprice.findRowIndex( last365Days[x], 4)==-1)) {
      indexofyear=tableprice.findRowIndex( last365Days[x], 4);
      break;
    }
  }
  for (int x=indexofyear; x<tableprice.getRowCount(); x++) {
    String price1=tableprice.getString(x, "price");
    priceyear+=int(price1);
  }
  weekly=new Payedcard("Weekly", str(priceweek), 381, 613.58, Orange, "/data/image/ICON2.png", "/data/image/gra.png");
  monthly=new Payedcard("Monthly", str(pricemonth), 708.63, 613.58, Orange, "/data/image/ICON2.png", "/data/image/gra.png");
  yearly=new Payedcard("Yearly", str(priceyear), 1024, 616.58, Orange, "/data/image/ICON2.png", "/data/image/gra.png");
}
void pagePaidDraw() {
  tablep.draw();
  noStroke();
  fill(#020F1D);
  rect(339, 544, 951, 768-541);
  weekly.draw();
  monthly.draw();
  yearly.draw();
}
void pagePaidMouseWheel (MouseEvent e) {
  tablep.mouseWheel(e);
}
