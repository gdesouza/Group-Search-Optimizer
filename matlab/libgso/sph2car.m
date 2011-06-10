%% Function: sph2car
% funcao para converter coordenatas esféricas para cartesianas
% no hiper espaço.
function D=sph2car(phi)
        dim=max(size(phi))+1;
        D = zeros(1,dim);
        
        D(1)=cos(phi(1)) ;
        for j=2:dim-1
                D(j)=cos(phi(j)) ;
                for q=1:j-1
                        D(j)=D(j)*sin(phi(q)) ;
                end;
        end;
        D(dim)=prod(sin(phi(1:dim-1)));
end