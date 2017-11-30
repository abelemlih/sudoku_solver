class Cell {
  
  int num, index;
  float x_pos, y_pos, width_len;
  boolean highlight;
  
  Cell(int index, int num, float width_len) {
    this.index = index;
    this.num = num;
    this.width_len = width_len;
  }
  
  int getIndex() {
   return this.index; 
  }
  
  int getNum() {
   return this.num; 
  }
  
  float getWidthLen() {
   return this.width_len; 
  }
  
  void setNum(int num) {
    this.num = num;
  }
  
  void setCoordinates(float x_pos, float y_pos) {
    this.x_pos = x_pos;
    this.y_pos = y_pos;
  }
  
  void setHighlight(boolean bool) {
   this.highlight = true; 
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