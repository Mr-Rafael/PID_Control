float hue = 0;
float sat = 0;
float val = 0;
float glow = 10;
float vibrance = 0.1;
float startHue = 1;
float endHue = 0.6;
int iterations = 500;
int size = 550;
int x = 300;
int y = 300;

void setup() {
  size(800,800);
  background(0,0,0);
  stroke(255,255,255,0);
  for(int i = 1; i < iterations; i++) {
    hue = startHue + ((endHue-startHue)/iterations)*i;
    val = glow/((iterations-1)-i+glow);
    sat = vibrance/((iterations-1)-i+vibrance);
    
    println(hue, val, sat);
    
    fill(255*((1.0-hue+sat)*(val)), 255*(1-2*abs(hue-0.5)+sat)*(val), 255*(hue+sat)*(val));
    ellipse(x,y,size - i, size - i);
  }
}

void draw() {
}
