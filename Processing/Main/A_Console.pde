/**
 * Print Important Summaries and Analysis to Console
 */
private void runTests() {
  
  println("<---Begin Analysis: " + tradeSpace.getName() + "--->" + "\n");
  
  // Print Objectives
  println("   ---Objectives---");
  for(int i=0; i<kpis.length; i++) {
    println("   " + kpis[i]);
  }
  println("");
  
  // Print all Solutions
  println("   ---All Solutions---");
  println(tradeSpace);
  
  // Print Summary of Pareto Dominant Solutions
  println("   ---Pareto Frontier Solutions---");
  println(paretoFront);
  
  println("\n");
}
