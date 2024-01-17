class Search { // Persistent Search
  PShape searchIcon, clearIcon, clockIcon;

  String placeholder = "Search", value = ""; // placeholder: short descriptive hint expectd of the input field  |  Value: Input text (content)
  String prevValue;
  String allowedInputChars = "";
  String LETTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
  String NUMBERS = "0123456789";
  String SPECIAL_CHARACTERS = "!@#$%^&*()-=*.,/?;:'[]{}\"|\\`~";
  String SPACE = " ";
  String NAME_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz /.";
  String LEVENSHTEIN = "Levenshtein";
  String STARTS_WITH = "startsWith";
  String STARTS_WITH_AND_LEVENSHTEIN = LEVENSHTEIN + STARTS_WITH;
  String searchBy = STARTS_WITH_AND_LEVENSHTEIN;

  String matchingSuggestions [], historicalSuggestions [];
  StringList suggestions;

  float xs = 480, ys = 180;
  float ws = 303.15, hs = 43;

  float textSize = 17;

  float aiMinBorderSize = 1, aiMaxBorderSize = 1.8; // ai: Activation Indicator
  float insertionPointSize = 1;
  float separatorLineSize = 1.5;
  float cornerRadius = 6;
  float iconW, iconH;
  float iconContainerD;
  float minLevenshteinSimilarity = 0.5;

  int insertionPointPeriod = 500; // Blinking period of insertion point
  int maxSuggestions = 8; // Maximum Number of Suggestions
  int selectedSuggestionIndex = -1;

  color accentColor = purple;
  color unhoveredFill = white, hoveredFill = white, activeFill = white; // For container fill
  color unhoveredStroke = gray, hoveredStroke = gray, activeStroke = gray; // For activation indicator/border & text fill
  color inactivePlaceholderFill = darkGray, valueFill = superGray;
  color insertionPointStroke = superGray;
  color leadingIconFill = gray, trailingIconFill = darkGray;
  color iconContainerHoverFill = almostGray;

  boolean active;
  boolean trailingContainerHovered;

  Fonts fonts;

  Periodically ipPeriod; // ip: Insertion Point

  void init (String placeholder, String allSuggestions [], String historicalSuggestions [], float x, float y, float w, float h) {
    this.placeholder = placeholder;
    this.xs = x;
    this.ys = y;
    this.ws = w;
    this.hs = h;

    this.matchingSuggestions = allSuggestions;
    this.historicalSuggestions = historicalSuggestions;

    ipPeriod = new Periodically (insertionPointPeriod);
    allowedInputChars = LETTERS + NUMBERS + SPACE + SPECIAL_CHARACTERS;
    fonts = new Fonts ();

    searchIcon = loadShape ("data/icons/search.svg");
    searchIcon.disableStyle();
    clearIcon = loadShape ("data/icons/clear.svg");
    clearIcon.disableStyle();
    clockIcon = loadShape ("data/icons/clock.svg");
    clockIcon.disableStyle();

    iconW = h*0.3;
    iconH = searchIcon.height*(iconW/searchIcon.width);

    iconContainerD = h*0.8;
  }
  void init (String placeholder, String allSuggestions [], float x, float y, float w, float h) {
    init (placeholder, allSuggestions, null, x, y, w, h);
  }
  void init (String placeholder, float x, float y, float w, float h) {
    init (placeholder, null, null, x, y, w, h);
  }

  Search (String placeholder, String allSuggestions [], String historicalSuggestions [], float x, float y, float w, float h) {
    init (placeholder, allSuggestions, historicalSuggestions, x, y, w, h);
  }
  Search (String placeholder, String allSuggestions [], float x, float y, float w, float h) {
    init (placeholder, allSuggestions, x, y, w, h);
  }
  Search (String placeholder, float x, float y, float w, float h) {
    init (placeholder, x, y, w, h);
  }
  Search (String placeholder, float x, float y) {
    init (placeholder, x, y, ws, hs);
  }

  void setMatchingSuggestions (String matchingSuggestions []) {
    this.matchingSuggestions = matchingSuggestions;
  }
  void setHistoricalSuggestions (String historicalSuggestions []) {
    this.historicalSuggestions = historicalSuggestions;
  }
  void setSuggestions (String allSuggestions [], String historicalSuggestions []) {
    this.matchingSuggestions = allSuggestions;
    this.historicalSuggestions = historicalSuggestions;
  }

  void draw () {
    // Suggestions : Historical & Matching
    if (active) {
      if (!value.equals(prevValue)) { // Comparing previous value of "value" and its latest not to generate suggestions over and over
        if (value.isEmpty()) suggestions = toStringList (historicalSuggestions, maxSuggestions);
        else if (!value.trim ().isEmpty()) suggestions = getSuggestions ();

        prevValue = value;
      }
    }

    // Container
    noStroke ();
    rectMode (CORNER);
    fill (hovered ()? hoveredFill : unhoveredFill, 200);
    float containerH = hs;
    float whitespaceD = (hs - iconContainerD)/2;
    float lGap = hs + whitespaceD;
    if (active) {
      if (suggestions != null && suggestions.size () > 0) {
        containerH += whitespaceD*2 + iconContainerD*suggestions.size ();
      }
    }
    rect (xs, ys, ws, containerH, cornerRadius);

    // Placeholder text
    textFont (fonts.roboto.regular);
    textSize (textSize);
    float lx = xs + lGap;
    float ly = ys + hs/2;

    textAlign (LEFT, CENTER);
    fill (inactivePlaceholderFill);
    if (!active && value.isEmpty ()) text (placeholder, lx, ly - textDescent ()/2);

    // Value text
    textFont (fonts.roboto.regular);
    textSize (textSize);    
    textAlign (LEFT, CENTER);
    fill (valueFill);
    String displayableValue = value;
    float ipX = lx + insertionPointSize + textWidth (value);
    float ipW = ws - 2*lGap - insertionPointSize;
    if (ipX  >= xs + ws - lGap) { // Insertion point has reached bound limit within field
      while (textWidth (displayableValue) > ipW) {
        if (displayableValue.length () > 0) displayableValue = displayableValue.substring (1, displayableValue.length ());
      }
    }
    if (!value.isEmpty ()) text (displayableValue, lx, ly - textDescent ()/2);

    // Insertion point | L: Length | W: Width of bounding box for the insertion point
    ipX = constrain (ipX, lx + insertionPointSize, xs + ws - lGap);
    float ipL = (textDescent () + textAscent ())*0.9;
    float ipY = ys + (hs - ipL)/2;
    if (active) stroke (insertionPointStroke);
    strokeWeight (insertionPointSize);
    if (active && ipPeriod.getState()) line (ipX, ipY, ipX, ipY + ipL);

    if (active) {
      if (suggestions != null && suggestions.size () > 0) {
        float separatorLineLength = ws - whitespaceD*2*2;
        strokeWeight (separatorLineSize);
        stroke (activeStroke);
        line (xs + ws/2 - separatorLineLength/2, ys + hs, xs + ws/2 + separatorLineLength/2, ys + hs);

        float startY = ys + hs + whitespaceD;
        float sgX = xs, sgY = startY; // sg: Suggestions
        float sgW = ws, sgH = iconContainerD;
        textAlign (LEFT, CENTER);

        noStroke ();
        rectMode (CORNER);

        selectedSuggestionIndex = -1;
        for (int a = 0; a < suggestions.size (); a ++) {
          sgY = startY + sgH*a;

          if (rectHovered (sgX, sgY, sgW, sgH, CORNER)) {
            selectedSuggestionIndex = a;
            fill (iconContainerHoverFill);
            rect (sgX, sgY, sgW, sgH);
          }

          fill (leadingIconFill);
          shape (value.isEmpty()? clockIcon : searchIcon, sgX + lGap/2, sgY + iconContainerD/2);

          fill (valueFill);
          textFont (fonts.roboto.medium);
          textSize (textSize);    
          text (suggestions.get (a), sgX + lGap, sgY + iconContainerD/2 - textDescent ()/2);
        }
      }
    }

    rectMode (CORNER);
    strokeCap (SQUARE);
    strokeWeight (hovered ()? (aiMaxBorderSize + aiMinBorderSize)/2 : aiMinBorderSize);
    if (active) strokeWeight (aiMaxBorderSize);
    stroke (hovered ()? hoveredStroke : unhoveredStroke);
    if (active) stroke (activeStroke);
    noFill ();
    rect (xs, ys, ws, containerH, cornerRadius);

    // Icon container : Trailing icon
    float scx = xs + ws - lGap/2;
    float scy = ys + hs/2;
    trailingContainerHovered = rectHovered (scx, scy, iconContainerD, CENTER);

    rectMode (CENTER);
    noStroke ();
    noFill ();
    if (trailingContainerHovered && !value.isEmpty()) fill (iconContainerHoverFill); 
    rect (scx, scy, iconContainerD, iconContainerD, cornerRadius);

    // Icons
    // li: Leading Icon
    float lix = xs + lGap/2;
    float liy = ys + hs/2;
    noStroke ();
    shapeMode (CENTER);
    fill (leadingIconFill);
    shape (searchIcon, lix, liy);

    // ti: Trailing Icon
    float tix = xs + ws - lGap/2;
    float tiy = liy;
    fill (trailingIconFill);
    if (!value.isEmpty ()) shape (clearIcon, tix, tiy);
  }

  StringList getSuggestions () {
    StringList suggestions = new StringList ();
    if (matchingSuggestions != null && matchingSuggestions.length > 0) {

      StringList matching = toStringList (matchingSuggestions);
      matching.sort ();

      // Match using starts with
      if (searchBy == STARTS_WITH || searchBy == STARTS_WITH_AND_LEVENSHTEIN)
        for (int a = 0; a < matching.size (); a ++) {
          if (matching.get (a).startsWith(value))
            suggestions.append (matching.get (a));

          if (suggestions.size () == maxSuggestions) break;
        }

      // Levenshtein
      if (searchBy == LEVENSHTEIN || searchBy == STARTS_WITH_AND_LEVENSHTEIN && suggestions.size () < maxSuggestions) {
        FloatDict lMatches = new FloatDict ();

        for (int a = 0; a < matching.size (); a ++) {
          String suggestion = matching.get (a);
          float similarity = similarity (suggestion, value);

          lMatches.set (suggestion, similarity);
        }

        lMatches.sortValuesReverse();

        for (int a = 0; a < lMatches.size (); a ++) {
          String suggestion = lMatches.keyArray () [a];
          float similarity = similarity (suggestion, value);

          if (similarity < minLevenshteinSimilarity || suggestions.size () == maxSuggestions) break;

          if (!suggestions.hasValue(suggestion)) suggestions.append (suggestion);
        }
      }
    }

    return suggestions;
  }

  boolean hovered () {
    return rectHovered (xs, ys, ws, hs, CORNER);
  }
  boolean rectHovered (float x, float y, float w, float h, float orientation) {
    return (((orientation == CORNER && mouseX >= x && mouseX < x + w && mouseY >= y && mouseY < y + h)
      || (orientation == CENTER && mouseX > x - w/2 && mouseX < x + w/2 && mouseY > y - h/2 && mouseY < y + h/2))? true : false);
  }
  boolean rectHovered (float x, float y, float d, float orientation) {
    return (((orientation == CORNER && mouseX >= x && mouseX <= x + d && mouseY >= y && mouseY <= y + d)
      || (orientation == CENTER && mouseX >= x - d/2 && mouseX <= x + d/2 && mouseY >= y - d/2 && mouseY <= y + d/2))? true : false);
  }

  void acceptNumbersOnly () {
    allowedInputChars = NUMBERS;
  }

  void mousePressed () {
    if (hovered ()) { 
      active = true;

      if (trailingContainerHovered) value = "";
    } else if (active) {
      if (selectedSuggestionIndex != -1 && suggestions.size () > 0)
        value = suggestions.get (selectedSuggestionIndex);

      active = false;
    }
  }

  void keyPressed () {
    if (active == true) {
      if (allowedInputChars.contains (str (key)))
        value += key;
      else if (value.length () > 0 && keyCode == BACKSPACE) {
        int index = value.length () - 1;
        value = value.substring (0, index);
      } else if (keyCode == ENTER) {
        active = false;
      } else if (keyCode == UP || keyCode == DOWN) {
        
      }
    }
  }
}
