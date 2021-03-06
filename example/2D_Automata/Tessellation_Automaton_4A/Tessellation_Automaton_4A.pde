import rules.*;
import cellery.*;
import topology.*;



int cellSize;
int gridWidth;
int gridHeight;
/**
*Tesselation automata are machines that fill a space. Cell Death can be on or off, but in this example it is off.
This is also an example of how to switch topologies during the evolution of the automaton.
To create any 2D automaton, using Cellery we must declare and specify the 3 elements of an 
*Automaton: The underlying space that the automaton lives in, the topology on that space and
*finally the rule that governs the automaton. 
**/
Topology2D topoEven;
Topology2D topoOdd;
CellArray2D cells;
Rule rule;
/**
*These three elements determine the behavior of the Automaton
**/
BinaryAutomaton2D ca;

int[][] grid;


void setup(){
   size(1000, 600, JAVA2D);
    noStroke();
    background(0, 0, 0);
    
    //Dimension of the square shaped cell
    cellSize = 3;
    
    //setup grid geometry
    gridWidth = width / cellSize;
    gridHeight = height / cellSize;
    
    //Create a r
    int[] B = {3,4,5,6};
    //including each ordianl in the cardinality of the topology's neighborhood insures Cell Death is turned off
    int[] S = {1,2,3,4,5,6,7,8,9,10};
    rule = new Rule(B, S);
    
    //Seed the grid with a random initial state
    grid = CellerySeeds.mixed(gridHeight, gridWidth);
    
    //Create a topology on the ca's space for even steps.
    topoEven = new Topology2D(Topology2D.Base.VON_NEUMANN, 2, Topology2D.Space.TOR);
    //Create a CellArray with the correct topology and seeded initial state
    cells = new CellArray2D(grid, topoEven);
    
    ca = new BinaryAutomaton2D(cells, rule);
    
}
void draw(){
  drawStep2D(ca);
}

public void drawStep2D(Automaton2D ca) {
  int t = ca.step();
  // Iterate down each row of pixels
  for (int i = 0; i < gridHeight; i++) {
    // Iterate across each column in a row
    for (int j = 0; j < gridWidth; j++) {
      // Color Settings.
      ca.getCell(i, j).setAliveColor(
          (int) (255 * sin(PI / 1028 * t)),
          (int) (200 * cos(PI / 1028 * t)),
          (int) (185 * sin(PI / 512 * t)));
      ca.getCell(i, j).setDeadColor(0,0,0);
      if (ca.getCell(i, j).isAlive())
        fill(ca.getCell(i, j).getAliveColor());
      else
        fill(ca.getCell(i, j).getDeadColor());
      rect(cellSize * (j), cellSize * (i), cellSize, cellSize);

    }
  }
   ca.iterate();
}
