/*********************************************
 * OPL 12.5 Model
 * Author: TDL
 * Creation Date: 05-Apr-2023 at 2:36:44 PM
 *********************************************/
//Number of Permanent Nurses
int pn = ...;
//Number of Part Time Nurses
int ptn = ...;
//Number of days in the planning period 
int days = ...;
//Number of shifts on a particular day 
int time = ...;
//A very large constant
float M = 1e9;

//Respective ranges for the same
range perm_nurse = 1..pn;
range part_nurse = 1..ptn;
range day = 1..days;
range period = 1..time;

//Minimum number of nurses required on a particular days' specific period
//This is calculated from the queuing model -- M/M/c
int c[day][period] = ...;
//Maximum number of time shifts for which a nurse can continuously work everyday
int nt = ...;
//Minimum and Maximum number of days, respectively, for which a full-time nurse can work continuously during a given roster period
int ndmin = ...;
int ndmax = ...;

//-----------------------------------------------------------------------------
//Decision Variables


//z[i][d] --> Work status of a full-time nurse i on day d
dvar boolean z[perm_nurse][day];
//m[j][d] --> Work status of a part-time nurse j on day d
dvar boolean m[part_nurse][day];
//x[i][d][t] --> indicates whether a full-time nurse i works during period t on day d
dvar boolean x[perm_nurse][day][period];
//y[j][d][t] --> indicates whether a part-time nurse j works during period t on day d
dvar boolean y[part_nurse][day][period];
//Maximum number of part-time nurses working on a given day
int npart_nurse = ...;
//Minimum and maximum number of days worked by a full-time nurse during one roster period, respectively
int sumdmin = ...;
int sumdmax = ...;

//Maximum number of difference 
int n = ...;

//Objective Function
//Minimizing the number of days worked by full-time nurses given that the total number of hours worked by all nurses is minimized
dexpr int ans = (sum(i in perm_nurse, d in day) z[i][d]) + (sum(i in perm_nurse, d in day, t in period) x[i][d][t]) + (sum(j in part_nurse, d in day, t in period) y[j][d][t]);


//Constraints-->

subject to{
  //Number of part-time + permanent nurse on a given shift should be greater than the required number
  constraint1:
  forall(d in day, t in period) (sum(i in perm_nurse) x[i][d][t]) + (sum(j in part_nurse) y[j][d][t]) >= c[d][t];
  
  //Ensuring there is no considerable difference in the working hours of two permanent nurse in the planning period
  constraint2:
  forall(i, j in perm_nurse : i != j){
    abs((sum(d in day, t in period) x[i][d][t]) - (sum(d in day, t in period) x[j][d][t])) <= n;
  }
  
  //Limiting the maximum number of consecutive hours for which the nurses work per day
  
//  //For permanent nurses
//  constraint3:
//  forall(i in perm_nurse, d in day, k in 1..days-nt) sum(t in k..k+nt) x[i][d][t] <= nt;
//  
//  //For part time nurses
//  constraint4:
//  forall(i in part_nurse, d in day, k in 1..days-nt) sum(t in k..k+nt) y[i][d][t] <= nt;
  
  //Enforcing the the maximum and minimum number of consecutive working days for each full-time nurse
  constraint5:
  forall(i in perm_nurse) sum(d in day) z[i][d] <= ndmax;
  forall(i in perm_nurse) sum(d in day) z[i][d] >= ndmin;
  
  //If z[i][d] == 0, then, no work in all shifts on that day by a permanent nurse, i.e she is absent on that day.
  constraint6:
  forall(i in perm_nurse, d in day) M*z[i][d] >= sum(t in period) x[i][d][t];
  
  //If a permanent nurse is present on a day, then, she has worked in atleast 1 shift on that day
  constraint7:
  forall(i in perm_nurse, d in day) M*(z[i][d] - 1) + 1 <= sum(t in period) x[i][d][t];
  
  //Part Time Nurses can only be assigned in the two morning shifts, because that is only the rush hour
  constraint8:
  forall(i in part_nurse, d in day) y[i][d][time] == 0;
  
  //Enforcing the minimum nd maximum number of days, a permanent nurse can work in a planning period
  constraint9:
  forall(i in perm_nurse) sum(d in day) z[i][d] <= sumdmax;
  forall(i in perm_nurse) sum(d in day) z[i][d] >= sumdmin;
  
  //Limiting the maximum number of part time nurses working on a given day
  constraint10:
  forall(d in day) sum(i in part_nurse) m[i][d] <= npart_nurse;
  
  //If m[i][d] == 0, then, no work in all shifts on that day by a part time nurse, i.e she is absent on that day.
  constraint11:
  forall(i in part_nurse, d in day) M*m[i][d] >= sum(t in period) y[i][d][t];
  
  //If a part time nurse is present on a day, then, she has worked in atleast 1 shift on that day
  constraint12:
  forall(i in part_nurse, d in day) M*(m[i][d] - 1) + 1 <= sum(t in period) y[i][d][t];
  
}
 