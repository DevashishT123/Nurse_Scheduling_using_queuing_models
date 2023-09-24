# Nurse_Scheduling_using_queuing_models

## Problem Description:
The problem at hand is nurse scheduling, where we aim to efficiently assign work shifts to both full-time and part-time nurses while satisfying several constraints and objectives. The goal is to create a schedule that meets the required nurse coverage for each shift throughout a planning period. Here's a breakdown of the problem, techniques, and some key contents:

1. ## Objective Function:
   - The primary objective is to minimize the total number of days worked by full-time nurses.
   - The objective function, represented as 'ans,' quantifies the total workload for both full-time and part-time nurses.

2. ## Decision Variables:
   - `z[i][d]` represents the work status of a full-time nurse `i` on day `d`.
   - `m[j][d]` represents the work status of a part-time nurse `j` on day `d`.
   - `x[i][d][t]` indicates whether a full-time nurse `i` works during period `t` on day `d`.
   - `y[j][d][t]` indicates whether a part-time nurse `j` works during period `t` on day `d`.

3. ## Constraints:
   -  Constraint 1 ensures that the number of full-time and part-time nurses working during a specific shift on a given day is equal to or greater than the required number (`c[d][t]`).
   -  Constraint 2 enforces that the difference in working hours between any two full-time nurses should not exceed a defined limit (`n`).
   - Constraint 3 and 4 (commented out) would have limited the maximum consecutive hours that both permanent and part-time nurses can work per day.
   - Constraint 5 restricts the number of consecutive working days for full-time nurses, ensuring they fall within the specified minimum and maximum values (`ndmin` and `ndmax`).
   - Constraint 6 and 7 deal with the absence and presence of full-time nurses on a given day, ensuring that if a nurse is present, they have worked at least one shift.
   - Constraint 8 specifies that part-time nurses can only be assigned to morning shifts.
   - Constraint 9 limits the number of days a full-time nurse can work in the planning period, adhering to the specified minimum and maximum values (`sumdmin` and `sumdmax`).
   - Constraint 10 restricts the maximum number of part-time nurses working on a given day.
   - Constraint 11 and 12 handle the absence and presence of part-time nurses on a given day, similar to constraints 6 and 7 for full-time nurses.

Key Techniques:
- ## Integer Programming: The problem is formulated as an integer programming problem using CPLEX, which is a widely-used optimization solver.
- ## Boolean Decision Variables: The use of Boolean decision variables (`z`, `m`, `x`, and `y`) to represent binary assignment decisions.
- ## Objective Function: The objective function aims to balance the workload of full-time nurses while minimizing the total number of working days.
- ## Constraints: Several constraints are employed to ensure compliance with labor regulations, shift coverage, and nurse preferences.
- ## Queuing Models: The problem incorporates nurse coverage requirements based on queuing models, specifically the M/M/c queue model, which determines the minimum number of nurses required during specific shifts.

Contents:
- The code snippet you provided represents the mathematical formulation of the nurse scheduling problem.
- It defines decision variables, objective function, and constraints to ensure a feasible and optimal nurse schedule.
- The problem takes into account both full-time and part-time nurses, their working hours, and constraints on consecutive working days.
- It aims to create a schedule that meets the required nurse coverage for each shift while minimizing the workload of full-time nurses.

The code, when executed with actual data and parameter values, would generate an optimal nurse schedule that satisfies the specified constraints and minimizes the workload of full-time nurses. This is a crucial problem in healthcare operations management to ensure that healthcare facilities are adequately staffed while considering the preferences and regulations governing nurse working hours.
