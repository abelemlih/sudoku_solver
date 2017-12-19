import java.util.*;

String grid_code;
Grid grid;
SolverBT solver_bt;
SolverSA solver_sa;
SolverGA solver_ga;
PlayButton playButton;
long start_time;
long end_time;


void setup() {
  size(1000, 1000, P2D);
  String[] grids_list = loadStrings("sudoku_list.txt");
  ArrayList<String> grids = new ArrayList<String>();
  for (String s : grids_list) {
    if(Character.isDigit(s.charAt(0))) {
      grids.add(s.substring(0,81));
    }
  }
  grid_code = grids.get(3);
  grid = new Grid(grid_code,9,3,100);
  //solver_bt = new SolverBT();
  solver_sa = new SolverSA();
  //solver_ga = new SolverGA();
  playButton = new PlayButton(500,20,20);
  start_time = System.nanoTime();
}

void draw() {
  background(255,255,255);
  //solver_bt.run();
  solver_sa.run();
  //solver_ga.run();
}

void mouseClicked() {
  if (this.playButton.clicked()) {
    this.playButton.resetPlay();
  }
}