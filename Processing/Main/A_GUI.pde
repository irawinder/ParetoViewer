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
  
  // Index value of objectives to show on axes
  public int x_index, y_index;

  public Renderer() {
    x_index = DEFAULT_X_INDEX;
    y_index = DEFAULT_Y_INDEX;
  }
  
  private void render(SolutionSet set1, SolutionSet set2, int x, int y, int w, int h) {
    background(WHITE);
       
    renderSolutionSet("", set1, x, y, w, h, BLACK, 3, true, false);
    renderSolutionSet("Non-Dominated Solutions", set2, x, y, w, h, PURPLE, 4, false, false);
    
    String data = "Data: ";
    if (tradeSpace.getSetList().size() == 0) {
      data += "\n" + "[no data]";
    } else if (solutionsFile == null) {
      data += "\n" + "[random data with random objectives]";
    } else {
      data += "\n" + "[" + solutionsFile.toString() + "]";
    }
    
    String objectives = "Objectives: ";
    for (int i=0; i<kpis.length; i++) {
      objectives += "\n" + kpis[i];
    }
    
    String keyLegend = "Controls:" +
       "\n" + "Use arrow keys to change axes objectives" + 
       "\n" + "Press 'r' to generate random data" +
       "\n" + "Press 'o' to load objectives from file" +
       "\n" + "Press 'l' to load solution set from file";
    
    textAlign(LEFT); fill(BLACK);
    text(data + "\n\n" + keyLegend + "\n\n" + objectives, 50, 20);
  }
  
  private void renderSolutionSet(String label, SolutionSet set, int x, int y, int w, int h, color fill, int diameter, boolean showAxes, boolean showPointLabel) {
    
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
        text("" + chop(x_axis.getMin(), 3), 0, 0);
        popMatrix();
        
        // Max Value
        pushMatrix(); translate(w, h);
        textAlign(RIGHT);
        text("" + chop(x_axis.getMax(), 3), 0, 0);
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
        text("" + chop(y_axis.getMin(), 3), 0, 0);
        popMatrix();
        
        // Max Value
        pushMatrix(); translate(0, 0);
        textAlign(RIGHT);
        rotate(-0.5*PI);
        text("" + chop(y_axis.getMax(), 3), 0, 0);
        popMatrix();
      
      popMatrix();
    }
      
    // Draw Solutions
    for(Solution design : set.getSetList()) {
      Performance xP = design.getIndicatorMap().get(x_axis);
      Performance yP = design.getIndicatorMap().get(y_axis);
      
      float x_pos = map( (float)xP.getValue(), (float)x_axis.getMin(), (float)x_axis.getMax(), 0, w);
      float y_pos = map( (float)yP.getValue(), (float)y_axis.getMin(), (float)y_axis.getMax(), h, 0);
      
      pushMatrix(); translate(x_pos, y_pos);
      fill(fill); noStroke();
      circle(0, 0, diameter);
      textAlign(LEFT);
      if (showPointLabel) text(design.getName(), 20, random(-20, 20));
      popMatrix();
    }
    
    // Draw Label
    textAlign(LEFT);
    fill(fill, 100);
    text(label, 5, 15);  
      
    popMatrix();
  }
  
  private float chop(double value, int digits) {
    return (float) Math.pow(0.1, digits) * (int)((Math.pow(10, digits) * value));
  }
}
