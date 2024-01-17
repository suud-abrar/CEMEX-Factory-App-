class Pages {
  String page = "";
  String overlayPage = "";

  String ORDERS = "ORDERS";
  String SETTINGS = "SETTINGS";
  String PAIDS = "PAIDS";
  String DASHBOARD = "DASHBOARD";
  String LOGOUT = "LOGOUT";  
  String LOGEIN = "LOGEIN";  
  

  boolean isOrders () {
    return page.equals (ORDERS);
  }
  boolean isSettings () {
    return page.equals (SETTINGS);
  }
  boolean isPaids () {
    return page.equals (PAIDS);
  }
  boolean isDashBoards() {
    return page.equals (DASHBOARD);
  }
  boolean isLogout() {
    return overlayPage.equals (LOGOUT);
  }
   boolean isLogein() {
    return  page.equals (LOGEIN);
  }
  void setOrders () {
    page = ORDERS;
  }
  void setSettings () {
    page = SETTINGS;
  }  
  void setPaids () {
    page = PAIDS;
  }  
  void setDashBoards () {
    page =DASHBOARD;
  }  
  void setLogout () {
    overlayPage = LOGOUT;
  }
  void setOverlayEmpty () {
    overlayPage = "";
  }
   void setLogein () {
     page =LOGEIN;
  }
}
