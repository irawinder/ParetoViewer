/**
 * Performance is a quantity that represents a solution's ability to satisfy a particular Objective
 *
 * @author Ira Winder, jiw@mit.edu, 2019
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
private class Performance {
  
  // Objective that performance value is associated with
  private Objective metric;
  
  // Value of a scenario's performance regarding an objective
  private double value;
  
  /**
   * Contruct an undefined Performance value
   */
  public Performance() {
    this.metric = new Objective();
    this.value = 0;
  }
  
  /**
   * Set the value of a scenario's performance regarding an objective
   *
   * @param value Value of a scenario's performance regarding an objective
   */
  public void setValue(double value) {
    this.value = value;
  }
  
  /**
   * Get the value of a scenario's performance regarding an objective
   */
  public double getValue() {
    return this.value;
  }
  
  /**
   * Set the definition of the Objective to which this performance value corresponds
   *
   * @param metric Objective that performance value is associated with
   */
  public void setObjective(Objective metric) {
    this.metric = metric;
  }
  
  /**
   * Get the definition of the Objective to which this performance value corresponds
   */
  public Objective getObjective() {
    return this.metric;
  }
  
  /**
   * Hold a contest between a competing Performance Metric; win if contestant has worse score.
   *
   * @param contestant Competing Parameter
   */
  public boolean contest(Performance contestant) {
    if (metric != contestant.getObjective()) {
      println(contestant + " is an incompatible contestant!");
      return true;
    } else {
      if (metric.getUtopia() > 0) {
        return this.value < contestant.getValue();
      } else if (metric.getUtopia() < 0) {
        return this.value < contestant.getValue();
      } else {
        println("There's no contest here. Everybody wins.");
        return true;
      }
    }
  }
  
  @Override
  public String toString() {
    return "Performance [" + this.metric.getName() + "]: " + this.value + " " + this.metric.getUnits() + "; " + this.metric;
  }
}
