Ordercard waiting, pending;
Search search;

TableUI ordersT;

Table tableOrder;

String orderpath="C:/Users/Win 10 Pro/Documents/Processing/orders/DANGOTE.csv";
String payedpath="C:/Users/Win 10 Pro/Documents/Processing/paids/Dangote.csv";

String ordersTheaders [] = {"No.", "Type", "Amount(q)", "Date/Time", "State"};
String labels[]={"No.", "Amount (q)", "Type", "Time", "State"};
String headers[]={"No.", "Amount (q)", "Type", "Time", "State"};

void initPageOrder () {
  waiting=new Ordercard("waiting", 520, 610.58, "/data/image/ICON1.png", "/data/image/bluegra.png");
  pending=new Ordercard("pending", 847, 610, "/data/image/ICON1.png", "/data/image/greengra.png");
  search = new Search ("Search by Code", 984, 45); // Placeholder, posX, posY

  updateOrderTable ();
}

void pageOrderDraw () {
  ordersT.draw ();
  waiting.draw();
  pending.draw();
  search.draw ();
}

void updateOrderTable () {
  tableOrder=loadTable(orderpath, "header");

  updateOrderHeader ();
  updateOrderRows ();
}
void updateOrderHeader () {
  ordersT = new TableUI (ordersTheaders, 200, 137);
}
void updateOrderRows () {
  ordersT.rows = new Rows [0];

  String types  [] = tableOrder.getStringColumn ("type");
  String dates  [] = tableOrder.getStringColumn ("time");
  String amounts [] = tableOrder.getStringColumn ("amount");
  String states  [] = tableOrder.getStringColumn ("state");

  for (int a =0; a < types.length; a ++) {
    ordersT.addRow (types [a], amounts [a], dates [a], states [a]);
  }
}


void ordertopayed() {
  Table tablepayed=loadTable(payedpath, "header");
  tableOrder =loadTable(orderpath, "header");
  String time1=hour()+":"+minute()+":"+second()+","+day()+"/"+month()+"/"+year();
  String time2=day()+"/"+month()+"/"+year();
  for (int x=0; x<tableOrder.getRowCount(); x++) {
    if (tableOrder.getString(x, "code").equals(search.value)&&(tableOrder.getString(x, "state").equals("pending"))) {
      int rIndex=x;
      TableRow tRow = tableOrder.getRow (rIndex);
      String type = tRow.getString ("type");
      String amount = tRow.getString ("amount");
      TableRow pRow = tablepayed.addRow ();
      pRow.setString ("types", type);
      pRow.setString ("amount", amount);
      pRow.setString ("time", time1);
      pRow.setString ("time2", time2);
     // tablepayed.setString(tablepayed.getRowCount()-1,"price",tableorder.getString(x,"price"));
      saveTable(tablepayed, payedpath);
      tableOrder.removeRow(x);
      saveTable(tableOrder, orderpath);
      
      initPagePaid ();
      
      break;
    }
  }
}


void fetchQuery (String code) {
  ordersT.rows = new Rows [0];
  for (int x=0; x<tableOrder.getRowCount(); x++) {
    if (tableOrder.getString(x, "code").equals (code)) {
      String type=tableOrder.getString(x, "type");
      String amount=tableOrder.getString(x, "amount");
      String time=tableOrder.getString(x, "time");
      if (tableOrder.getString(x, "state").equals("Waiting")) {
        String state=tableOrder.getString(x, "state");
        ordersT.addRow (type, amount, time, state);
      } else if (tableOrder.getString(x, "state").equals("pending")) {
        ordersT.rows = new Rows [0];
        Rows row = new Rows (new String [] {"1.", type, amount, time}, new Button ("verify", green, midGreen, darkGreen));
        ordersT.addRow (row);
        break;
        
      }
    }
  }
}

void pageOrderMousePressed () {
  search.mousePressed ();
  if (search.trailingContainerHovered==true) {
    updateOrderRows ();
  }
  if ( ordersT.rows.length>=1) {
    if (ordersT.rows [0].buttonHovered()) {
      ordertopayed();
      search.value="";
      updateOrderRows ();
    }
  }
}

void pageOrderMouseWheel (MouseEvent e) {
  ordersT.mouseWheel(e);
}

void pageOrderKeyPressed () {
  if (keyCode == ENTER) {
    if (search.active) {
      search.keyPressed ();
      fetchQuery (search.value);
    }
  } else {
    search.keyPressed ();
  }
}
