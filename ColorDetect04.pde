import processing.video.*; // Now we need the video library
Capture cam; // Capture object

float order =1;
PImage bg01, bg02, bg03, bg04, bg05;


Table tableWr, tableRd;

Order01 order01;
Order02 order02;
Order03 order03;
Order04 order04;
ToTheBack totheback;
Pin pin;

void setup() {
  size(1280, 800);
  frameRate(30);

  // Start capturing
  cam = new Capture(this, 640, 480);

  bg01 = loadImage("bg01.jpg");
  bg02 = loadImage("bg02.jpg");
  bg03 = loadImage("bg03.jpg");
  bg04 = loadImage("bg04.jpg");
  bg05 = loadImage("bg05.jpg");

  cam.start();

  loadData();

  order01 = new Order01();
  order02 = new Order02();
  order03 = new Order03();
  order04 = new Order04();
  totheback = new ToTheBack();
  pin = new Pin();
}

// New images from camera
void captureEvent(Capture cam) {
  cam.read();
}

void draw() {
  //order==1---------------------first page----------------
  if (order==1) {
    image(bg01, 0, 0);
    order01.display(); // start page and click to order2
  }
  //order==2---------------------second page---------------
  if (order ==2) {
    image(bg02, 0, 0);
    // Draw the video
    image(cam, 320, 90);

    order02.display(); // take a photo and automatically order3
  }

if (order ==2.5){
 image (bg02,0,0);
image(cam,320,90);
println("order is 2.5");
if (mouseY<570) order =3;
  
}




  // order ==3 click 3 points ------------------- third page--------------
  if (order ==3) {
    image(bg03, 0, 0);
    image(order02.s, 320, 90);
    order=4; // automatically to order4
  }
  if (order ==4) {   
    order03.display(); // click points and click to order5
  }
  if (order ==5) {  
    // calculate whole picture to find green point
    //and automatically to order6
    order03.calculate(); 
  }


  if (order == 6) {
    image(order02.s, 320, 90);
    order03.calculate2(); // average the skin tone
  }
  
    if(order ==6.5){
    order03.saveData();// save data and caculate participants average as well
    order =7; // automatically to order7
  }

  if (order == 7) {

    image(bg04, 0, 0);
     RGBcircle(); // draw RGB circles
     pin.display(); // locate pins
     
     order04.display(); // click to order1
     
  }
  
  totheback.display();
  
}


//////////////////////////////////////////////////////////////////////////////////////
///////////////////////end of draw////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

void loadData() {
  tableWr = loadTable("dataWr.csv", "header");
  tableRd = loadTable("ColorData_10000.csv", "header");
}

//------------------------------------------------------------
//------------RGB circles-------------------------------------
//------------------------------------------------------------
void RGBcircle(){
  // AVERAGE BOXES -----------------------------------
    noStroke();
    // participants average
    fill(order03.partAveR, order03.partAveG, order03.partAveB);
    rect(935, 417, 100, 100);
    fill(220);
    textAlign(LEFT);
    textSize(19);
     text("R: " + ceil(order03.partAveR)+"\n"+"G: " + ceil(order03.partAveG)+"\n"+"B: " +ceil(order03.partAveB), 944,439);

    
    //current average
    fill(order03.rAve, order03.gAve, order03.bAve);
    rect(768, 417, 100, 100 );
    fill(220);
    textAlign(LEFT);
    text("R: " + ceil(order03.rAve)+"\n"+"G: " + ceil(order03.gAve)+"\n"+"B: " +ceil(order03.bAve), 776,439);

    

    // RGB Basic Circles - me large
    noFill();
    stroke(255);
    strokeWeight(1);
    int dL=118;
    ellipse (823, 212, dL, dL); //r
    ellipse (988, 212, dL, dL); //g
    ellipse (1147, 212, dL, dL); //b

    // RGB Basic Circles - participants small    
    int dS =72;
    stroke(179);
    strokeWeight(1);
    ellipse (823, 212, dS, dS); //r
    ellipse (988, 212, dS, dS); //g
    ellipse (1147, 212, dS, dS); //b

    // R colored Circles - me large
    stroke(255, 0, 0);
    strokeWeight(10);
    strokeCap(SQUARE);
    float angleRL=map(order03.rAve, 0, 255, 0, PI*2);
    arc(823, 212, dL, dL, PI+HALF_PI, PI+HALF_PI+angleRL);

    // R colored Circles - participants small
    stroke(220);
    strokeWeight(10);
    strokeCap(SQUARE);
    float angleRS = map(order03.partAveR, 0, 255, 0, PI*2);
    arc(823, 212, dS, dS, PI+HALF_PI, PI+HALF_PI+angleRS);

    // R value display
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(19);
    text(ceil(order03.rAve), 823, 212);



    // G colored Circles - me large
    noFill();
    stroke(0, 255, 0);
    strokeWeight(10);
    strokeCap(SQUARE);
    float angleGL=map(order03.gAve, 0, 255, 0, PI*2);
    arc(988, 212, dL, dL, PI+HALF_PI, PI+HALF_PI+angleGL);

    // G colored Circles - participants small
    stroke(220);
    strokeWeight(10);
    strokeCap(SQUARE);
    float angleGS = map(order03.partAveG, 0, 255, 0, PI*2);
    arc(988, 212, dS, dS, PI+HALF_PI, PI+HALF_PI+angleGS);

    // G value display
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(19);
    text(ceil(order03.gAve), 988, 212);


    // B colored Circles - me large
    noFill();
    stroke(0, 0, 255);
    strokeWeight(10);
    strokeCap(SQUARE);
    float angleBL=map(order03.bAve, 0, 255, 0, PI*2);
    arc(1147, 212, dL, dL, PI+HALF_PI, PI+HALF_PI+angleBL);

    // G colored Circles - participants small
    stroke(220);
    strokeWeight(10);
    strokeCap(SQUARE);
    float angleBS = map(order03.partAveB, 0, 255, 0, PI*2);
    arc(1147, 212, dS, dS, PI+HALF_PI, PI+HALF_PI+angleBS);

    // G value display
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(19);
    text(ceil(order03.bAve), 1147, 212);

    // participants number
    textAlign(CENTER, TOP);
    textSize(30);
    text(tableWr.getRowCount(), 1147, 447);  
}
