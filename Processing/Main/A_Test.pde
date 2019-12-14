void runTests() {
  
  // Print all Solutions
  println(tradeSpace);
  println("--------------------------------");
  
  // Print Summary of Pareto Dominant Solutions
  println(paretoFront);
  println("--------------------------------");
  
  // Print Objectives
  for(Objective obj : tradeSpace.getObjectiveList()) {
    println(obj);
  }
  println("--------------------------------");
  
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
