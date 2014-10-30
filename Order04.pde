class Order04 {
  PImage homeBtn;

  Order04() {
    homeBtn = loadImage("homeBtn.jpg");
  }
  void display() {
    if (mouseX>842 && mouseX<1042 && mouseY>600) {
      image(homeBtn, 842, 600);
        if (mousePressed) {
          order =1;
        }
    }
  }
}

