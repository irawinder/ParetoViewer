/**
 * An Objective is a quantifiable metric for performance.
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
private class Objective {
  
  // Name of a Quantitative Objective
  private String name;
  
  // Measurement units used for performance
  private String units;
  
  // Directionality of "good" performance:
  //   +1 = more is better (i.e. positive infinity)
  //   -1 = less is better (i.e. negative infinity)
  //    0 = performance doesn't matter
  private int utopia;
  
  // Minimum and Maximum performance for this Objective
  double min, max;
  
  /**
   * Construct an undefined Objective
   */
  public Objective() {
    
    // Default values
    this.name = "";
    this.units = "units";
    this.utopia = +1;
    this.min = Double.POSITIVE_INFINITY;
    this.max = Double.NEGATIVE_INFINITY;
  }
  
  /**
   * Sets the Name of an objective
   *
   * @param Name of a Quantitative Objective
   */
  public void setName(String name) {
    this.name = name;
  }
  
  /**
   * Gets the Name of an objective
   */
  public String getName() {
    return this.name;
  }
  
  /**
   * Sets the measurement units of the Objective
   * 
   * @param Measurement units used for performance
   */
  public void setUnits(String units) {
    this.units = units;
  }
  
  /**
   * Gets the measurement units of the Objective
   */
  public String getUnits() {
    return this.units;
  }  
  
  /**
   * Set the direction of "Utopia" for this objective (i.e. Directionality of "good" performance)
   *   +1 = more is better (i.e. positive infinity)
   *   -1 = less is better (i.e. negative infinity)
   *    0 = performance doesn't matter
   *
   *  @param utopia Direction of "Utopia" for this objective
   */
  public void setUtopia(int utopia) {
    this.utopia = utopia;
  }
  
  /**
   * Get the direction of "Utopia" for this objective (i.e. Directionality of "good" performance)
   */
  public int getUtopia() {
    return this.utopia;
  }
  
  /**
   * Get the maximum performance associated with this objective
   */
  public double getMax() {
    return this.max;
  }
  
  /**
   * Get the minimum performance associated with this objective
   */
  public double getMin() {
    return this.min;
  }
  
  public void updateMinMax(Performance indicator) {
    double value = indicator.getValue();
    if(value < min) min = value;
    if(value > max) max = value;
  }
  
  @Override
  public String toString() {
    return "Objective: " + this.name + " [" + this.units + "] [Utopia -> " + this.utopia + "] [MIN: " + this.min + "] [MAX: " + this.max + "]";
  }
}
