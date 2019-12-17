/**
 * Initialize functions
 */
private Objective[] loadObjectives(File data) {
  
  try {
    // Load data into Table
    Table objectivesTable = loadTable(data.toString(), "header");
    
    // Initialize and returnKey Performance Metrics (kpis)
    int numKPIs = objectivesTable.getRowCount();
    Objective[] objectives = new Objective[numKPIs];
    for (int i=0; i<objectives.length; i++) {
      objectives[i] = new Objective();
      objectives[i].setName(objectivesTable.getString(i, 0));
      objectives[i].setUnits(objectivesTable.getString(i, 1));
      objectives[i].setUtopia(objectivesTable.getInt(i, 2));
    }
    return objectives;
    
  } catch(Exception e) {
    println("\n!!!\nWrong File Type Detected. Check the documentation for required CSV format.\n!!!\n");
    data = null;
    return null;
  }
}

private SolutionSet loadSet(File data, Objective[] objectives) {
  
  try {
    // Store Solution Set as a table
    Table solutionsTable = loadTable(data.toString(), "header");
    
    // Populate solution set w/ solutions
    SolutionSet solutions = new SolutionSet();
    solutions.setName(data.toString());
    for (int i=0; i<solutionsTable.getRowCount(); i++) {
      Solution design = new Solution();
      
      // Extract Design Name from Table
      String name = solutionsTable.getString(i, 0);
      design.setName(name);
      
      for (int j=0; j<objectives.length; j++) {
        Performance p = new Performance();
        p.setObjective(objectives[j]);
        
        // Extract Value from Table
        double val = solutionsTable.getDouble(i, objectives[j].getName());
        p.setValue(val); // a random number between 0-100
        
        design.addIndicator(p);
        objectives[j].updateMinMax(p);
      }
      solutions.addSolution(design);
    }
    return solutions;
    
  } catch(Exception e) {
    println("\n!!!\nWrong File Type Detected. Check the documentation for required CSV format.\n!!!\n");
    data = null;
    return null;
  }
}

private Objective[] testObjectives() {
  
  // Initialize Key Performance Metrics (kpis)
  int numKPIs = 5;
  Objective[] objectives = new Objective[numKPIs];
  for (int i=0; i<objectives.length; i++) {
    objectives[i] = new Objective();
  }
  // KPI #1
  objectives[0].setName("Cost");
  objectives[0].setUnits("USD");
  objectives[0].setUtopia(-1);
  // KPI #2
  objectives[1].setName("Benefit");
  objectives[1].setUnits("utils");
  objectives[1].setUtopia(+1);
  // KPI #3
  objectives[2].setName("CO2");
  objectives[2].setUnits("tons");
  objectives[2].setUtopia(-1);
  // KPI #4
  objectives[3].setName("Duration");
  objectives[3].setUnits("days");
  objectives[3].setUtopia(-1);
  // KPI #5
  objectives[4].setName("Risk");
  objectives[4].setUnits("%");
  objectives[4].setUtopia(-1);
  
  return objectives;
}

private SolutionSet randomSet(Objective[] objectives) {
  
  // Initialize Test Solution Set
  SolutionSet testSet = new SolutionSet();
  testSet.setName("Random Set");
  
  // Populate solution set w/ solutions containing random values for KPIs
  int numDesigns = 100;
  Solution[] design = new Solution[numDesigns];
  for (int i=0; i<design.length; i++) {
    design[i] = new Solution();
    design[i].setName("Solution " + (i+1));
    for (int j=0; j<objectives.length; j++) {
      Performance p = new Performance();
      p.setObjective(objectives[j]);
      p.setValue(random(100)); // a random number between 0-100
      design[i].addIndicator(p);
      objectives[j].updateMinMax(p);
    }
    testSet.addSolution(design[i]);
  }
  
  return testSet;
}
