class Pin {
  PImage pin, pin2;
  Pin() {
    pin = loadImage("pin.png");
    pin2 = loadImage("pin2.png");
  }

  void display() {
    for (TableRow row : tableWr.rows()) {
      float getX = row.getFloat("x");
      float getY = row.getFloat("y");
      float getRed = row.getFloat("r");
      float getGreen = row.getFloat("g");
      float getBlue = row.getFloat("b");

      image(pin, getX-18+51, getY-44+135);
      noStroke();
      fill(getRed, getGreen, getBlue);
      ellipseMode(CENTER);
      ellipse(getX+51, getY-25+135, 26, 26);
      }
      
      image(pin2, order03.xMin-18+51, order03.yMin-44+135);
      noStroke();
      fill(order03.rAve,order03.gAve,order03.bAve);
      ellipse(order03.xMin+51,order03.yMin-25+135,26,26);
    }
  } 

