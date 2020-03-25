function M = MinimizeFunction(func, alpha, actualValue, H, X)
 
lastValue = 99999999;
x = alpha;

% Minimizing the alpha
for i = 0.01: 0.001: 10
    currValue = abs(func(i, 0, H, X) - actualValue);
    if  lastValue < currValue
        x = i;
        break;
    end
    lastValue = currValue;
end

M = x;