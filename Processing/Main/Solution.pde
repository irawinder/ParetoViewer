/**
 * Solution is a collection of indicators representing the total 
 * performance of a particular design option
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
 public class Solution {
  
  // Name of Solution
  private String name;
  
  // dictionaries of performance indicators associated with a solution
  private HashMap<String, Performance> indicatorMap;
  private ArrayList<Performance> indicatorList;
  
  /**
   * Construct an undefined Solution
   */
  public Solution() {
    this.name = "";
    this.indicatorMap = new HashMap<String, Performance>();
    this.indicatorList = new ArrayList<Performance>();
  }
  
  /**
   * Set the Name of the Solution
   *
   * @param name Name of Solution
   */
  public void setName(String name) {
    this.name = name;
  }
  
  /**
   * Get the Name of the Solution
   */
  public String getName() {
    return this.name;
  }
  
  /**
   * Add a Performance Indicator to the dictionaries indicators associated with this solution
   *
   * @param indicator Quantity that represents a solution's ability to satisfy a particular Objective
   */
  public void addIndicator(Performance indicator) {
    String indicatorName = indicator.getObjective().getName();
    this.indicatorMap.put(indicatorName, indicator);
    this.indicatorList.add(indicator);
  }
  
  /**
   * Get a HashMap dictionary of Performance Indicators associated with this solution
   */
  public HashMap<String, Performance> getIndicatorMap() {
    return this.indicatorMap;
  }
  
  /**
   * Get an ArrayList of Performance Indicators associated with this solution
   */
  public ArrayList<Performance> getIndicatorList() {
    return this.indicatorList;
  }
  
  @Override
  public String toString() {
    String tS = "Solution: " + this.name;
    for (Performance p : this.indicatorList) tS += "\n" + p;
    return tS;
  }
}
