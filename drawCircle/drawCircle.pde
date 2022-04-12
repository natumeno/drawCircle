Point[] points;
CircleByThree circle;

class Point {
  float x, y;
  String name;
  Point(float _x, float _y) {
    x=_x;
    y=_y;
  }
  Point(Point p) {
    x=p.x;
    y=p.y;
  }

  void drawPoint(int size) {
    fill(0,0,255);
    noStroke();
    ellipse(x, y, size, size);
  }
}

class Circle {
  Point center;
  Point boundary;
  Circle(Point c, Point b) {
    center = c;
    boundary = b;
  }
  float radius() {
    return dist(center.x, center.y, boundary.x, boundary.y);
  }
  void drawCircle(int weight) {
    stroke(0);
    noFill();
    strokeWeight(weight);
    float rad = radius();
    ellipse(center.x, center.y, rad*2f, rad*2f);
  }
}

class CircleByThree{
  Point p1,p2,p3;
  CircleByThree(Point _p1, Point _p2, Point _p3){
    p1=_p1;
    p2=_p2;
    p3=_p3;
  }
  void drawCircle(int weight){
    //  3点を通る円を描画する
    //  3点が一直線上にあるときには直線を描画する
    //  weight : 描画線の太さ
    //3点を通る三角形の外心を求める
    float px,py;
    float pr;
    px=(p1.y-p2.y)*(p3.x*p3.x-p1.x*p1.x+p3.y*p3.y-p1.y*p1.y)-(p1.y-p3.y)*(p2.x*p2.x-p1.x*p1.x+p2.y*p2.y-p1.y*p1.y);
    px/=2*(p1.x-p2.x)*(p1.y-p3.y)-2*(p1.x-p3.x)*(p1.y-p2.y);
    py=(p1.x-p3.x)*(p2.x*p2.x-p1.x*p1.x+p2.y*p2.y-p1.y*p1.y)-(p1.x-p2.x)*(p3.x*p3.x-p1.x*p1.x+p3.y*p3.y-p1.y*p1.y);
    py/=2*(p1.x-p2.x)*(p1.y-p3.y)-2*(p1.x-p3.x)*(p1.y-p2.y);
    pr=dist(px,py,p1.x,p1.y);
    stroke(0);
    noFill();
    strokeWeight(weight);
    ellipse(px,py,2*pr,2*pr);
  }
  void drawArc(int weight){
    //　3点を通る円弧で、p1,p3を両端とする円弧を描画する。
    //  3点が一直線上にあるときには線分を描画する
    //  weight : 描画線の太さ
    float px,py;
    float pr;
    px=(p1.y-p2.y)*(p3.x*p3.x-p1.x*p1.x+p3.y*p3.y-p1.y*p1.y)-(p1.y-p3.y)*(p2.x*p2.x-p1.x*p1.x+p2.y*p2.y-p1.y*p1.y);
    px/=2*(p1.x-p2.x)*(p1.y-p3.y)-2*(p1.x-p3.x)*(p1.y-p2.y);
    py=(p1.x-p3.x)*(p2.x*p2.x-p1.x*p1.x+p2.y*p2.y-p1.y*p1.y)-(p1.x-p2.x)*(p3.x*p3.x-p1.x*p1.x+p3.y*p3.y-p1.y*p1.y);
    py/=2*(p1.x-p2.x)*(p1.y-p3.y)-2*(p1.x-p3.x)*(p1.y-p2.y);
    pr=dist(px,py,p1.x,p1.y);
    //ellipse(px,py,10,10);
    stroke(0);
    noFill();
    strokeWeight(weight);
    //triangle(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y);
    if(atan2(p1.y-py,p1.x-px)<atan2(p3.y-py,p3.x-px)&&atan2(p3.y-py,p3.x-px)<atan2(p2.y-py,p2.x-px)){
      arc(px,py,2*pr,2*pr,atan2(p3.y-py,p3.x-px),2*PI+atan2(p1.y-py,p1.x-px));
    }else if(atan2(p2.y-py,p2.x-px)<atan2(p1.y-py,p1.x-px)&&atan2(p1.y-py,p1.x-px)<atan2(p3.y-py,p3.x-px)){
      arc(px,py,2*pr,2*pr,atan2(p3.y-py,p3.x-px),2*PI+atan2(p1.y-py,p1.x-px));
    }else if(atan2(p3.y-py,p3.x-px)<atan2(p2.y-py,p2.x-px)&&atan2(p2.y-py,p2.x-px)<atan2(p1.y-py,p1.x-px)){
      arc(px,py,2*pr,2*pr,atan2(p3.y-py,p3.x-px),atan2(p1.y-py,p1.x-px));
    }else if(atan2(p3.y-py,p3.x-px)<atan2(p1.y-py,p1.x-px)&&atan2(p1.y-py,p1.x-px)<atan2(p2.y-py,p2.x-px)){
      arc(px,py,2*pr,2*pr,atan2(p1.y-py,p1.x-px),2*PI+atan2(p3.y-py,p3.x-px));
    }else if(atan2(p2.y-py,p2.x-px)<atan2(p3.y-py,p3.x-px)&&atan2(p3.y-py,p3.x-px)<atan2(p1.y-py,p1.x-px)){
      arc(px,py,2*pr,2*pr,atan2(p1.y-py,p1.x-px),2*PI+atan2(p3.y-py,p3.x-px));
    }else{
      arc(px,py,2*pr,2*pr,atan2(p1.y-py,p1.x-px),atan2(p3.y-py,p3.x-px));
    }
  }
}

void setup() {
  size(1000, 1000);
  points = new Point[3];
  for (int i=0; i<points.length; i++) {
    points[i] = new Point(random(100,900), random(100,900));
  }
  circle = new CircleByThree(points[0], points[1], points[2]);
}

void draw() {
  background(255);
  for (int i=0; i<points.length; i++ ) {
    Point pt = points[i];
    pt.drawPoint(10);
  }
  circle.drawCircle(3);
  if (cursorID>=0) {
    points[cursorID].x=mouseX;
    points[cursorID].y=mouseY;
  }
}

//反転像
void GetInversion(Point src, Circle cr, Point tgt) {
  float x = src.x - cr.center.x;
  float y = src.y - cr.center.y;
  float rad = cr.radius();
  float xx = x * rad * rad / (x * x + y * y); 
  float yy = y * rad * rad / (x * x + y * y);
  tgt.x = xx + cr.center.x;
  tgt.y = yy + cr.center.y;
}

//反転像の中心点
void GetInversionCircleCenter(Circle src, Circle cr, Point tgt){
  float c_x = src.center.x - cr.center.x;
  float c_y = src.center.y - cr.center.y;
  float c_r = src.radius();
  float rad = cr.radius();
  float xx = c_x * rad * rad / (c_x * c_x + c_y * c_y - c_r * c_r); 
  float yy = c_y * rad * rad / (c_x * c_x + c_y * c_y - c_r * c_r);
  tgt.x = xx + cr.center.x;
  tgt.y = yy + cr.center.y;
}

int cursorID=-1;

void mousePressed() {
  for (int i=0; i<points.length; i++ ) {
    Point pt = points[i];
    if (dist(mouseX, mouseY, pt.x, pt.y)<20) {
      cursorID=i;
      return ;
    }
  }
}

void mouseReleased() 
{
  cursorID = -1;
}
