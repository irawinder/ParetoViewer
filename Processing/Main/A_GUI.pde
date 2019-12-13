// Index value of objectives to show on axes
int x_index, y_index;

private class Renderer {
  
  // Default indices for rendering objective on X or Y axis
  int DEFAULT_X_INDEX = 0;
  int DEFAULT_Y_INDEX = 1;
  
  // Default Colors
  color WHITE  = color(255);
  color BLACK  = color(0);
  color GREY  = color(150);
  
  public Renderer() {
    x_index = DEFAULT_X_INDEX;
    y_index = DEFAULT_Y_INDEX;
  }
  
  private void render(SolutionSet set) {
    background(WHITE);
    renderSolutionSet(set, 50, 50, 400, 400, BLACK, 3, true);
  }
  
  private void renderSolutionSet(SolutionSet set, int x, int y, int w, int h, color fill, int diameter, boolean showAxes) {
    
    pushMatrix(); translate(x, y);
    
    // Generate Parameters
    Objective x_axis = set.getObjectiveList().get(x_index);
    Objective y_axis = set.getObjectiveList().get(y_index);
    
    // Draw Axis
    noFill();
    stroke(GREY);
    rect(0, 0, w, h);
    
    // Draw Text
    fill(BLACK);
    
      // Draw x_axis label
      pushMatrix(); translate(0, 20);
        
        // Name
        pushMatrix(); translate(0.5*w, h);
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
        pushMatrix(); translate(0, 0.5*h);
        textAlign(CENTER);
        rotate(-0.5*PI);
        text(y_axis.getName() + " [" + x_axis.getUnits() + "] [Utopia -> " + x_axis.getUtopia() + "]", 0, 0);
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
      
      // Draw Solutions
      for(Solution design : set.getSetList()) {
        Performance xP = design.getIndicatorMap().get(x_axis);
        Performance yP = design.getIndicatorMap().get(y_axis);
        
        float x_pos = map( (float)xP.getValue(), (float)x_axis.getMin(), (float)x_axis.getMax(), 0, w);
        float y_pos = map( (float)yP.getValue(), (float)y_axis.getMin(), (float)y_axis.getMax(), 0, h);
        
        fill(fill); noStroke();
        circle(x_pos, y_pos, diameter);
      }
      
    popMatrix();
  }
  
  private float chop(double value, int digits) {
    return (float) Math.pow(0.1, digits) * (int)((Math.pow(10, digits) * value));
  }
}
