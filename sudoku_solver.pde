import java.util.Arrays;
Grid grid;

void setup() {
  size(1200, 1000, P2D);
  frameRate(1);
  String grid_code = "010020300004005060070000008006900070000100002030048000500006040000800106008000000";
  grid = new Grid(grid_code,9,3,100);
}

void draw() {
  background(255,255,255);
  grid.draw();
}