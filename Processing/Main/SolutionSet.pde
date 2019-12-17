/**
 * SolutionSet is a collection of multiple htpothetical solutions 
 * generated to solve a multi-objective problem.
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
public class SolutionSet {
  
  // Name of a particular set of solutions
  private String name;
  
  // dictionaries of solution set
  private HashMap<String, Solution> setMap;
  private ArrayList<Solution> setList;
  
  // dictionaries of objectives
  private HashMap<String, Objective> objectiveMap;
  private ArrayList<Objective> objectiveList;
  
  /**
   * Construct and empty SolutionSet
   */
  public SolutionSet() {
    this.name = "";
    this.setMap = new HashMap<String, Solution>();
    this.setList = new ArrayList<Solution>();
    this.objectiveMap = new HashMap<String, Objective>();
    this.objectiveList = new ArrayList<Objective>();
  }
  
  /**
   * Set the Name of a particular set of solutions
   *
   * @param name Name of a particular set of solutions
   */
  public void setName(String name) {
    this.name = name;
  }
  
  /**
   * Get the Name of a particular set of solutions
   */
  public String getName() {
    return this.name;
  }
  
  /**
   * Add a Solution to the dictionary of indicators associated with this set of solutions
   *
   * @param design Solution containing a collection of indicators representing the total performance of a particular design option
   */
  public void addSolution(Solution design) {
    String designName = design.getName();
    this.setMap.put(designName, design);
    this.setList.add(design);
    
    // Update lists of objectives for this solution set
    for(Performance p : design.getIndicatorList()) {
      if(objectiveMap.get(p.getObjective().getName()) == null) {
        addObjective(p.getObjective());
      }
    }
  }
  
  /**
   * Get a HashMap dictionary of Solutions
   */
  public HashMap<String, Solution> getSetMap() {
    return this.setMap;
  }
  
  /**
   * Get an ArrayList of Solutions
   */
  public ArrayList<Solution> getSetList() {
    return this.setList;
  }
  
  /**
   * Add an Objective associated with this set of solutions
   *
   * @param metric Objective associated with a particular solution set
   */
  private void addObjective(Objective metric) {
    String metricName = metric.getName();
    this.objectiveMap.put(metricName, metric);
    this.objectiveList.add(metric);
  }
  
  /**
   * Get a HashMap dictionary of Objectives
   */
  public HashMap<String, Objective> getObjectiveMap() {
    return this.objectiveMap;
  }
  
  /**
   * Get an ArrayList of Objectives
   */
  public ArrayList<Objective> getObjectiveList() {
    return this.objectiveList;
  }
  
  @Override
  public String toString() {
    String tS = "";
    for (Solution design : this.setList) tS += "   " + design + "\n";
    return tS;
  }
}
