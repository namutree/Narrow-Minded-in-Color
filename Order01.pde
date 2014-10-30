class Order01 {
PImage startButton;

  Order01() {
    startButton = loadImage("startButton.jpg");
  }
  void display() {
    if(mouseX<439 && mouseX>239 && mouseY<800 && mouseY>600){
      image(startButton,239,600);
      if (mousePressed){
       order =2; 
      }
      
    }
    
  }
}

