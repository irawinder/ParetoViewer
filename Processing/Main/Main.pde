/*  PARETO OPTIMIZER
 *  Ira Winder, jiw@mit.edu, 2019
 *  MIT Strategic Engineering Research Group
 *
 *  Pareto Optimizer facilitates the analysis and visualization of scenarios in a multi-objective 
 *  optimization problem. 
 *
 *  For a primer on multi-objective optimization (i.e. "Pareto Optimization), go here:
 *  https://en.wikipedia.org/wiki/Multi-objective_optimization
 *
 *  To use this software, you must already have a data-set of design scenarios and their multi-
 *  objective performance. For instance:
 *
 *  Solution Name  |  Objective #1        |  Objective #1        |  Objective #3        | ...
 *  -----------------------------------------------------------------------------------------
 *  Solution A     |  Performance #1 (A)  |  Performance #2 (A)  |  Performance #3 (A)  | ...
 *  Solution B     |  Performance #1 (B)  |  Performance #2 (B)  |  Performance #3 (B)  | ...
 *  ...            |  ...                 |  ...                 |  ...                 | ...
 *
 *  MIT LICENSE: Copyright 2019 Ira Winder
 *
 *    Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
 *    and associated documentation files (the "Software"), to deal in the Software without restriction, 
 *    including without limitation the rights to use, copy, modify, merge, publish, distribute, 
 *    sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is 
 *    furnished to do so, subject to the following conditions:
 *
 *    The above copyright notice and this permission notice shall be included in all copies or 
 *    substantial portions of the Software.
 *
 *    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT 
 *    NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
 *    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
 *    DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
 *    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
 
String VERSION = "v1.0-alpha.1";

// Width of Processing canvas, in pixels
int CANVAS_WIDTH  = 500;
int CANVAS_HEIGHT = 500;

SolutionSet tradeSpace;
Renderer graphic = new Renderer();

public void settings() {
  size(CANVAS_WIDTH, CANVAS_HEIGHT);
}

public void setup() {
  tradeSpace = testSet();
  graphic = new Renderer();
}

public void draw() {
  
  // render items to screen;
  graphic.render(tradeSpace);
  
  // Key Legend
  textAlign(LEFT);
  text("Use arrow keys to change axes objectives" + 
       "\n" + "Press 'r' to regenerate data"
       , 50, 20);
  
  // De-active automatic infinite loop nature of draw() method
  noLoop();
}

/**
 * Listener for interactive visualization
 */
public void keyPressed() {
  
  switch(key) {
      case 'r': // regenerate
        tradeSpace = testSet();
        loop();
        break;
  }

  // Listener for arrow-based key commands to change which objective is plotted on the graph
  if (key == CODED) {
    
    int numObjectives = tradeSpace.getObjectiveList().size();
    
    if (keyCode == UP) {
      if(y_index + 1 < numObjectives) {
        y_index++;
      } else {
        y_index = 0;
      }
    } else if (keyCode == DOWN) {
      if(y_index > 0) {
        y_index--;
      } else {
        y_index = numObjectives - 1;
      }
    } else if (keyCode == LEFT) {
      if(x_index > 0) {
        x_index--;
      } else {
        x_index = numObjectives - 1;
      }
    } else if (keyCode == RIGHT) {
      if(x_index + 1 < numObjectives) {
        x_index++;
      } else {
        x_index = 0;
      }
    } 
  }
  loop();
}
