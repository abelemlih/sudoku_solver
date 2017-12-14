//Sudoku list:
//Easy grids:
//

import java.util.*;

String grid_code = "000000600200501009580060002007100093000000000008300061920040008300807006000000900";
Grid grid;
SolverBT solver_bt;
SolverSA solver_sa;
SolverGA solver_ga;
PlayButton playButton;


void setup() {
  size(1000, 1000, P2D);
  //frameRate(1);
  grid = new Grid(grid_code,9,3,100);
  solver_bt = new SolverBT();
  solver_sa = new SolverSA();
  solver_ga = new SolverGA();
  playButton = new PlayButton(500,20,20);
}

void draw() {
  background(255,255,255);
  solver_bt.run();
  //solver_sa.run();
  //solver_ga.run();
}

void mouseClicked() {
  if (this.playButton.clicked()) {
    this.playButton.resetPlay();
  }
}