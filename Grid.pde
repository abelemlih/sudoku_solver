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
    }
  }
  
  Cell[] getCellArray() {
    return this.cellArray;
  }
  
  void draw() {
    int index = 0;
    float y_start = 50;
    for(int i=0; i<GRID_SIZE; i++) {
      float x_start = 100;
      for (int j=0; j<GRID_SIZE ; j++) {
        cellArray[index] = new Cell(cellValues[index],CELL_WIDTH);
        strokeWeight(1);
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
  }
}