class PlayButton {
  
  float x_pos, y_pos, width_len;
  boolean play;
  
  PlayButton(float x_pos, float y_pos, float width_len) {
   this.x_pos = x_pos;
   this.y_pos = y_pos;
   this.width_len = width_len;
   this.play = false;
  }
  
  void draw() {
    fill(119,136,153);
    if (play) {
      rect(this.x_pos, this.y_pos, this.width_len*0.4, this.width_len);
      rect(this.x_pos+(this.width_len-(this.width_len*0.4)), this.y_pos, this.width_len*0.4, this.width_len);
    } else {
      triangle(this.x_pos, this.y_pos, this.x_pos, this.y_pos+this.width_len, this.x_pos+this.width_len, this.y_pos+(this.width_len/2));
    }
  }
  
  boolean getPlay() {
   return this.play; 
  }
  
  boolean clicked() {
    return ((mouseX>= this.x_pos && mouseX <= this.x_pos+width_len) && 
            (mouseY >= this.y_pos && mouseY <= this.y_pos+width_len));
  }
  
  void setPlay(boolean bool) {
    this.play = bool;
  }
  
  void resetPlay() {
   if(this.play ) {
    this.play = false; 
   }
   else {
     this.play = true;
   }
  }
}