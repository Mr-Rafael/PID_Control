  import processing.serial.*;

  Serial myPort;
  int xPos = 30;
  int[] inByte = new int[3];
  String[] values = new String[4];                           // los valores son: setpoint, kp, ki, kd
  String[] valNames = new String[4];
  boolean[] activeText = new boolean[4];
  boolean[] floatPoint = new boolean[4];

  void setup () {
    size(1200, 600);
    inByte[0] = 129;
    inByte[1] = 10;
    inByte[2] = 254;
    valNames[0] = "Set Point";
    valNames[1] = "Kp";
    valNames[2] = "Ki";
    valNames[3] = "Kd";
    for (int i = 0; i < 4; i = i+1) {
      activeText[i] = false;
      floatPoint[i] = false;
      values[i] = "0";
    }
    
    //myPort = new Serial(this, Serial.list()[0], 9600);
    //myPort.bufferUntil('\n');

    // set initial background:
    fondo();
    textBox();
    buttons();
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
      textBox();
      buttons();
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
    grafica();
  }
  
  void grafica() {
    stroke(50,50,50);
    for(int i = 0; i < 57; i++) {
      line(30 + i * 20, height - 30,30 + i * 20, 270);
    }
    for(int i = 0; i < 15; i++) {
      line(30, height- 39 - i*20, width - 30, height - 39 - i*20);
    }
    stroke(200,0,0);
    line(30, 421, width - 30, 421);
    strokeWeight(2);
    line(30, height - 31, 30, height - 329);
    strokeWeight(1);
    fill(255,255,255);
    textSize(7);
    for(int i = 0; i < 15; i++) {
      text(- 350 + 50*i,30,height - 39 - i*20);
    }
  }
  
  void textBox() {
    stroke(255,255,255);
    fill(255,255,255);
    beginShape();
    vertex(50,50);
    vertex(1150,50);
    vertex(1150,137);
    vertex(50,137);
    endShape(CLOSE);
    
    for (int i = 0; i < 4; i++) {
        
      if(activeText[i]) {
        strokeWeight(2);
        stroke(0,100,200);
      } else {
        stroke(0,0,0);
      }
        
        fill(255,255,255);
        beginShape();
        vertex(50 + 300*i, 100);
        vertex(250 + 300*i, 100);
        vertex(250 + 300*i, 120);
        vertex(50 + 300*i, 120);
        endShape(CLOSE);
        strokeWeight(1);
        textSize(16);
        fill(0,0,0);
        text(values[i], 55 + 300*i, 117); 
        textSize(20);
        text(valNames[i], 50 + 300*i, 92);
    }
  }
  
void mouseReleased() {
    for(int i = 0; i < 4; i++) {
      floatPoint[i] = false;
      if (mouseX - 55 - 300*i < 200 && mouseX - 55 - 300*i > 0 && mouseY > 100 && mouseY < 120) {
        values[i] = "";
        activeText[i] = true;
      } else {
        activeText[i] = false;
      }
    }
    
    if(mouseX < 550 && mouseX > 50 && mouseY > 150 && mouseY < 220) {
      println("Enviado: ", values[0], ":", values[1], ":", values[2], ":", values[3]);
      // seriales ya tu sabe
    }
    if(mouseX < 1160 && mouseX > 650 && mouseY > 150 && mouseY < 220) {
      println("Enviado: ", "STAHP");
    }
    textBox();
}

void keyReleased() {
  for(int i = 0;i < 4;i++) {
    if(activeText[i]) {
      if (key >= '0' && key <= '9') {
        values[i] = values[i] + key;
      } else if (key == '.' && !floatPoint[i] && values[i].length() > 0) {
        floatPoint[i] =  true;
        values[i] = values[i] + key;
      }
    }
  }
  textBox();
}

void buttons() {
  stroke(0,0,0);
  fill(100,150,0);
  beginShape();
  vertex(50,150);
  vertex(550,150);
  vertex(550,220);
  vertex(50,220);
  endShape(CLOSE);
  textSize(40);
  fill(200,0,0);
  beginShape();
  vertex(650,150);
  vertex(1150,150);
  vertex(1150,220);
  vertex(650,220);
  endShape(CLOSE);
  fill(255,255,255);
  text("Cambiar Parámetros",100,200);
  text("Detener",820,200);
  
}
