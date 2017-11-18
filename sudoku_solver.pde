import java.util.*;
Grid grid;
Solver solver;
PlayButton playButton;

void setup() {
  size(1200, 1000, P2D);
  //frameRate(9);
  String grid_code = "010020300004003020050000006007800050000100002080042000300007040000600807006000000";
  grid = new Grid(grid_code,9,3,100);
  solver = new Solver(grid);
  playButton = new PlayButton(20,20,20);
}

void draw() {
  background(255,255,255);
  
  if(this.solver.getSolved()) {
    playButton.setPlay(false);
    playButton.draw();
    this.grid.highlightValidity();
  }
  else if (playButton.getPlay()){
    background(255,255,255);
    solver.run();
    playButton.draw();
    this.grid.draw();
  }
  else {
    playButton.draw();
    this.grid.draw();
  }
}

void mouseClicked() {
  if (this.playButton.clicked()) {
    this.playButton.resetPlay();
  }
}