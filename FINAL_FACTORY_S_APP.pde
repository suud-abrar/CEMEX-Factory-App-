Pages page, overlayPage;
NavBar navBar;
String factoryreg="C:/Users/Win 10 Pro/Documents/Processing/factory reg.csv";
Table tablereg;
boolean comname=false;
boolean id=false;
boolean pass=false;
String APIkey = " b5cd43c2f8936c2a2de43580c45eacbf3d3e8ed8";
String deviceID = "00000000-0000-0000-dfe3-341b2fc781fc";
String[] head={"Dashboard", "Orders", "Paids", "Setting"}; 
void setup() {
  fullScreen ();
  tablereg=loadTable(factoryreg, "header");
  initpagelogein();
  initCommonPage();
  initlogeout();
  initpageDashboard();
  initPageOrder ();
  initPagePaid ();
  initSettingPage();
  page = new Pages ();
  overlayPage=new Pages();
  page.setLogein();
  overlayPage.setLogout ();
  overlayPage.setOverlayEmpty();
  navBar = new NavBar ();
  navBar.addButton (new NavButton ("Dashboard", loadShape ("data/icons/dashboard.svg"), 18, 273));
  navBar.addButton (new NavButton ("Orders", loadShape ("data/icons/cart.svg"), 18, 341));
  navBar.addButton (new NavButton ("Paids", loadShape ("data/icons/paid.svg"), 18, 397));
  navBar.addButton (new NavButton ("Setting", loadShape ("data/icons/settings.svg"), 18, 453));
  navBar.addButton (new NavButton ("Logout", loadShape ("data/icons/logout.svg"), 18, 512), false);
  navBar.activate (0);
  logout = loadShape ("data/icons/logout.svg");
  logout.disableStyle();
}
PShape logout;
void draw () {
  background(blueBlack);
  CommonPageDraw();
  navBar.draw ();
  if (page.isLogein()) {
    logeinDraw();
  } else if (page.isOrders()) {
    pageOrderDraw ();
    fill(255);
    textAlign(LEFT, TOP);
    textSize(31.89);
    text(head[1], 342, 95);
  } else if (page.isSettings()) {
    pageSettingDraw();
    fill(255);
    textSize(31.89);
    textAlign(LEFT, TOP);
    text(head[3], 363, 73);
  } else if (page.isPaids()) {
    pagePaidDraw();
    fill(255);
    textSize(31.89);
    textAlign(LEFT, TOP);
    text(head[2], 342, 94);
  } else if (page.isDashBoards()) {
    pageDashBoardDraw();
    fill(255);
    textSize(31.89);
    textAlign(LEFT, TOP);
    text(head[0], 361, 70);
  }
  if (overlayPage.isLogout()) {
    fill(2, 15, 29, 255*0.8);
    rect(0, 0, 1366, 768);
    pagelogeoutDraw();
  }
  if (comname) { 
    fill (255, 0, 0, 150);
    noStroke ();
    rectMode(CORNER);
    rect(807, 220, 423, 30, 5);
    fill(0);
    textAlign(CENTER, CENTER);
    text("Invalid Company Name", 807+423/2, 233);
  } else if (id) {
    fill (255, 0, 0, 150);
    noStroke ();
    rectMode(CORNER);
    rect(807, 220, 423, 30, 5);
    fill(0);
    textAlign(CENTER, CENTER);
    text("Invalid Company ID", 807+423/2, 233);
  } else if (pass) {

    rect(807, 220, 423, 30, 5);
    fill(0);
    textAlign(CENTER, CENTER);
    text("Invalid Password", 807+423/2, 233);
  }
}
void mousePressed () {
  if (card1.cdetails.hovered()) {
    print("dh");
  }
  if (overlayPage.isLogout()) {
    if (yes.hovered()) {
      page.setLogein ();
      overlayPage.setOverlayEmpty();
    } else if (no.hovered()) {
      overlayPage.setOverlayEmpty();
    }
  } else if (page.isLogein()) {
    pageLoginmousePressed ();
    if (Login.hovered()) {
      int indexname=tablereg.findRowIndex(CompName.value, "factory name");
      if (!(indexname==-1)) {
        comname=false;
        String ID=tablereg.getString(indexname, "ID");
        String password=tablereg.getString(indexname, "password");
        if (ID.equals(CompID.value)) {
          id=false;
          if (password.equals(Password.value)) {
            pass=false;
            page.setDashBoards();
            CompName.value="";
            CompID.value="";
            Password.value="";
          } else {
            pass=true;
          }
        } else {
          id=true;
        }
      } else {
        comname=true;
      }
    }
  } else {
    if (page.isOrders()||page.isPaids()||page.isDashBoards()||page.isSettings()) {
      navBar.mousePressed ();

      if (navBar.active (0)) {
        page.setDashBoards();
        // if(cdetails.hovered()){
        //page.setOrders();}
      } else if (navBar.active (1)) {
        page.setOrders();
      } else if (navBar.active (2)) {
        page.setPaids();
      } else if (navBar.active (3)||card1.cdetails.hovered()) {
        page.setSettings();
      }

      if (navBar.hovered (4)) {
        overlayPage.setLogout();
        println ("HERE");
      }
    }

    if (page.isOrders()) {
      pageOrderMousePressed();
    } else if (page.isSettings()) {
      pageSettingMousePressed();
    }
  }
}
void mouseWheel (MouseEvent e) {
  if (page.isOrders()) {
    pageOrderMouseWheel (e);
  } else if (page.isPaids()) {
    pagePaidMouseWheel (e);
  }
}
void keyPressed () {
  if (page.isOrders()) {
    pageOrderKeyPressed ();
  } else if (page.isSettings()) {
    pageSettingKeyPressed ();
  } else if (page.isLogein()) {
    pagelogeinKeyPressed ();
  }
}
