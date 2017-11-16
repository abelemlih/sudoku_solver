import java.util.Arrays;
Grid grid;

void setup() {
  size(1200, 1000, P2D);
  String grid_code = "530070000600195000098000060800060003400803001700020006060000280000419005000080079";
  grid = new Grid(grid_code,9,3,100);
}

void draw() {
  background(255,255,255);
  grid.draw();
}