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
 *  objective performance to load into "solutionFile". For instance:
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
 
String VERSION = "v1.0-alpha.3";

// Width of Processing canvas, in pixels
int CANVAS_WIDTH  = 500;
int CANVAS_HEIGHT = 750;

File objectivesFile;
File solutionsFile;

Objective[] kpis;
SolutionSet tradeSpace;
SolutionSet paretoFront;
Pareto pareto;
Renderer canvas;

public void settings() {
  size(CANVAS_WIDTH, CANVAS_HEIGHT);
}

public void setup() {
  
  // Initialize the Pareto Analyzer Class
  pareto = new Pareto();
  
  // Initialize Canvas Renderer
  canvas = new Renderer();
  
  // Create and Analyze an empy solution set
  kpis = new Objective[0];
  tradeSpace = new SolutionSet();
  paretoFront = pareto.nonDominated(tradeSpace);
}

public void draw() {
  
  // render items to screen;
  canvas.render(tradeSpace, paretoFront, 50, 300, 400, 400);
  
  // Run and Print Tests to console
  runTests();
  
  // De-activate automatic infinite loop nature of draw() method
  noLoop();
}

/**
 * Listener for interactive visualization
 */
public void keyPressed() {
  
  switch(key) {
      case 'c': // clear
        objectivesFile = null;
        solutionsFile = null;
        kpis = new Objective[0];
        tradeSpace = new SolutionSet();
        paretoFront = pareto.nonDominated(tradeSpace);
        break;
      case 'r': // random solution set
        solutionsFile = null;
        kpis = testObjectives();
        tradeSpace = randomSet(kpis);
        paretoFront = pareto.nonDominated(tradeSpace);
        break;
      case 'o': // load objectives from file
        selectInput("Select an objectives file:", "objectivesFileSelected");
        break;
      case 'l': // load solutions file
        selectInput("Select a solution set file:", "solutionsFileSelected");
        break;
  }

  // Listener for arrow-based key commands to change which objective is plotted on the graph
  if (key == CODED) {
    
    int numObjectives = tradeSpace.getObjectiveList().size();
    
    if (keyCode == UP) {
      if(canvas.y_index + 1 < numObjectives) {
        canvas.y_index++;
      } else {
        canvas.y_index = 0;
      }
    } else if (keyCode == DOWN) {
      if(canvas.y_index > 0) {
        canvas.y_index--;
      } else {
        if (numObjectives > 0) canvas.y_index = numObjectives - 1;
      }
    } else if (keyCode == LEFT) {
      if(canvas.x_index > 0) {
        canvas.x_index--;
      } else {
        if (numObjectives > 0) canvas.x_index = numObjectives - 1;
      }
    } else if (keyCode == RIGHT) {
      if(canvas.x_index + 1 < numObjectives) {
        canvas.x_index++;
      } else {
        canvas.x_index = 0;
      }
    } 
  }
  loop();
}

void objectivesFileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    objectivesFile = selection;
    kpis = loadObjectives(objectivesFile);
  }
  loop();
}

void solutionsFileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    solutionsFile = selection;
    tradeSpace = loadSet(solutionsFile, kpis);
    paretoFront = pareto.nonDominated(tradeSpace);
  }
  loop();
}
