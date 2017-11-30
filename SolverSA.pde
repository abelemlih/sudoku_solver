class SolverSA {
  Grid grid;
  Map<String, ArrayList<Cell>> rowsMap = new HashMap<String, ArrayList<Cell>>();
  boolean solved = false;
  boolean setup = false;
  double temp = 1;
  int iteration = 0;
  
  SolverSA(Grid grid) {
    this.grid = grid;
    this.solved = false;
    for (int i=0; i<9 ; i++) {
      rowsMap.put(Integer.toString(i), new ArrayList<Cell>());
    }
    
    for (Cell cell : grid.getEmptyCells()) {
      String cell_row_index = Integer.toString((int) Math.floor(cell.getIndex()/9));
      ArrayList<Cell> rowCellList = rowsMap.get(cell_row_index);
      rowCellList.add(cell);
      rowsMap.put(cell_row_index, rowCellList);
      
    }
  }
  
  boolean getSolved() {
    return this.solved;
  }
  
  void run() {
    if (setup) {
      if (grid.getScore()==81) {
        solved = true;
      }
      else {
       Random random = new Random();
       String randow_row_num = Integer.toString(random.nextInt(9) + 0);
       ArrayList<Cell> random_row = rowsMap.get(randow_row_num);
       Collections.shuffle(random_row);
       int old_score = grid.getScore();
       grid.switchCells(random_row.get(0),random_row.get(1));
       if(grid.getScore() < old_score) {
         double u = random.nextDouble();
         if(Math.exp((grid.getScore()-old_score)/temp) < u)
           grid.switchCells(random_row.get(0),random_row.get(1));
       }
       print("Row Evaluated: "+randow_row_num+" ; Current Score: "+Integer.toString(grid.getScore())+" ; Current Temp: "+Double.toString(temp));
       temp = temp*0.9999;
      }
      print(" ; iteration: "+Integer.toString(iteration)+"\n");
      iteration++;
    }
    else {
      for (ArrayList<Cell> row : rowsMap.values())
        fillRow(row);
      setup = true;
    }
  }
  
  void fillRow(ArrayList<Cell> row) {
    for (Cell cell: row) {
      int i = 1;
      cell.setNum(i);
      while(!grid.rowValid(cell)) {
        i++;
        cell.setNum(i);
      }
    }
  }
  
}