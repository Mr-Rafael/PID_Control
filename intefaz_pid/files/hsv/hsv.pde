float hue = 0;
float sat = 0;
float val = 0;

void setup() {
  size(800,800);
  background(0,0,0);
  stroke(255,255,255,0);
  for(int i = 1; i < 500; i++) {
    hue = 0.35 - 0.000*i;
    val = 1.0/(500.0-i);
    sat = i/500.0;
    
    println(hue, val, sat);
    
    fill(255*((1.0-hue+sat)*(val)), 255*(1-2*abs(hue-0.5)+sat)*(val), 255*(hue+sat)*(val));
    ellipse(300,300,600 - i, 600 - i);
  }
}

void draw() {
}
