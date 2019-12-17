# ParetoViewer
 ParetoViewer facilitates the analysis and visualization of scenario performance in a multi-objective optimization problem.
 
## What are "Pareto optimal" or "non-dominated" solutions?
 Glad you asked! Read about it [here](https://en.wikipedia.org/wiki/Multi-objective_optimization).
 
## Data Preparation
 To use this software, you must already have a structured data-set of: 
 
### (1) Multiple Design Objectives (e.g. 'objectives.csv')

 Objective Name  |  Unit Label          |  Utopia (+1 or -1) |
 ----------------|----------------------|--------------------|
 Objective #1    |  Units 1 (e.g. kg)   |  +/- 1             |
 Objective #2    |  Units 2 (e.g. kg)   |  +/- 1             |
 ...             |  ...                 |  ...               |

 Utopia defines the directionality of a an objective's numerical benefit. 
 [e.g. for the objective "cost" where minimizing is best, use "-1"]
 [e.g. for the objective "profit" where maximizing is best, use "+1"]

### (2) Solution Scenarios with Multi-objective Performance (e.g. 'solutions.csv')

 Solution Name  |  Objective #1        |  Objective #2        |  ...
 ---------------|----------------------|----------------------|-----
 Solution A     |  Performance #1 (A)  |  Performance #2 (A)  |  ...
 Solution B     |  Performance #1 (B)  |  Performance #2 (B)  |  ...
 ...            |  ...                 |  ...                 |  ...

 Note: Performance values must be passed as numerical quantities 
 
## How to open and run .PDE files (i.e. Processing scripts):

1. Make sure you have installed the latest version of Java:  
 https://www.java.com/verify/

2. Download Processing 3:  
 https://processing.org/download/

3. Open and run "/ParetoViewer/Processing/Main/Main.pde" with Processing 3
