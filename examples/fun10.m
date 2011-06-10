% 	6.Shifted Ackley's Function
function fit=fun10(x)
%global initial_flag
%persistent o
[ps,D]=size(x);
%if initial_flag==0
%    load ackley_shift_func_data
%    if length(o)>=D
%         o=o(1:D);
%    else
%         o=-30+60*rand(1,D);
%    end
%    initial_flag=1;
%end
%x=x-repmat(o,ps,1);
fit=sum(x.^2,2);
fit=20-20.*exp(-0.2.*sqrt(fit./D))-exp(sum(cos(2.*pi.*x),2)./D)+exp(1);
end