function fit = f4(x)
%   global initial_flag
%   persistent o
%   [ps, D] = size(x);
%   if (initial_flag == 0)
%      load schwefel_shift_func_data
%      if length(o) >= D
%          o=o(1:D);
%      else
%          o=-100+200*rand(1,D);
%      end
%      initial_flag = 1;
%   end
%   x=x-repmat(o,ps,1);
   fit = max(abs(x), [], 2);
end
