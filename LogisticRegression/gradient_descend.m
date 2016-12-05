x = load('ex4x.dat');
y = load('ex4y.dat');

x = [ones(80, 1) x];
% find returns the indices of the
% rows meeting the specified condition
pos = find(y == 1); neg = find(y == 0);

% Assume the features are in the 2nd and 3rd
% columns of x
% plot(x(pos, 2), x(pos,3), '+'); hold on
% plot(x(neg, 2), x(neg, 3), 'o')

g = @(z) 1.0 ./ (1.0 + exp(-z))';
% Usage: To find the value of the sigmoid 
% evaluated at 2, call g(2)

theta_true = [  -16.3787; 0.1483; 0.1589];

theta = zeros(3, 1);
%J = mean( -y.*log(g(x*theta)) - (1 - y).*log(1 - g(x*theta)) )
alpha = 0.005;

for iter = 1:1000
    %H = zeros(3, 3);
    grad = zeros(3, 1);
    for i = 1:80
        %H = H + (g(x(i,:)*theta)*(1-g(x(i,:)*theta))*x(i,:)'*x(i,:))/80;
        grad = grad + ((g(x(i,:)*theta) - y(i))*x(i,:)')/80;
    end
    theta = theta - alpha*grad;
    norm(theta-theta_true)
    %J = mean( -y.*log(g(x*theta)) - (1 - y).*log(1 - g(x*theta)) )
end
    
    
% plot(x(pos, 2), x(pos,3), '+'); hold on
% plot(x(neg, 2), x(neg, 3), 'o')
% x1 = 10:0.1:70;
% plot(x1, (-theta(1) - theta(2)*x1)/theta(3), 'k-')


