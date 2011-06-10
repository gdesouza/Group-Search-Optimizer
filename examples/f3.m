function fit=f3(x) 
n=length(x);
fit = 0;
for i=1:n
    for j=1:i
        fit = fit + x(j)^2;
    end
end
end