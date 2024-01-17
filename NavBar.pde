class NavBar {
  NavButton buttons [];

  NavBar () {
    buttons = new NavButton [0];
  }

  void addButton (NavButton button) {
    buttons = (NavButton []) append (buttons, button);
  }
  void addButton (NavButton button, boolean activeable) {
    button.activeable = activeable;
    buttons = (NavButton []) append (buttons, button);
  }

  void draw () {
    for (int a = 0; a < buttons.length; a ++) {
      buttons [a].draw ();
    }
  }

  void activate (int index) {
    if (buttons [index].activeable) {
      buttons [index].active = true;

      for (int x = 0; x < buttons.length; x ++) {
        if (x != index && buttons [x].activeable) {
          buttons [x].active = false;
        }
      }
    }
  }

  boolean active (int index) {
    return buttons [index].active;
  }

  boolean hovered (int index) {
    return buttons [index].hovered ();
  }

  void mousePressed () {
    for (int a = 0; a < buttons.length; a ++) {
      if (buttons [a].hovered ()) {
        if (buttons [a].activeable) {
          buttons [a].active = true;

          for (int x = 0; x < buttons.length; x ++) {
            if (x != a && buttons [x].activeable) {
              buttons [x].active = false;
            }
          }
        }
      }
    }
  }
}
