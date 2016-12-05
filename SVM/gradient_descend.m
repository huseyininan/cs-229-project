x = load('ex4x.dat');
y = load('ex4y.dat');
y = 2*y - 1;

x = [ones(80, 1) x];

% normalize x
X = x;
for i = 1:80
    X(i, :) = X(i, :)/norm(X(i, :));
end
   

% find returns the indices of the
% rows meeting the specified condition
pos = find(y == 1); neg = find(y == -1);

% Assume the features are in the 2nd and 3rd
% columns of x

% plot(x(pos, 2), x(pos,3), '+'); hold on
% plot(x(neg, 2), x(neg, 3), 'o')


% theta = sum alpha_i x^(i)
alpha = randn(80, 1);
J = mean(max( (1 - (K'*alpha).*y), 0 )) 
stepSize = 0.1;

K = X*X';

% Gradient Descend
for iter = 1:1000
    alpha = alpha + stepSize*mean( (ones(80, 1)*y') .* K .* (ones(80, 1)*((K'*alpha).*y <= 1)'), 2 );
    J = mean(max( (1 - (K'*alpha).*y), 0 )) 
end
    
% %Stochastic Gradient Descend
% for iter = 1:1000
%     i =  randi([1 80],1);
%     stepSize = .3/sqrt(iter);
%     alpha = alpha + stepSize * y(i) * K(: , i) * (y(i) * K(: , i)' * alpha <= 1);
%     J = mean(max( (1 - (K'*alpha).*y), 0 )) 
% end


theta = X'*alpha;    

empirical_error = sum( (2*((X*theta) > 0) - 1) ~= y )

plot(x(pos, 2), x(pos,3), '+'); hold on
plot(x(neg, 2), x(neg, 3), 'o')
x1 = 10:0.1:70;
plot(x1, (-theta(1) - theta(2)*x1)/theta(3), 'k-')


