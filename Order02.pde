class Order02 {

  int present;
  int bright;
  int order021;
  int count;

  PImage s;
  PImage cameraBtn;

  Order02() {
    order021=0;
    cameraBtn = loadImage("cameraBtn.jpg");
  }

  void display() {
    if (mouseX<640 && mouseX>440 && mouseY<800 && mouseY>600) {
      image(cameraBtn, 440, 600);
      if (mousePressed) {

        //--------------------flash light----------------
        if (order021 ==0) {
          present = millis(); 
          order021 =1;
        }
      }
    }
    if (order021 ==1) {
      textSize(100);
      fill(255);
      if (millis() - present<1000) {
        text("3", width/2, height/2);
      }
      else if (millis()-present<2000) {
        text("2", width/2, height/2);
      }
      else if (millis()-present<3000) {
        text("1", width/2, height/2);
      }
      else {
        count = tableWr.getRowCount();
        cam.save(dataPath(str(count) +".jpg"));
        s = loadImage(str(count)+".jpg");
        order021=2;
        present=0;
      }
    }
    if (order021==2) {
      image(bg02, 0, 0);
      image(s, 320, 90);
      order021=0;
      order=3;
    }
  }
}

