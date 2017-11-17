class Grid {
  Cell[] cellArray;
  int[] cellValues;
  int GRID_SIZE;
  int GRID_UNIT_SIZE;
  float CELL_WIDTH;
  String GRID_CODE;
  
  Grid(String grid_code, int grid_size, int grid_unit_size, float cell_width) {
    this.GRID_CODE = grid_code;
    this.GRID_SIZE = grid_size;
    this.GRID_UNIT_SIZE = grid_unit_size;
    this.CELL_WIDTH = cell_width;
    this.cellArray = new Cell[grid_size*grid_size];
    this.cellValues = new int[grid_size*grid_size];
    for (int i=0; i<GRID_CODE.length();i++) {
      cellValues[i] = Integer.parseInt(Character.toString(GRID_CODE.charAt(i)));
      cellArray[i] = new Cell(i, cellValues[i],CELL_WIDTH);
    }
  }
  
  Cell[] getCellArray() {
    return this.cellArray;
  }
  
  boolean checkCell(Cell cell) {
    if (cell.getNum()==0)
      return true;
    
    boolean valid = true;
    //Valid by column
    for (int i = cell.getIndex()%9; i<=(cell.getIndex()%9)+72; i=i+GRID_SIZE) {
      if (cell.getIndex()!=cellArray[i].getIndex() && 
          cellArray[i].getNum()!=0 &&
          cell.getNum()==cellArray[i].getNum())
        return false;
    }
    
    //Valid by row
    int starting_row_index = (int) Math.floor(cell.getIndex()/9)*9;
    for (int i = starting_row_index; i<=starting_row_index+8; i=i+1) {
      if (cell.getIndex()!=cellArray[i].getIndex() && 
          cellArray[i].getNum()!=0 &&
          cell.getNum()==cellArray[i].getNum())
        return false;
    }
    
    //valid by grid 3*3 unit
    int starting_unit_index = (cell.getIndex()-(cell.getIndex()%3))-(((cell.getIndex()-(cell.getIndex()%3))/9)%3);
    for (int i=0; i<3; i++) {
      int start_cell_index = starting_unit_index + (9*i);
      for (int j=0; j<3; j++) {
        if (cell.getIndex()!=cellArray[start_cell_index+j].getIndex() && 
            cellArray[start_cell_index+j].getNum()!=0 &&
            cell.getNum()==cellArray[start_cell_index+j].getNum())
          return false;
      }
    }
    
    return valid;
  }
  
  void draw() {
    int index = 0;
    float y_start = 50;
    for(int i=0; i<GRID_SIZE; i++) {
      float x_start = 100;
      for (int j=0; j<GRID_SIZE ; j++) {
        strokeWeight(1);
        cellArray[index].setCoordinates(x_start, y_start);
        cellArray[index].draw(x_start, y_start);
        x_start=x_start+CELL_WIDTH;
        index++;
      }
      y_start=y_start+CELL_WIDTH;
    }
  
    y_start = 50;
    for(int i=0; i<GRID_SIZE; i = i+GRID_UNIT_SIZE) {
      float x_start = 100;
      for (int j=0; j<GRID_SIZE ; j = j+GRID_UNIT_SIZE) {
        strokeWeight(5);
        noFill();
        rect(x_start, y_start, GRID_UNIT_SIZE*CELL_WIDTH, GRID_UNIT_SIZE*CELL_WIDTH); 
        x_start=x_start+GRID_UNIT_SIZE*CELL_WIDTH;
      }
      y_start=y_start+GRID_UNIT_SIZE*CELL_WIDTH;
    }
    
    println(checkCell(cellArray[80]));
  }
}