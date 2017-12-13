class SolverGA {
  int POPULATION_SIZE = 100;
  float PROBABILITY_CONSTANT = 0.3;
  Map<String, ArrayList<Cell>> rowsMap = new HashMap<String, ArrayList<Cell>>();
  List<Grid> population = new ArrayList<Grid>();
  List<Grid> new_population = new ArrayList<Grid>();
  Grid top_grid;
  boolean solved = false;
  boolean setup = false;
  int iteration = 0;
  
  SolverGA() {
    this.solved = false;
    
    for (int i=0; i<100 ; i++) {
      population.add(new Grid(grid_code,9,3,100));
      new_population.add(new Grid(grid_code,9,3,100));
      for (int j=0; j<9 ; j++)
        rowsMap.put(Integer.toString(j), new ArrayList<Cell>());
      for (Cell cell : population.get(i).getEmptyCells()) {
        String cell_row_index = Integer.toString((int) Math.floor(cell.index/9));
        ArrayList<Cell> rowCellList = rowsMap.get(cell_row_index);
        rowCellList.add(cell);
        rowsMap.put(cell_row_index, rowCellList);
      }
      for (ArrayList<Cell> row : rowsMap.values())
        fillRow(row); 
    }
  }
  
  
  void run() {
    if(solved) {
      playButton.play = false;
      playButton.draw();
    }
    else if (playButton.play){
      background(255,255,255);
      step();
      playButton.draw();
    }
    else {
      playButton.draw();
    }
  }
  
  void step() {
    Collections.sort(population, new Grid(grid_code,9,3,100));
    population.get(0).prob = Math.pow(1-PROBABILITY_CONSTANT, (POPULATION_SIZE-1));
     for (int i=1; i<population.size();i++) {
       population.get(i).prob = (Math.pow(1-PROBABILITY_CONSTANT, (POPULATION_SIZE-1)-i))*PROBABILITY_CONSTANT;
     }
    Grid parent1 = randomGrid();
    Grid parent2 = randomGrid();
    Grid child1 = new Grid(grid_code,9,3,100);
    Grid child2 = new Grid(grid_code,9,3,100);
    
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
  
  Grid randomGrid() {
    double total_prob = 0;
    for (Grid g : population)
      total_prob += g.prob;
    Random random = new Random();
    double u = (random.nextDouble())*total_prob;
    double prob_sum = 0;
    for (int i=0; i<population.size(); i++) {
      prob_sum += population.get(i).prob;
      if (prob_sum >= u)
        return population.get(i);
    }
    return population.get(population.size()-1);
  }
  
  void printOrderedGrids() {
    Collections.sort(population, new Grid(grid_code,9,3,100));
    for (Grid g : new_population)
      print(g.score() + ",");
  }
  
}