y = [-ones(40,1); ones(40,1)];
x = [randn(40, 1), randn(40, 1); 4 + randn(40, 1) , 4 + randn(40, 1)];

x = [ones(80, 1) x];
% find returns the indices of the
% rows meeting the specified condition
pos = find(y == 1); neg = find(y == -1);

plot(x(pos, 2), x(pos,3), '+'); hold on
plot(x(neg, 2), x(neg, 3), 'o')

alpha = randn(80, 1);
J = mean(max( (1 - (K'*alpha).*y), 0 )) 
stepSize = 0.001;

K = x*x';

% % Gradient Descend
% for iter = 1:1000
%     alpha = alpha + stepSize*mean( (ones(80, 1)*y') .* K .* (ones(80, 1)*((K'*alpha).*y <= 1)'), 2 );
%     J = mean(max( (1 - (K'*alpha).*y), 0 )) 
% end
    
%Stochastic Gradient Descend
for iter = 1:3000
    i =  randi([1 80],1);
    % stepSize = 1/sqrt(iter); % variance reduction
    alpha = alpha + stepSize * y(i) * K(: , i) * (y(i) * K(: , i)' * alpha <= 1);
    J = mean(max( (1 - (K'*alpha).*y), 0 )) 
end


theta = x'*alpha;    

empirical_error = sum( (2*((x*theta) > 0) - 1) ~= y )

plot(x(pos, 2), x(pos,3), '+'); hold on
plot(x(neg, 2), x(neg, 3), 'o')
x1 = -3:0.1:10;
plot(x1, (-theta(1) - theta(2)*x1)/theta(3), 'k-')