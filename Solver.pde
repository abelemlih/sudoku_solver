class Solver {
  Grid grid;
  ArrayList <Cell> missing_cells;
  int current_index;
  boolean solved;
  
  Solver(Grid grid) {
    this.grid = grid;
    this.missing_cells = this.grid.getEmptyCells();
    this.current_index = 0;
    this.solved = false;
  }
  
  boolean getSolved() {
    return this.solved;
  }
  
  void run() {
    fillCell(missing_cells.get(current_index), current_index);
  }
  
  void fillCell(Cell cell, int cell_index) {
    println(cell.getIndex());
    println(cell.getNum());
    println(grid.checkCell(cell));
    if (grid.checkCell(cell)) {
      if (cell.getIndex()<80) {
        current_index = cell_index+1;
      }
      else {
        solved = true;
      }
    }
    else {
      if (cell.getNum()<9) {
        cell.setNum(cell.getNum()+1);
        current_index = cell_index;
      }
      else {
        cell.setNum(0);
        current_index = cell_index - 1;
        while(missing_cells.get(current_index).getNum()>=9) {
          missing_cells.get(current_index).setNum(0);
          current_index--;
        }
        missing_cells.get(current_index).setNum(missing_cells.get(current_index).getNum()+1);
      }
    }
    
  }
  
}