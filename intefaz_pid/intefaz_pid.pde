  import processing.serial.*;
  
  

  Serial myPort;        // The serial port
  int xPos = 30;         // horizontal position of the graph
  int[] inByte = new int[3];

  void setup () {
    size(1200, 600);
    inByte[0] = 1;
    inByte[1] = 10;
    inByte[2] = 254;
    
    //myPort = new Serial(this, Serial.list()[0], 9600);
    //myPort.bufferUntil('\n');

    // set initial background:
    fondo();
  }

  void draw () {
    stroke(100,255,0);
    point(xPos,550 - inByte[0]);
    stroke(0,255,255);
    point(xPos,550 - inByte[1]);
    stroke(255,255,255);
    point(xPos,550 - inByte[2]);

    if (xPos >= width-30) {
      xPos = 30;
      fondo();
    } else {
      xPos++;
    }
  }
  
  void fondo() {
    background(255,255,255);
    stroke(0,0,0);
    fill(0,0,0);
    beginShape();
    vertex(30, 270);
    vertex(width - 30,270);
    vertex(width - 30,height - 30);
    vertex(30,height - 30);
    endShape(CLOSE);
    stroke(255,255,255);
    line(30,420,width - 30, 420);
  }
