%% Clear Everything
clc, clear, close all

%% Defining Problem:
Problem = optimproblem;      % default minimization

%% Defining Variables:
x = optimvar('x',14,6,'Type','integer','LowerBound',0,'UpperBound',1);
y = optimvar('y',14,6,'Type','continuous','LowerBound',0,'UpperBound',8);

%% Defining Constraints:

%One department should have at least one cleaner
Constraint_I = optimconstr(6);
for i = 1:6
Constraint_I(i) = sum(x(1:14,i)) >= 1;
end
showconstr(Constraint_I);
Problem.Constraints.Constraint_I = Constraint_I;

%One cleaner can be assigned to maximum of 3 departments.
Constraint_II = optimconstr(14);
for j = 1:14
Constraint_II(j) = sum(x(j,1:6)) <= 3;
end
showconstr(Constraint_II);
Problem.Constraints.Constraint_II = Constraint_II;

%If any single cleaner assigned for each department, cleaner can work maximum 8 hours for a day.
Constraint_III = optimconstr(84);
for k = 1:14
for l = 1:6
Constraint_III(k,l) = y(k,l) <= 8*x(k,l) ;
end
end
showconstr(Constraint_III)
Problem.Constraints.Constraint_III = Constraint_III;

%One cleaner can work maximum 8 hours.
Constraint_IV = optimconstr(14);
for m = 1:14
Constraint_IV(m) = sum(y(m,1:6)) <= 8;
end
showconstr(Constraint_IV)
Problem.Constraints.Constraint_IV = Constraint_IV;

%The following Constraint shows about how many human hours should be covered in that department
Constraint_V = optimconstr(1);
Constraint_V(1) = sum(y(1:14,1)) >= 16.00;
showconstr(Constraint_V)
Problem.Constraints.Constraint_V = Constraint_V;           %Department of Mathematics

Constraint_VI = optimconstr(1);
Constraint_VI(1) = sum(y(1:14,2)) >= 10.75;             
showconstr(Constraint_VI)
Problem.Constraints.Constraint_VI = Constraint_VI;         %Department of Botany

Constraint_VII = optimconstr(1);
Constraint_VII(1) = sum(y(1:14,3)) >= 14.25;
showconstr(Constraint_VII)
Problem.Constraints.Constraint_VII = Constraint_VII;       %Department of Chemistry

Constraint_VIII = optimconstr(1);
Constraint_VIII(1) = sum(y(1:14,4)) >= 13.50;
showconstr(Constraint_VIII)
Problem.Constraints.Constraint_VIII = Constraint_VIII;     %Department of Computer Science

Constraint_IX = optimconstr(1);
Constraint_IX(1) = sum(y(1:14,5)) >= 12.75;
showconstr(Constraint_IX)
Problem.Constraints.Constraint_IX = Constraint_IX;         %Department of Physics

Constraint_X = optimconstr(1);
Constraint_X(1) = sum(y(1:14,6)) >= 10.25;
showconstr(Constraint_X)
Problem.Constraints.Constraint_X = Constraint_X;           %Department of Zoology

%% Objective Functions
Problem.Objective =sum( sum (x));

%% Solving the Problem
Options = optimoptions('intlinprog','MaxTime',10);
[sol,fval,eflag,output] = solve(Problem, 'Options', Options);
fprintf('Number Of Minimum cleaning worker assignments required for Science Faculty =');
disp(fval)