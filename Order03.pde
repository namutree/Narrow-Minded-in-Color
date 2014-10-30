class Order03 {

  PImage conBtn;
  PImage conBtn_n;

  int count;

  float r[]= new float [1280*570];
  float g[]= new float [1280*570];
  float b[]= new float [1280*570];
  float r1[]= new float [1280*570];
  float g1[]= new float [1280*570];
  float b1[]= new float [1280*570];

  float rAve, gAve, bAve;

  float distMin;
  float rMin, gMin, bMin, xMin, yMin;

  float partAveR;
  float partAveG;
  float partAveB;
  float partAveCount;

  Order03() {
    conBtn = loadImage("conBtn.jpg");
    conBtn_n = loadImage("conBtn_n.jpg");
    count=0;

    partAveCount=0;
  }

  void display() {
    distMin = 9899;
    image(conBtn_n, 641, 600);

    
    if (mouseX<960 && mouseX>320 && mouseY>90 && mouseY<570) {
      if (mousePressed) {
        fill(0, 255, 0);
        noStroke();
        ellipse (mouseX, mouseY, 15, 15);
      }
    }

    if (mouseX<841 && mouseX>641 && mouseY<800 && mouseY>600) {
      image(conBtn, 641, 600);
      if (mousePressed) {
        order = 5;
      }
    }
  }
  
  void calculate() {
    loadPixels();
    for (int i=0;i<1280*570;i++) {
      r1[i]=red(pixels[i]);
      g1[i]=green(pixels[i]);
      b1[i]=blue(pixels[i]);

      order = 6;
    }
    updatePixels();
  }


  void calculate2 () {
    //initialize rgb.
    for (int i=0;i<1280*570;i++) {
      r[count] = 0;
      g[count] = 0;
      b[count] = 0;
    }
    count=0;
    loadPixels();
    for (int i=0;i<1280*570;i++) {
      if (r1[i]<3 && g1[i]>253 && b1[i]<3) {
        r[count] = red(pixels[i]);
        g[count] = green(pixels[i]);
        b[count] = blue(pixels[i]);
        count++;
        
      }
    }
    updatePixels();

    println("count: " + count);


    for (int i=0;i<count;i++) {
      rAve = rAve + r[i];
      gAve = gAve + g[i];
      bAve = bAve + b[i];
    }
    

    
    rAve = rAve/count;
    gAve = gAve/count;
    bAve = bAve/count;
    
    if (count==0) order =3;
    else order=6.5;
  }


  void saveData() {
    partAveCount=0;
    // get data from existing table and calculate min
    for (TableRow row : tableRd.rows()) {
      float getX = row.getFloat("x");
      float getY = row.getFloat("y");
      float getRed = row.getFloat("r");
      float getGreen = row.getFloat("g");
      float getBlue = row.getFloat("b");

      float distColor = dist(rAve, gAve, bAve, getRed, getGreen, getBlue);
      if (distColor<distMin) {
        distMin=distColor;
        rMin = getRed;
        gMin = getGreen;
        bMin = getBlue;
        xMin = getX;
        yMin = getY;
      }
    }
    // save aver color and x,y cordinate
    TableRow row = tableWr.addRow();
    row.setFloat("x", xMin);
    row.setFloat("y", yMin);
    row.setFloat("r", rAve);
    row.setFloat("g", gAve);
    row.setFloat("b", bAve);
    saveTable(tableWr, "data/dataWr.csv");

    partAveR = 0;
    partAveG = 0;
    partAveB = 0;

      //avreage color of all participate
    for (TableRow row1 : tableWr.rows()) {
      float getRed = row1.getFloat("r");
      float getGreen = row1.getFloat("g");
      float getBlue = row1.getFloat("b");

      partAveR = partAveR + getRed;
      partAveG = partAveG + getGreen;
      partAveB = partAveB + getBlue;


      partAveCount++;
      println("participants counts: "+partAveCount);
    }
    partAveR = partAveR/partAveCount;
    partAveG = partAveG/partAveCount;
    partAveB = partAveB/partAveCount;
  }
}

