%% Function: selectProducers
%  Return array of indices of producers based on their fitness
function [P, S, R] = selectMembers( NumProducers, NumScroungers, Fit )
        %P=[]; S=[]; R=[];
        P=zeros(1,NumProducers); S=zeros(1,NumScroungers); R=zeros(1,length(Fit)-NumProducers-NumScroungers);

        [Fitsort,k]=sort(Fit,'ascend');
        P=k(1:NumProducers);

        n=0;
        while ( n < NumScroungers )
                ns=round(rand(1)*(length(Fit)-1)+1);
                if ~(sum(find(P==ns)) | sum(find(S==ns)))
                        %S=[S ns];
                        n = n + 1;
                        S(n) = ns;
                end
        end

        nr = 0; n = 0;
        while ( n < (length(Fit)-NumProducers-NumScroungers) )
                nr = nr + 1;
                if ~(sum(find(P==nr)) | sum(find(S==nr)) | sum(find(R==nr)))
                    n = n + 1;
                    R(n) = nr;
                end;
        end
end