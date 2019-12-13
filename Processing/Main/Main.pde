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
int CANVAS_WIDTH  = 1000;
int CANVAS_HEIGHT = 1000;

// Default indices for rendering objective on X or Y axis
int DEFAULT_X_INDEX = 0;
int DEFAULT_Y_INDEX = 0;

color WHITE  = color(255);

SolutionSet tradeSpace;

public void settings() {
  size(CANVAS_WIDTH, CANVAS_HEIGHT);
}

public void setup() {
  tradeSpace = testSet();
}

public void draw() {
  
  // render items to screen;
  render();
  
  // De-active automatic infinite loop nature of draw() method
  noLoop();
}

private void render() {
  background(WHITE);
}

private void renderSolutionSet(SolutionSet set, int x, int y, int w, int h, color fill, int stroke) {
  
}
