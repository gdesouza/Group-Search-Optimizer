function fit=f5(x)
%global initial_flag
%persistent o
[ps,D]=size(x);
%if initial_flag==0
%    load rosenbrock_shift_func_data
%    if length(o)>=D
%         o=o(1:D);
%    else
%         o=-90+180*rand(1,D);
%    end
%    initial_flag=1;
%end
%x=x-repmat(o,ps,1)+1;
fit=sum(100.*(x(:,1:D-1).^2-x(:,2:D)).^2+(x(:,1:D-1)-1).^2,2);
end
