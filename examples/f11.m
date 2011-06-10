% 5.Shifted Griewank's Function
function fit=f11(x)
%global initial_flag
%persistent o
[ps,D]=size(x);
%if initial_flag==0
%    load griewank_shift_func_data
%    if length(o)>=D
%         o=o(1:D);
%    else
%         o=-600+1200*rand(1,D);
%    end
%    o=o(1:D);
%    initial_flag=1;
%end
%x=x-repmat(o,ps,1);
f=1;
for i=1:D
    f=f.*cos(x(:,i)./sqrt(i));
end
fit=sum(x.^2,2)./4000-f+1;
end