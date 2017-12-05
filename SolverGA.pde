class SolverGA {
  int POPULATION_SIZE = 100;
  float PROBABILITY_CONSTANT = 0.3;
  Map<String, ArrayList<Cell>> rowsMap = new HashMap<String, ArrayList<Cell>>();
  Map<String, Float> probabilityMap = new HashMap<String, Float>();
  Grid[] population = new Grid[POPULATION_SIZE];
  Grid top_grid;
  boolean solved = false;
  boolean setup = false;
  int iteration = 0;
  
  SolverGA() {
    this.solved = false;
    
    for (int i=0; i<100 ; i++) {
      population[i] = new Grid(grid_code,9,3,100);
      for (int j=0; j<9 ; j++)
        rowsMap.put(Integer.toString(j), new ArrayList<Cell>());
      for (Cell cell : population[i].getEmptyCells()) {
        String cell_row_index = Integer.toString((int) Math.floor(cell.index/9));
        ArrayList<Cell> rowCellList = rowsMap.get(cell_row_index);
        rowCellList.add(cell);
        rowsMap.put(cell_row_index, rowCellList);
      }
      for (ArrayList<Cell> row : rowsMap.values())
        fillRow(row);
    }
    top_grid = population[fittestGridIndex()];
  }
  
  
  void run() {
    if(solved) {
      playButton.play = false;
      playButton.draw();
      top_grid.draw();
    }
    else if (playButton.play){
      background(255,255,255);
      step();
      playButton.draw();
      top_grid.draw();
    }
    else {
      playButton.draw();
      top_grid.draw();
    }
  }
  
  void step() {
    if (setup) {
      
      
    }
    else {
      setup = true;
    }
  }
  
  int fittestGridIndex() {
   int fittest_grid_index = 0;
   for (int i=0; i<population.length; i++) {
     if(population[i].score() > population[fittest_grid_index].score())
       fittest_grid_index = i;
   }
   return fittest_grid_index;
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