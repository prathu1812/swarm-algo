clc;
clear all;
%Initialization of SCA algorithm
Np = 1000;         % Population Size
Dim = 2;        % Dimension of the cost function 
Objf = @constant;  % Cost function
lb = -1.*ones(1,Dim);   % Lower bound of the search space
ub = 1.*ones(1,Dim);    % Upper bound of the search space
X = zeros(Np,Dim);      % Container to store population
fit = zeros(1,Np);      % Initialize fitness vector
T = 10;               % Maximum Iterations
t = 0;                  % Iteration counter

%Initialize parameters
b = 2;     % Constant parameters
p = 0.5;   % probability switch 
r1 = b; r2 = 1; r3= 1; r4 = 1; % Initial value control parameters

%Initialize Population
for i=1:Np
    X(i,:) = lb + rand(1,Dim).*(ub-lb);
    fit(i) = Objf(X(i,:));
end
pop = X; % Initial Population
[best_fit,ind] = min(fit);  % Best solution is destination point 
best_agent = pop(ind,:);    % Best agnet in the population
A = pop;
%%Iteration Loop
while t < T
    r1 = b - t*(b/T);
    
    %Position update equations
    for i=1:Np
        % Update control parameters
        r2 = (2*pi)*rand();
        r3 = 2*rand();
        r4 = rand();
        
        % Apply switch 
        if r4 < p
            pop(i,:) = pop(i,:)+ r1*sin(r2)*abs(r3*best_agent - pop(i,:));   %Equation 1.2
        else
            pop(i,:) = pop(i,:)+ r1*cos(r2)*abs(r3*best_agent - pop(i,:));   %Equation 1.3
        end
    end
    
    % Check bounds
    for i=1:Np
        for j=1:Dim
                if pop(i,j) < lb(1)
                    pop(i,j) = lb(1);
                
                elseif pop(i,j) > ub(1)
                    pop(i,j) = ub(1);
                end
        end
    end
    
    % Evaluate fitness of updated population 
    for i=1:Np
        fit(i) = Objf(pop(i,:));
    end
    
    %Update the best fitness and best solution
    [best_fit,ind] = min(fit);
    best_agent = pop(ind,:); 
    
    %Increase iteration counter
    t=t+1;
end
% optimum_fit = best_fit
% optimum_location = best_agent 

display(['Optimum value obtained by SCA alg. is :', num2str(best_fit)]);
display(['Optimum solution obtained by SCA alg. is :', num2str(best_agent)]);
    
    
    
    
    
    
    

    






































%Test 
% while t < T
%     r1 = b - t*(b/T)
%     for i=1:2
%         r2 = (2*pi)*rand()
%         r3 = 2*rand()
%         r4 = rand()
%     end
%     t=t+1;
% end
    