class Cell {
  
  int num;
  float width_len;
  
  Cell(int num, float width_len) {
    this.num = num;
    this.width_len = width_len;
  }
  
  int getNum() {
   return this.num; 
  }
  
  float getWidthLen() {
   return this.width_len; 
  }
  
  void draw(float x, float y) {
    fill(255,255,255);
    rect(x,y,this.width_len,this.width_len);
    textSize(32);
    textAlign(CENTER);
    fill(0, 102, 153, 204);
    if(this.num > 0) {
      text((int) this.num, x+(width_len*0.55), y+(width_len*0.6));
    }
    else {
      text("", x+(width_len*0.55), y+(width_len*0.6));
    }
  }
}