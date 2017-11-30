import java.util.*;
Grid grid;
Solver solver;
SolverSA solver_sa;
PlayButton playButton;

void setup() {
  size(1200, 1000, P2D);
  //frameRate(1);
  String grid_code = "207005010003020000654810920070300000802070401000001060045038192000050600010700805";
  grid = new Grid(grid_code,9,3,100);
  solver = new Solver(grid);
  solver_sa = new SolverSA(grid);
  playButton = new PlayButton(20,20,20);
}

void draw() {
  background(255,255,255);
  
  if(this.solver_sa.getSolved()) {
    playButton.setPlay(false);
    playButton.draw();
    this.grid.highlightValidity();
  }
  else if (playButton.getPlay()){
    background(255,255,255);
    solver_sa.run();
    playButton.draw();
    this.grid.highlightValidity();
    //this.grid.draw();
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