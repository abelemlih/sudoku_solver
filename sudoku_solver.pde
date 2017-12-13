import java.util.*;
Grid grid;
String grid_code = "207005010003020000654810920070300000802070401000001060045038192000050600010700805";
SolverBT solver_bt;
SolverSA solver_sa;
SolverGA solver_ga;
PlayButton playButton;


void setup() {
  size(1000, 1000, P2D);
  frameRate(1);
  grid = new Grid(grid_code,9,3,100);
  solver_bt = new SolverBT();
  solver_sa = new SolverSA();
  solver_ga = new SolverGA();
  playButton = new PlayButton(500,20,20);
}

void draw() {
  background(255,255,255);
  //solver_bt.run();
  //solver_sa.run();
  solver_ga.run();
}

void mouseClicked() {
  if (this.playButton.clicked()) {
    this.playButton.resetPlay();
  }
}