#This model optimizes the 'diet problem' by minimizing the cost to purchase
#	3 meals (breakfast, lunch, and dinner) s.t. nutritional and calorie constraints

#When this model is used with the file 'meals.dat' the output is 3 meals.
#	Specifically, the model recommends eating 2 bowls of raisin bran for breakfast,
#	1 hamburger and 2 apples for lunch and a chicken sandwich for dinner for a total
#	cost of $9.26.
#However, if the consumer has dietary restrictions, such as a low salt diet due to
#	high blodd pressure, then the model is used with the meals_hbp.dat file.  This file
#	has a narrower permissible range of daily sodium intake.  The output with
#	the more restrictive salt condition is 1 bowl of granola and 1 honey nut cheerios for
#	breakfast, 2 apples and 2 PB&J sandwiches for lunch and 2 packages of salad for dinner
#	for a total cost of $11.38.  As expected, the price is higher for the more restrictive
#	low-salt diet.


#Solve with cplex solver in ampl by typing with 'option solver cplexamp'
#Display 3 meals by typing 'dispaly b_Buy, l_Buy, d_Buy'

set NUTR;
set D_FOOD;
set B_FOOD;
set L_FOOD;


#Nutritional bounds
param n_min {NUTR} >= 0;
param n_max {i in NUTR} >= n_min[i];

#Dinner parameters
param cost {D_FOOD} > 0;
param f_min {D_FOOD} >= 0;
param f_max {j in D_FOOD} >= f_min[j];

param amt {NUTR,D_FOOD} >= 0;
var d_Buy {j in D_FOOD} integer >= f_min[j], <= f_max[j];


#Breakfast parameters
param b_cost {B_FOOD} > 0;
param b_f_min {B_FOOD} >= 0;
param b_f_max {k in B_FOOD} >= b_f_min[k];

param b_amt {NUTR,B_FOOD} >= 0;
var b_Buy {k in B_FOOD} integer >= b_f_min[k], <= b_f_max[k];

#Lunch parameters
param l_cost {L_FOOD} > 0;
param l_f_min {L_FOOD} >= 0;
param l_f_max {k in L_FOOD} >= l_f_min[k];

param l_amt {NUTR,L_FOOD} >= 0;
var l_Buy {k in L_FOOD} integer >= l_f_min[k], <= l_f_max[k];

#Objective fuction
minimize Total_Cost:  sum {j in D_FOOD} cost[j]*d_Buy[j] + 
	sum{k in B_FOOD} b_cost[k]*b_Buy[k] + sum{k in L_FOOD} l_cost[k]*l_Buy[k];

#Constrain total menu to meet daily dietary contraints
subject to diet {i in NUTR}:
	n_min[i] <= sum {j in D_FOOD} amt[i,j] * d_Buy[j] + sum {k in B_FOOD} b_amt[i,k]*b_Buy[k] + 
   		sum{k in L_FOOD} l_amt[i,k]*l_Buy[k]  <= n_max[i];

#Constrain meal choices such that each meal provides at least 1/3 of min calories 
#	and less than 1/2 min calories
subject to dinner_cal:
	n_min["Cal"]/3 <= sum{j in D_FOOD} amt["Cal",j] * d_Buy[j] <= n_min["Cal"]/2;

subject to breakfast_cal:
	n_min["Cal"]/3 <= sum{k in B_FOOD} b_amt["Cal",k] * b_Buy[k] <= n_min["Cal"]/2;
	
subject to lunch_cal:
	n_min["Cal"]/3 <= sum{k in L_FOOD} l_amt["Cal",k] * l_Buy[k] <= n_min["Cal"]/2;