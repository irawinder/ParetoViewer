private SolutionSet testSet() {
  
  // Exmple Key Performance Metrics (kpis)
  int numKPIs = 5;
  Objective[] kpi = new Objective[numKPIs];
  for (int i=0; i<kpi.length; i++) {
    kpi[i] = new Objective();
  }
  
  kpi[0].setName("Cost");
  kpi[0].setUnits("USD");
  kpi[0].setUtopia(-1);
  
  kpi[1].setName("Benefit");
  kpi[1].setUnits("utils");
  kpi[1].setUtopia(+1);
  
  kpi[2].setName("CO2");
  kpi[2].setUnits("tons");
  kpi[2].setUtopia(-1);
  
  kpi[3].setName("Duration");
  kpi[3].setUnits("days");
  kpi[3].setUtopia(-1);
  
  kpi[4].setName("Risk");
  kpi[4].setUnits("%");
  kpi[4].setUtopia(-1);
  
  // Initialize Solution Set
  SolutionSet testSet = new SolutionSet();
  
  // Generate Solutions w/ Random KPIs
  int numDesigns = 100;
  Solution[] design = new Solution[numDesigns];
  for (int i=0; i<design.length; i++) {
    design[i] = new Solution();
    design[i].setName("Solution " + (i+1));
    for (int j=0; j<kpi.length; j++) {
      Performance p = new Performance();
      p.setObjective(kpi[j]);
      p.setValue(random(100));
      design[i].addIndicator(p);
      kpi[j].updateMinMax(p);
    }
    testSet.addSolution(design[i]);
  }
  
  println(testSet);
  println("--------------------------------");
  for(Objective obj : testSet.getObjectiveList()) {
    println(obj);
  }
  
  return testSet;
}
