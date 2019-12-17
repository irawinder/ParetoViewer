/*  PARETO VIEWER
 *  Ira Winder, jiw@mit.edu, 2019
 *  MIT Strategic Engineering Research Group
 *
 *  Pareto Viewer facilitates the analysis and visualization of scenarios in a multi-objective 
 *  optimization problem. 
 *
 *  For a primer on multi-objective optimization (i.e. "Pareto optimal" or "non-dominated" solutions), go here:
 *  https://en.wikipedia.org/wiki/Multi-objective_optimization
 *
 *  To use this software, you must already have a CSV data-set of: 
 *
 *  (1) Multiple Design Objectives
 *
 *  Objective Name  |  Unit Label          |  Utopia (+1 or -1)  |
 *  ----------------|----------------------|---------------------|
 *  Objective #1    |  Units 1 (e.g. kg)   |  +/- 1              |
 *  Objective #2    |  Units 2 (e.g. kg)   |  +/- 1              |
 *  ...             |  ...                 |  ...                |
 *
 *  Utopia defines the directionality of a an objective's numerical benefit. 
 *  [e.g. for the objective "cost" where minimizing is best, use "-1"]
 *  [e.g. for the objective "profit" where maximizing is best, use "+1"]
 *
 *  (2) Solution Scenarios with Multi-objective Performance
 *
 *  Solution Name  |  Objective #1        |  Objective #1        |  ...
 *  ---------------|----------------------|----------------------|-----
 *  Solution A     |  Performance #1 (A)  |  Performance #2 (A)  |  ...
 *  Solution B     |  Performance #1 (B)  |  Performance #2 (B)  |  ...
 *  ...            |  ...                 |  ...                 |  ...
 *
 *  Note: Performance values must be passed as numerical quantities
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

String VERSION = "v1.0-alpha.4";
 
// Width of Processing canvas, in pixels
int DEFAULT_CANVAS_WIDTH  = 500;
int DEFAULT_CANVAS_HEIGHT = 900;
int MARGIN = 50;

File objectivesFile;
File solutionsFile;

Objective[] kpis;
SolutionSet tradeSpace;
SolutionSet paretoFront;
Pareto pareto;
Renderer canvas;

public void settings() {
  size(DEFAULT_CANVAS_WIDTH, DEFAULT_CANVAS_HEIGHT);
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
  canvas.render(kpis, tradeSpace, paretoFront, MARGIN, height - width + MARGIN, width - 2*MARGIN, width - 2*MARGIN);
  
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
        objectivesFile = null;
        solutionsFile = null;
        kpis = testObjectives();
        tradeSpace = randomSet(kpis);
        paretoFront = pareto.nonDominated(tradeSpace);
        break;
      case 'o': // load objectives from file
        if (objectivesFile == null && tradeSpace.getSetList().size() == 0) {
          selectInput("Select an objectives file:", "objectivesFileSelected");
        }
        break;
      case 'l': // load solutions file
        if (objectivesFile != null) {
          selectInput("Select a solution set file:", "solutionsFileSelected");
        } else {
          println("You must select an objectives file first");
        }
        break;
  }

  // Listener for arrow-based key commands to change which objective is plotted on the graph
  if (key == CODED) {
    
    int numObjectives = kpis.length;
    
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
