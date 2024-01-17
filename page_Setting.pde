Card ppc, opc, ppc2, opc2;
String ppcpath="C:/Users/Win 10 Pro/Documents/Processing/amount ppc.csv";
String opcpath="C:/Users/Win 10 Pro/Documents/Processing/amount opc.csv";
String pricepath="C:/Users/Win 10 Pro/Documents/Processing/price data.csv";
String priceuserpath="C:/Users/Win 10 Pro/Documents/Processing/factorydata.csv";
String pathorders="C:/Users/Win 10 Pro/Documents/Processing/orders/DANGOTE.csv";
Table  tableorder;
Table  tableppc;
Table  tableopc;
Table  priceoftable;
Table  priceuser;
void sendMessage(String phone, String message) {
  println(phone, message);
}
void initSettingPage() {
  ppc = new Card ("Dangote 3X 42.5R", "PPC", "data/images/PPC.png", blueMid, 363, 167);
  opc = new Card ("Dangote 3X 42.5N", "OPC", "data/images/PPC2.png", reddishBrown, 841, 167);
  ppc2=new Card ("Dangote Falcon", "PPC", "data/images/OPC.png", purple, 363, 470);
  opc2=new Card ("Dangote BlocMaster", "OPC", "data/images/OPC2.png", gray, 841, 470);
}
void pageSettingDraw() {
  ppc.draw ();
  opc.draw ();
  ppc2.draw();
  opc2.draw();
  tableppc=loadTable(ppcpath, "header");
  tableopc=loadTable(opcpath, "header");
  tableorder=loadTable(pathorders, "header");
  priceoftable=loadTable(pricepath, "header");
  priceuser=loadTable(priceuserpath, "header");
  tableppc.setString(0, "Remaining-PPC", "0");
  tableopc.setString(0, "Remaining-OPC", "0");
  ppc.amount.showAssistiveText(tableppc.getString(tableppc.getRowCount()-1, "Remaining-PPC")+" Qntl left");
  opc.amount.showAssistiveText(tableopc.getString(tableopc.getRowCount()-1, "Remaining-OPC")+"Qntl left");
  ppc.price.showAssistiveText("price:"+ priceuser.getString(0, "DANGOTE"));
  opc.price.showAssistiveText("price:"+ priceuser.getString(1, "DANGOTE"));
}
void pageSettingMousePressed() {  
  ppc.mousePressed();
  opc.mousePressed ();
  ppc2.mousePressed();
  opc2.mousePressed();
  tableppc=loadTable(ppcpath, "header");
  tableopc=loadTable(opcpath, "header");
  priceoftable=loadTable(pricepath, "header");
  saveamount(ppc, tableppc, "Remaining-PPC", "Produced-PPC", "Consumed-PPC", "Time-PPC", ppcpath, priceoftable, "ppc", pricepath);
  saveamount(opc, tableopc, "Remaining-OPC", "Produced-OPC", "Consumed-OPC", "Time-OPC", opcpath, priceoftable, "opc", pricepath);
  orderlist(ppc, "ppc", tableppc, "Consumed-PPC", "Remaining-PPC", ppcpath);
  orderlist(opc, "opc", tableopc, "Consumed-OPC", "Remaining-OPC", opcpath);
}
void orderlist(Card card, String typecement, Table table, String Consumed, String Remaining, String tablepath) {
  if (card.save.hovered()) {
    for (int x=tableorder.getRowCount(); x>0; x--) {
      if (!(tableorder.getString(x-1, "state").equals("pending"))) {
        if (tableorder.getString(x-1, "type").equals(typecement)) {
          int TA=int(table.getString(table.getRowCount()-1, Remaining)); 
          int amount=int(tableorder.getString(x-1, "amount"));
          int range=TA-amount;
          if (TA>=amount) {
            tableorder.setString(x-1, "state", "pending");
            saveTable(tableorder, pathorders);
            TA=range;
            int cons=int(table.getString(table.getRowCount()-1, Consumed))+int(amount);
            table.setString(table.getRowCount()-1, Remaining, str(range));
            table.setString(table.getRowCount()-1, Consumed, str(cons));
            saveTable(table, tablepath);
            updateOrderTable ();
            String phone= tableorder.getString(x-1, "phone");
            String phoneN=phone.substring(1, phone.length());
            print(phoneN);
            String code=tableorder.getString(x-1, "code");
            sendMessage(phoneN, "You can take the cement from its factory using "+code+" code Thank you for Using Ethio-Digital-Cement system");
            sendSMS(phoneN, "You can take the cement from its factory using "+code+" code Thank you for Using Ethio-Digital-Cement system");
          } else {
            break;
          }
        }
      }
    }
  }
}
void saveamount(Card card, Table tableam, String Remaining, String Produced, String Consumed, String Time, String patham, Table tablepr, String typeofcem, String pathpr) {
  String time=day()+"/"+month()+"/"+year()+","+hour()+":"+minute()+":"+second();
  if (card.save.hovered()) {
    tableam.setString(0, Remaining, "0");  
    int ta=int(tableam.getString(tableam.getRowCount()-1, Remaining))+int(card.amount.value);
    tableam.setString(tableam.getRowCount(), Produced, card.amount.value);
    tableam.setString(tableam.getRowCount()-1, Consumed, "0");
    tableam.setString(tableam.getRowCount()-1, Remaining, str(ta));
    tableam.setString(tableam.getRowCount()-1, Time, time);
    saveTable(tableam, patham);
    if (!(card.price.value.equals(""))) {
      print(tablepr.findRowIndex("DANGOTE", "factorylist"));
      tablepr.setString(tablepr.findRowIndex("DANGOTE", "factorylist"), typeofcem, card.price.value);
      saveTable(tablepr, pathpr);
    }
    card.amount.value="";
    card.price.value="";
    // if(keyPressed){ card.price.value=priceoftable.getString(0, typeofcem);}
  }
  if (card.Discard.hovered()) {
    card.amount.value="";
    card.price.value="";
  }
}
void pageSettingKeyPressed () {
  ppc.keyPressed();
  opc.keyPressed ();
  ppc2.keyPressed();
  opc2.keyPressed ();
}
