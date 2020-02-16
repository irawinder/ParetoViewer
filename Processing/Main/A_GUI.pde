/**
 * Render SolutionSet() and sub-classes to a graph on a Processing Canvas
 *
 * @author Ira Winder, jiw@mit.edu, 2019
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
private class Renderer {
  
  // Default indices for rendering objective on X or Y axis
  private int DEFAULT_X_INDEX = 0;
  private int DEFAULT_Y_INDEX = 1;
  
  // Default Colors
  private color WHITE   = color(255);
  private color BLACK   = color(0);
  private color GREY    = color(150);
  private color PURPLE  = color(255, 0, 255);
  private color GREEN   = color(0, 100, 0);
  
  String APP_INFO = 
   "PARETO VIEWER [" + VERSION + "]" + "\n" +
   "Ira Winder, jiw@mit.edu, 2019";
  
  String DESCRIPTION =
   "Pareto Viewer facilitates the analysis and visualization of scenarios in a multi-objective optimization problem." + "\n" +
   "\n" + 
   "For a primer on multi-objective optimization (i.e. 'Pareto optimal' or 'non-dominated' solutions), go here:" + "\n" +
   "https://en.wikipedia.org/wiki/Multi-objective_optimization";
   
  String OBJECTIVES_DATA_FORMAT = 
   "  Objective Name, Unit Label, Utopia (+1 or -1)" + "\n" +
   "  Objective #1, Units 1 (e.g. kg), +/- 1" + "\n" +
   "  Objective #2, Units 2 (e.g. kg), +/- 1" + "\n" +
   "  ..., ..., ..." + "\n" +
   "  \n" +
   "  Utopia defines the directionality of objective's numerical benefit." + "\n" +
   "  [e.g. for the objective 'cost' where minimizing is best, use '-1']" + "\n" +
   "  [e.g. for the objective 'profit' where maximizing is best, use '+1']";
   
  String SOLUTIONS_DATA_FORMAT = 
   "  Solution Name, Objective #1, Objective #1, ..." + "\n" +
   "  Solution A, Performance #1 (A), Performance #2 (A), ..." + "\n" +
   "  Solution B, Performance #1 (B), Performance #2 (B), ..." + "\n" +
   "  ..., ..., ..., ..." + "\n" +
   "  Solution FINAL, Performance #1 (FINAL), Performance #2 (FINAL), ..." + "\n" +
   "  \n" +
   "  Note: Performance values must be passed as numerical quantities.";
   
  // Index value of objectives to show on axes
  public int x_index, y_index;

  public Renderer() {
    x_index = DEFAULT_X_INDEX;
    y_index = DEFAULT_Y_INDEX;
  }
  
  private void render(Objective[] obj, SolutionSet set1, SolutionSet set2, int MARGIN) {
    background(WHITE);
    
    int x = width/2 + MARGIN;
    int y = MARGIN;
    int w = height - 2*MARGIN;
    int h = height - 2*MARGIN;
    if (set1.getSetList().size() > 0) renderSolutionSet("", set1, x, y, w, h, BLACK, 5, true, false, true);
    if (set2.getSetList().size() > 0) renderSolutionSet("Pareto Frontier Solution", set2, x, y, w, h, PURPLE, 8, false, false, false);
    
    String objectives = "";
    String solutions = "";
    String header = APP_INFO + "\n" +
      "\n" + "---------------------" +
      "\n" + "Press 'c' to start over and/or load data" +
      "\n" + "Press 'r' to generate random data";
    String arrows = "";
    
    objectives = "Step 1: Populate Objectives";
    if (objectivesFile == null && set1.getSetList().size() == 0) {
      header += "\n\n" + DESCRIPTION;
      objectives += "\n" + "Press 'o' to load objectives from file (e.g. 'objectives.csv')" + "\n";
      objectives += "\n" + "  Example CSV Format:" + "\n" + OBJECTIVES_DATA_FORMAT;
    } else {
      objectives += " [complete]" + "\n";
      if (objectivesFile == null) {
        objectives += "Data: [hard-coded sample]" + "\n";
      } else {
        objectives += "Data: [" + objectivesFile.toString() + "]" + "\n";
      }
      for (int i=0; i<obj.length; i++) {
        objectives += "\n" + obj[i];
      }
    }
    
    if (objectivesFile != null || set1.getSetList().size() > 0 ) {
      solutions = "Step 2: Populate Solutions";
      if (solutionsFile == null && set1.getSetList().size() == 0) {
        solutions += "\n" + "Press 'l' to load solution set from file (e.g. 'designs.csv')" + "\n";
        solutions += "\n" + "  Example CSV Format:" + "\n" + SOLUTIONS_DATA_FORMAT;
      } else {
        solutions += " [complete]" + "\n";
        if (solutionsFile == null) {
          solutions += "Data: [" + tradeSpace.getSetList().size() + " random solutions]";
        } else {
          solutions += "Data: [" + solutionsFile.toString() + "]";
        }
      }
    }
    
    if(tradeSpace.getSetList().size() > 0) {
      arrows += "Step 3: Use arrow keys to change axes objectives" + "\n";
      arrows += "X-AXIS -> LEFT or RIGHT; Y-AXIS -> UP or DOWN"; 
    }
    
    textAlign(LEFT); fill(BLACK);
    text(header + "\n\n" + objectives + "\n\n" + solutions + "\n\n" + arrows, MARGIN, MARGIN/2, w, h);
  }
  
  private void renderSolutionSet(
    String label, SolutionSet set, 
    int x, int y, int w, int h, 
    color fill, int diameter, 
    boolean showAxes, boolean showPointLabel, boolean highlightLast) {
    
    pushMatrix(); translate(x, y);
    
    // Generate Parameters
    Objective x_axis, y_axis;
    if (set.getObjectiveList().size() == 0) {
      x_axis = new Objective();
      y_axis = new Objective();
    } else {
      x_axis = set.getObjectiveList().get(x_index);
      y_axis = set.getObjectiveList().get(y_index);
    }
    
    if (showAxes) {
      
      // Draw Axis
      noFill();
      stroke(GREY);
      rect(0, 0, w, h);
      
      fill(BLACK);
      
      // Draw x_axis label
      pushMatrix(); translate(0, 20);
        
        // Name
        pushMatrix(); translate(w/2, h);
        textAlign(CENTER);
        text(x_axis.getName() + " [" + x_axis.getUnits() + "] [Utopia -> " + x_axis.getUtopia() + "]", 0, 0);
        popMatrix();
        
        // Min Value
        pushMatrix(); translate(0, h);
        textAlign(LEFT);
        text("" + chop(x_axis.getMin(), 4), 0, 0);
        popMatrix();
        
        // Max Value
        pushMatrix(); translate(w, h);
        textAlign(RIGHT);
        text("" + chop(x_axis.getMax(), 4), 0, 0);
        popMatrix();
      
      popMatrix();
      
      // Draw y_axis label
      pushMatrix(); translate(-10, 0);
        
        // Name
        pushMatrix(); translate(0, h/2);
        textAlign(CENTER);
        rotate(-0.5*PI);
        text(y_axis.getName() + " [" + y_axis.getUnits() + "] [Utopia -> " + y_axis.getUtopia() + "]", 0, 0);
        popMatrix();
        
        // Min Value
        pushMatrix(); translate(0, h);
        textAlign(LEFT);
        rotate(-0.5*PI);
        text("" + chop(y_axis.getMin(), 4), 0, 0);
        popMatrix();
        
        // Max Value
        pushMatrix(); translate(0, 0);
        textAlign(RIGHT);
        rotate(-0.5*PI);
        text("" + chop(y_axis.getMax(), 4), 0, 0);
        popMatrix();
      
      popMatrix();
    }
      
    // Draw Solutions
    for(Solution design : set.getSetList()) {
      
      // Add some visual jitter to help see overlapping points
      float jit = 0.0; // pixels
      float x_pos = getX(design, x_axis, w) + random(-jit, jit);
      float y_pos = getY(design, y_axis, h) + random(-jit, jit);
      
      pushMatrix(); translate(x_pos, y_pos);
      fill(fill, 100); stroke(fill, 125);
      if (diameter > 5) {
        strokeWeight(4);
        noFill();
      }
      circle(0, 0, diameter);
      strokeWeight(1);
      textAlign(LEFT);
      if (showPointLabel) text(design.getName(), 20, random(-20, 20));
      popMatrix();
    }
    
    if(highlightLast) {
      ArrayList<Solution> all = set.getSetList();
      int final_index = all.size() - 1;
      Solution last = all.get(final_index);
      
      float x_pos = getX(last, x_axis, w);
      float y_pos = getY(last, y_axis, h);
      
      pushMatrix(); translate(x_pos , y_pos);
      noFill(); stroke(GREEN); strokeWeight(2);
      rect(- diameter, - diameter, 2*diameter, 2*diameter);
      textAlign(CENTER); fill(GREEN); strokeWeight(1);
      text("FINAL", 30, -10);
      popMatrix();
    }
    
    // Draw Label
    textAlign(LEFT);
    fill(fill, 100); 
    text(label, 2*diameter, -12);
    stroke(fill, 125);
    if (diameter > 5) {
      noFill();
      strokeWeight(3);
    }
    circle(8, -15, diameter);
    strokeWeight(1);
    
    popMatrix();
  }
  
  public float getX(Solution design, Objective x_axis, int w) {
    Performance xP = design.getIndicatorMap().get(x_axis);
    return map( (float)xP.getValue(), (float)x_axis.getMin(), (float)x_axis.getMax(), 0, w);
  }
  
  public float getY(Solution design, Objective y_axis, int h) {
    Performance yP = design.getIndicatorMap().get(y_axis);
    return map( (float)yP.getValue(), (float)y_axis.getMin(), (float)y_axis.getMax(), h, 0);
  }
    
  private float chop(double value, int digits) {
    return (float) Math.pow(0.1, digits) * (int)((Math.pow(10, digits) * value));
  }
}
