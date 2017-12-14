class SolverBT {
  ArrayList <Cell> missing_cells;
  int current_index;
  boolean solved;
  
  SolverBT() {
    this.missing_cells = grid.getEmptyCells();
    this.current_index = 0;
    this.solved = false;
  }
  
  boolean getSolved() {
    return this.solved;
  }
  
  void run() {
    if(solved) {
      end_time = System.nanoTime();
      print("Start time: "+start_time+" ; end time: "+end_time);
      playButton.play = false;
      playButton.draw();
      grid.draw();
    }
    else if (playButton.play){
      background(255,255,255);
      step();
      playButton.draw();
      grid.draw();
    }
    else {
      playButton.draw();
      grid.draw();
    }
  }
  
  
  void step() {
    fillCell(missing_cells.get(current_index), current_index);
  }
  
  void fillCell(Cell cell, int cell_index) {
    if (grid.checkCell(cell)) {
      if (current_index<=missing_cells.size()-2) {
        current_index = cell_index+1;
      }
      else {
        solved = true;
      }
    }
    else {
      if (cell.num<9) {
        cell.setNum(cell.getNum()+1);
        current_index = cell_index;
      }
      else {
        cell.setNum(0);
        current_index = cell_index - 1;
        while(missing_cells.get(current_index).num>=9) {
          missing_cells.get(current_index).setNum(0);
          current_index--;
        }
        missing_cells.get(current_index).setNum(missing_cells.get(current_index).num+1);
      }
    }
    
  }
  
}