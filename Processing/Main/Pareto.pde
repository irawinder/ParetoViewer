/**
 *  Pareto() is a class that receives objects of format SolutionSet.
 *  Primary method returns a set of Pareto-dominant Solutions
 *  
 *  @author Ira Winder, jiw@mit.edu, 2019
 *
 *  For a primer on multi-objective optimization (i.e. "Pareto Optimization"), go here:
 *  https://en.wikipedia.org/wiki/Multi-objective_optimization
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
private class Pareto {

 /**
  * Constructor for the Pareto function
  */
 public Pareto() {
   
 }
 
 /**
  * Return the subset of solutions not "dominated" by any other solutions
  *
  * @param input Theoretical or Available Solution Space
  */
 public SolutionSet nonDominated(SolutionSet input) {
   SolutionSet nonDominated = new SolutionSet();
   
   // Initally assume all solutions are dominant
   ArrayList<Solution> dominant = new ArrayList<Solution>();
   for (Solution design : input.getSetList()) dominant.add(design);
   
   // Pare dominated solutions from the list
   for (Solution design : input.getSetList()) {
     for (int contestant_index = dominant.size() - 1; contestant_index >= 0; contestant_index--) {
       Solution contestant = dominant.get(contestant_index);
       if (dominates(design, contestant)) {
         dominant.remove(contestant_index);
       } 
     }
   }
   // Populate the nonDominated SolutionSet
   for (Solution design : dominant) nonDominated.addSolution(design);
   
   return nonDominated;
 }
 
 /**
  * Returns true only if design dominates contestant in all objectives
  *
  * @param design Design we would like to know the status of
  * @param contestant Design we are comparing against
  */
 private boolean dominates(Solution design, Solution contestant) {
   
   int loss = 0;
   int tie = 0;
   // If design loses to the contestant in any objective, return false
   for(Performance p : design.getIndicatorList()) {
     Objective metric = p.getObjective(); 
     Performance pContestant = contestant.getIndicatorMap().get(metric);
     if(p.getValue() == pContestant.getValue()) {
       tie++;
     } else if(!battle(p, pContestant)) {
       loss++;
     }
   }
   return (loss == 0 && tie < design.getIndicatorList().size());
 }
 
  /**
   * Hold a contest between competing performance metrics; 
   * Return win condition for indicator; indicator loses in a tie.
   *
   * @param contestant Competing Parameter
   */
  public boolean battle(Performance indicator, Performance contestant) {
    if (indicator.getObjective() != contestant.getObjective()) {
      println(contestant + " is an incompatible contestant!");
      return true;
    } else {
      if (indicator.getObjective().getUtopia() > 0) {
        return indicator.getValue() > contestant.getValue();
      } else if (indicator.getObjective().getUtopia() < 0) {
        return indicator.getValue() < contestant.getValue();
      } else {
        println("There's no contest here. Everybody wins.");
        return true;
      }
    }
  }
}
