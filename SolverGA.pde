class SolverGA {
  int POPULATION_SIZE = 200;
  Map<String, ArrayList<Cell>> rowsMap = new HashMap<String, ArrayList<Cell>>();
  List<Grid> population = new ArrayList<Grid>();
  List<Grid> new_population = new ArrayList<Grid>();
  Grid top_grid;
  boolean solved = false;
  boolean setup = false;
  int iteration = 0;
  Random random = new Random();
  int max_grid_score;
  
  SolverGA() {
    this.solved = false;
    
    for (int i=0; i<POPULATION_SIZE ; i++) {
      population.add(new Grid(grid_code,9,3,100));
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
    Collections.sort(population, new Grid(grid_code,9,3,100));
    max_grid_score = population.get(POPULATION_SIZE-1).score();
    println("Initial Fittest Grid Score: " + population.get(POPULATION_SIZE-1).score() + " ; Max Grid Score: " + max_grid_score);
  }
  
  
  void run() {
    if(solved) {
      playButton.play = false;
      playButton.draw();
      population.get(POPULATION_SIZE-1).draw();
    }
    else if (playButton.play){
      background(255,255,255);
      step();
      playButton.draw();
      population.get(POPULATION_SIZE-1).draw();
    }
    else {
      playButton.draw();
      population.get(POPULATION_SIZE-1).draw();
    }
  }
  
  void step() {
    
    Collections.sort(population, new Grid(grid_code,9,3,100));
    for (int i=0; i<POPULATION_SIZE;i++) {
      population.get(i).prob = ((float) population.get(i).score())/((float) totalFitness());
    }
    
    while(new_population.size() <= population.size()-2) {
      Grid child1 = randomGrid();
      Grid child2 = randomGrid();
      if(random.nextFloat() <= 0.5)
        crossoverGrids(child1, child2);
      if(random.nextFloat() <= 0.1)
        mutateGrid(child1);
      if(random.nextFloat() <= 0.1)
        mutateGrid(child2);
      new_population.add(child1);
      new_population.add(child2);
    }
    
    for (int i=0; i<POPULATION_SIZE;i++) {
      population.set(i, new_population.get(i));
    }
    
    Collections.sort(population, new Grid(grid_code,9,3,100));
    println("Fittest Grid Score: " + population.get(POPULATION_SIZE-1).score() + " ; Max Grid Score: " + max_grid_score);
    if(population.get(POPULATION_SIZE-1).score()==81)
      solved = true;
    else if (population.get(POPULATION_SIZE-1).score() > max_grid_score)
      max_grid_score = population.get(POPULATION_SIZE-1).score();
    new_population.clear();
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
    Grid child = new Grid(grid_code,9,3,100);
    float random_prob = (random.nextFloat());
    float prob_sum = 0;
    for (int i=0 ; i< POPULATION_SIZE ; i++) {
      prob_sum += population.get(i).prob;
      if (prob_sum >= random_prob) {
        child.cellArray = population.get(i).cellArray;
        return child;
      }
    }
    return child;
  }
  
  void crossoverGrids(Grid g1, Grid g2) {
    int random_starting_index = random.nextInt(9)*9;
    for (int i=random_starting_index; i<random_starting_index+9; i++) {
      Cell switch_cell = g1.cellArray[i];
      g1.cellArray[i] = g2.cellArray[i];
      g2.cellArray[i] = switch_cell;
    }
  }
  
  void mutateGrid(Grid g) {
    Grid clean_grid = new Grid(grid_code,9,3,100);
    for (int j=0; j<9 ; j++) {
      rowsMap.put(Integer.toString(j), new ArrayList<Cell>());
    }
   
   for (Cell cell : clean_grid.getEmptyCells()) {
     String cell_row_index = Integer.toString((int) Math.floor(cell.index/9));
     ArrayList<Cell> rowCellList = rowsMap.get(cell_row_index);
     rowCellList.add(cell);
     rowsMap.put(cell_row_index, rowCellList);
   }
   
   int random_row = random.nextInt(9);
   fillRow(rowsMap.get(Integer.toString(random_row)));
   for (Cell c : rowsMap.get(Integer.toString(random_row))) {
     g.cellArray[c.index] = c;
   }
  }
  
  int totalFitness() {
    int x = 0;
    for (Grid g : population)
      x += g.score();
    return x;
  }
  
  void printOrderedGrids() {
    Collections.sort(population, new Grid(grid_code,9,3,100));
    for (Grid g : new_population)
      print(g.score() + ",");
  }
  
}