x = load('ex2x.dat');
y = load('ex2y.dat');

theta_true = [0.750150391769357; 0.063883375499711];

figure % open a new figure window
plot(x, y, 'o');
ylabel('Height in meters')
xlabel('Age in years')

m = length(y);
X = [ones(m, 1), x];

theta = zeros(2, 1);
alpha = 0.02;


for iter = 1:5000
    rInd = ceil(rand(10,1)*m);
    cent = mean(X(rInd, :)*theta - y(rInd));
    while(1)
        rn = ceil(rand*10);
        rInd2 = rInd(rn);
        if(abs(X(rInd2, :)*theta - y(rInd2) - cent) <= 0.3)
            break;
        end
    end
    theta = theta - alpha*X(rInd2, :)'*(X(rInd2, :)*theta - y(rInd2));
    norm(theta-theta_true)
end

hold on % Plot new data without clearing old plot
plot(X(:,2), X*theta, '-') % remember that x is now a matrix with 2 columns
                           % and the second column contains the time info
legend('Training data', 'Linear regression')

% figure; hold on;
% for i = 1:50
%     plotv(X(i, :)'*(X(i, :)*theta - y(i)),'-');
% end
% plotv(theta_true,'r-');
% plotv((1/m)*X'*(X*theta - y),'k-');
% plotv(theta,'r-');
% plotv(theta - theta_true, 'r-');
