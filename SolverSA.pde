class SolverSA {
  Map<String, ArrayList<Cell>> rowsMap = new HashMap<String, ArrayList<Cell>>();
  boolean solved = false;
  boolean setup = false;
  double temp = 1;
  int iteration = 0;
  
  SolverSA() {
    this.solved = false;
    for (int i=0; i<9 ; i++) {
      rowsMap.put(Integer.toString(i), new ArrayList<Cell>());
    }
    
    for (Cell cell : grid.getEmptyCells()) {
      String cell_row_index = Integer.toString((int) Math.floor(cell.index/9));
      ArrayList<Cell> rowCellList = rowsMap.get(cell_row_index);
      rowCellList.add(cell);
      rowsMap.put(cell_row_index, rowCellList);
      
    }
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
    if (setup) {
      if (grid.score()==81) {
        solved = true;
      }
      else {
       Random random = new Random();
       String randow_row_num = Integer.toString(random.nextInt(9) + 0);
       ArrayList<Cell> random_row = rowsMap.get(randow_row_num);
       Collections.shuffle(random_row);
       int old_score = grid.score();
       grid.switchCells(random_row.get(0),random_row.get(1));
       if(grid.score() < old_score) {
         double u = random.nextDouble();
         if(Math.exp((grid.score()-old_score)/temp) < u)
           grid.switchCells(random_row.get(0),random_row.get(1));
       }
       print("Row Evaluated: "+randow_row_num+" ; Current Score: "+Integer.toString(grid.score())+" ; Current Temp: "+Double.toString(temp));
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
    ArrayList<Integer> values = new ArrayList<Integer>();
    int j=1;
    for (int i=0; i<row.size();i++) {
      row.get(i).setNum(j);
      while(!grid.rowValid(row.get(i))) {
        j++;
        row.get(i).setNum(j);
      }
      values.add(row.get(i).num);
      j++;
    }
    Collections.shuffle(values);
    for (int i=0; i<row.size();i++) {
      row.get(i).setNum(values.get(i));
    }
  }
  
}