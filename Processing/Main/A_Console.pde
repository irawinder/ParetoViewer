/**
 * Print Important Summaries and Analysis to Console
 */
private void runTests() {
  
  //// Print all Solutions
  //println("---------------Begin Trade Space-----------------");
  //println(tradeSpace);
  
  // Print Summary of Pareto Dominant Solutions
  println("---------------Begin Pareto Front-----------------");
  println(paretoFront);
  
  // Print Objectives
  println("---------------Begin Objectives-----------------");
  for(int i=0; i<kpis.length; i++) {
    println(kpis[i]);
  }
  
  //// Test Performance Contests
  //Objective obj = new Objective();
  //Performance test = new Performance();
  //test.setObjective(obj);
  //Performance contestant = new Performance();
  //contestant.setObjective(obj);
  //obj.setUtopia(1);
  //test.setValue(0.5);
  //contestant.setValue(0.5);
  //println(test.contest(contestant));
}
