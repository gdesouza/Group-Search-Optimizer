function Fit = evaluatePopulation( X, popsize, fobj )
    Fit=[];
    for i=1:popsize
        Fit(i)=fobj(X(i,:));
    end;
end