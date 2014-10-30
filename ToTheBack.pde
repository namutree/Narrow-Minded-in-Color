class ToTheBack {

  PImage reBtn;

  ToTheBack() {      
    reBtn = loadImage("reBtn.jpg");
  }

  void display() {
    if (mouseX>1207 && mouseY<62) {
      image(reBtn, 1207, 0);
      if (mousePressed && order>1) {
        if (order==2) order=1;
        if (order==3) order=1;
        if (order==4) order=3;
        if (order==5) order=3;
      }
    }
  }
}

