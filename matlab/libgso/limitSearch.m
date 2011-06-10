%% Function limitSearch
function X = limitSearch(Xn, Xmax, Xmin, method)
% method:
%       clip     : X=Xmax
%       dont_move: X=X

        X=Xn;

        % limit the search space
        Vmax=find(X > Xmax);
        Vmin=find(X < Xmin);

        if strcmp(method,'clip')
                X(Vmax)=Xmax(Vmax);
                X(Vmin)=Xmin(Vmin);
        elseif strcmp(method,'dont_move')
                X(Vmax)=X(Vmax);
                X(Vmin)=X(Vmin);
        else
                error('limitSearch: unknown method');
        end;

end