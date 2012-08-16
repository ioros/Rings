// @p5jss pjs = "processing-1.4.0.min.js"

float rings[][] = new float[38][2];
int szin[] = new int[38];
float x, y;
float kx = 0;
float ky = 150;

void setup(){
  size(480, 300);
  float co = cos(PI/10);
  float si = sin(PI/10);
  float b1, b2;
  for(int j=0; j<2; j++) {
    float a1 = 240;
    float a2 = 60 + j*2*90;
    for (int i=0; i<19; i++) {
      b1 = ((a1-(240+90-j*2*90))*co+(a2-150)*si)+(240+90-j*2*90);
      b2 = (-(a1-(240+90-j*2*90))*si+(a2-150)*co)+150;
      if (j==0) {
        if (i<10) {
          szin[i+j*19] = #FF0000;
        } else {
          szin[i+j*19] = #FFFF00;
        }
      } else {
        if (i<10) {
          szin[i+j*19] = #000000;
        } else {
          szin[i+j*19] = #0000FF;
        }
      }
      rings[i+j*19][0] = b1;
      rings[i+j*19][1] = b2;
      a1 = b1;
      a2 = b2;
    }
  }
}

void draw(){
  background(#888888);
  for(int i=0;i<38;i++) {
    fill(szin[i]);
    ellipse(rings[i][0],rings[i][1],40,40);
  }
}

void mousePressed(){
  float d;
  x = mouseX;
  y = mouseY;
  float j = (x-330)*(x-330)+(y-150)*(y-150);
  float b = (x-150)*(x-150)+(y-150)*(y-150);
  int t = 0;
  if ((10000<=b) && (b<=25600)) {
    t += -1;
  }
  if ((10000<=j) && (j<=25600)) {
    t += +1;
  }
  if (t!=0) {
    if (t==-1) {
      kx = 150;
      ky = 150;
      d = sqrt(b);
    } else {
      kx = 330;
      ky = 150;
      d = sqrt(j);
    }
    x = (x-kx)/d;
    y = (y-ky)/d;
  } else {
    kx = 0;
  }
}

void mouseDragged(){
  if (kx!=0) {
    float ex = mouseX;
    float ey = mouseY;
    float d = sqrt((ex-kx)*(ex-kx)+(ey-ky)*(ey-ky));
    float ux, uy;
    ex = (ex-kx)/d;
    ey = (ey-ky)/d;
    float co = (x*ex+y*ey)/(x*x+y*y);
    float si = (y*ex-x*ey)/(x*x+y*y);
    for (int i=0;i<38;i++) {
      d = (rings[i][0]-kx)*(rings[i][0]-kx)+(rings[i][1]-ky)*(rings[i][1]-ky);
      if ((14400<d) && (d<=19600)) {
        ux = ((rings[i][0]-kx)*co+(rings[i][1]-ky)*si)+kx;
        uy = (-(rings[i][0]-kx)*si+(rings[i][1]-ky)*co)+ky;
        rings[i][0] = ux;
        rings[i][1] = uy;
      }
    }
    x = ex;
    y = ey;
  }
}

void mouseReleased(){
  if (kx!=0) {
    float ux, uy, d;
    float min = 320400;
    int mini = -1;
    for (int i=0;i<38;i++) {
      d = (rings[i][0]-kx)*(rings[i][0]-kx)+(rings[i][1]-ky)*(rings[i][1]-ky);
      if ((14400<d) && (d<=19600)) {
        d = (rings[i][0]-240)*(rings[i][0]-240)+(rings[i][1]-60)*(rings[i][1]-60);
        if (d<min) {
          min = d;
          mini = i;
        }
      }
    }
    float co = ((rings[mini][0]-kx)*(240-kx)+(rings[mini][1]-ky)*(60-ky))/((rings[mini][0]-kx)*(rings[mini][0]-kx)+(rings[mini][1]-ky)*(rings[mini][1]-ky));
    float si = ((rings[mini][1]-ky)*(240-kx)-(rings[mini][0]-kx)*(60-ky))/((rings[mini][0]-kx)*(rings[mini][0]-kx)+(rings[mini][1]-ky)*(rings[mini][1]-ky));
    for (int i=0;i<38;i++) {
      d = (rings[i][0]-kx)*(rings[i][0]-kx)+(rings[i][1]-ky)*(rings[i][1]-ky);
      if ((14400<d) && (d<=19600)) {
        ux = ((rings[i][0]-kx)*co+(rings[i][1]-ky)*si)+kx;
        uy = (-(rings[i][0]-kx)*si+(rings[i][1]-ky)*co)+ky;
        rings[i][0] = ux;
        rings[i][1] = uy;
      }
    }
    min = 320400;
    mini = -1;
    for (int i=0;i<38;i++) {
      d = (rings[i][0]-240)*(rings[i][0]-240)+(rings[i][1]-60)*(rings[i][1]-60);
      if (d<min) {
        min = d;
        mini = i;
      }
    }
    rings[mini][0] = 240;
    rings[mini][1] = 60;
    min = 320400;
    mini = -1;
    for (int i=0;i<38;i++) {
      d = (rings[i][0]-240)*(rings[i][0]-240)+(rings[i][1]-240)*(rings[i][1]-240);
      if (d<min) {
        min = d;
        mini = i;
      }
    }
    rings[mini][0] = 240;
    rings[mini][1] = 240;
    kx = 0;
  }
}