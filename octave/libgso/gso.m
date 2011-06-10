function [X FX]=gso( fobj, U, L, options  )
% GSO group search optimizator
% Written by Gustavo de Souza (2011)
% Based on the algorithm proposed in the article:
% "Group Search Optimizer: An Optimization Algorithm Inspired by Animal Searching Behavior"
% by He, S., Wu, Q.H. and Saunders, J.R.
%
% Parameters:
%       @fobj: objective function
%       U: vector (1 x n) with upper limits, where n is the number of dimensions
%       L: vector (1 x n) with lower limits, where n is the number of dimensions
%       options: options structure for algorithms
%               popsize: population size
%               elitesize: proportion of population in elite group
%               nproducers: number of producers
%               nscroungers: number of scroungers (in % of population)
%               a: range constant
%               tmax: maximum pursuit angle
%               amax: maximum turning angle
%               lmax: maximum pursuit distance
%               niterations: maximum number of iterations
%
        X=[];
        FX=[];

        %% verifica se dimensoes de U e L sãiguais
        if sum(size(U) ~= size(L))
                disp('Incompatible sizes: size(U) != size(L)\n');
                return;
        end;

        %% numero de dimensoes
        dim=length(U);

        %% read options
        gsoptions.popsize     = 100;
        gsoptions.elitesize   = 10;
        gsoptions.nproducers  = 1;
        gsoptions.nscroungers = 0.8;
        gsoptions.a           = round(sqrt(dim+1));
        gsoptions.tmax        = pi/(gsoptions.a)^2;
        gsoptions.amax        = gsoptions.tmax/2;
        gsoptions.niterations = 5000;
        gsoptions.error       = 0.0001;
        gsoptions.stall       = 50;
        gsoptions.verbose     = 1;
        if exist('options','var')
                gsoptions = options;
        end;

        %% verbose level
        verbose = gsoptions.verbose;

        %% Moving average window size 
        windowsize=gsoptions.stall;
        %% Janela  (rank)
        FitWindow=9999;


        %% limite minimo para busca
        for i=1:gsoptions.popsize Xmin(i,:)=ones(1,dim).*L; end;
        %% limite maximo para busca
        for i=1:gsoptions.popsize Xmax(i,:)=ones(1,dim).*U; end;

        if ~(exist('options','var'))
                gsoptions.lmax        = sqrt(sum(Xmax(1,:)-Xmin(1,:))^2);
        end;

        % population size
        popsize = gsoptions.popsize;

        % numero de membros da elite
        elitesize=gsoptions.elitesize;

        % numero de produtores
        NumProducers=gsoptions.nproducers;

        % numero de oportunistas
        NumScroungers=ceil(gsoptions.nscroungers*(popsize-NumProducers));

        % numero de exploradores
        NumRangers=popsize-NumProducers-NumScroungers;

        % fator multiplicador para os rangers (a)
        arange = gsoptions.a;

        % maximum pursuit angle
        tmax=gsoptions.tmax;

        % maximum turnung angle
        amax=gsoptions.amax;

        % maximum pursuit distance
        lmax=gsoptions.lmax;


        % limit search methos
        limitspace = gsoptions.limitspace;

        % erro maximo
        erro=gsoptions.error;

        % numero maximo de iteracoes
        niterations=gsoptions.niterations;

        % Geraç da populaç inicial
        phi=ones(popsize,dim-1)*pi/4;
        X=Xmin+rand(popsize,dim).*(Xmax-Xmin);

        % Avaliar os membros
        Fit = evaluatePopulation(X,popsize,fobj);

        % Total de movimentos dos produtores e rangers
        total_moves_p=0;
        total_moves_r=0;
        R=[]; P=[]; P_cont = zeros(1,popsize); phi_0 = zeros(popsize,dim-1);
	if (verbose>0)
		printf('Iterations: %d\n',niterations);
	end;
        for iteration=1:niterations

                % ponteiros para os tipos de membros
                R_old = R; P_old = P;
                [P, S, R] = selectMembers( NumProducers, NumScroungers, Fit );


                % Perform producing
                for np=1:NumProducers
                        n=P(np);
			
			if (verbose>0)
				if find(n==R_old) printf("Goldmine!\n"); end;
			end;
							
                        if find(n==P_old) 
				P_cont(n) = P_cont(n) + 1; 
			end;

                        r1=randn(1);
                        r2=rand(1,dim-1);

                        D =sph2car(phi(n,:));
                        Dr=sph2car(phi(n,:)+r2*tmax/2);
                        Dl=sph2car(phi(n,:)-r2*tmax/2);

                        % Escolhe 3 pontos dentro do hipercubo
                        Xz = X(n,:) + r1*lmax*D;
                        Xr = X(n,:) + r1*lmax*Dr;
                        Xl = X(n,:) + r1*lmax*Dl;

%                         % limit the search space
%                         Vmax=find(Xz>Xmax(n,:)); Xz(Vmax)=X(n,Vmax);
%                         Vmin=find(Xz<Xmin(n,:)); Xz(Vmin)=X(n,Vmin);
%                         
%                         Vmax=find(Xr>Xmax(n,:)); Xr(Vmax)=X(n,Vmax);
%                         Vmin=find(Xr<Xmin(n,:)); Xr(Vmin)=X(n,Vmin);
% 
%                         Vmax=find(Xl>Xmax(n,:)); Xl(Vmax)=X(n,Vmax);
%                         Vmin=find(Xl<Xmin(n,:)); Xl(Vmin)=X(n,Vmin);


                        % Calcula o fitness
                        fXz=fobj(Xz);
                        fXr=fobj(Xr);
                        fXl=fobj(Xl);

                        % Compara os pontos e escolhe o movimento
                        Xnovo = X(n,:);
                        fXnovo = Fit(n);
                        phinovo = phi(n,:);
                        if fXz < fXnovo
                                Xnovo = Xz;
                                fXnovo = fXz;
                                phinovo = phi(n,:);
                        end
                        if fXr < fXnovo
                                Xnovo = Xr;
                                fXnovo = fXr;
                                phinovo = phi(n,:)+r2*tmax/2;
                        end
                        if fXl < fXnovo
                                Xnovo = Xl;
                                fXnovo = fXl;
                                phinovo = phi(n,:)-r2*tmax/2;
                        end

                        if fXnovo < Fit(n)
                                X(n,:)=Xnovo;
                                phi(n,:)=phinovo;
                                Fit(n)=fXnovo;
                                ir=-1;
                                total_moves_p = total_moves_p + 1;
                                P_cont(n) = 0;
				phi_0(n,:) = phi(n,:);
                        else
				% if the producer can not find a better area after a iterations, 
				% it will turn its head back to zero degree.
                                if P_cont(n) > 5
					if (verbose>0)
						printf('FOCUS!!!\n');
					end;
                                        phi(n,:) = phi_0(n,:);
                                        P_cont(n) = 0;
				else
					r2=rand(1,dim-1);
					phi(n,:)=phi(n,:)+r2*amax;
                                end
                        end
                end


                %% Perform scrounging
                for ns=1:length(S)
                        n = S(ns);

			% Each scrounger randomly selects a producer to move towards
			np = P(unidrnd(length(P))); 

                        r2=rand(1,dim-1);
                        r3=rand(1,dim);
						
                        X(n,:)   = X(n,:)+r3.*(X(np,:)-X(n,:));  
                        phi(n,:) = phi(n,:)+r2*amax;          
                        Fit(n)   = fobj(X(n,:));
                end




                %% perform ranging
                for nr=1:length(R)
			n=R(nr);

                        r1=randn(1);
                        r2=rand(1,dim-1);

                        phinovo=phi(n,:)+r2*amax;

                        li = arange*r1;
                        D=sph2car(phinovo);
                        Xnovo = X(n,:)+li*D*lmax;

                        % limit the search space
			Vmax=find(Xnovo>Xmax(n,:)); Xnovo(Vmax)=X(n,Vmax);
			Vmin=find(Xnovo<Xmin(n,:)); Xnovo(Vmin)=X(n,Vmin);
						
                        X(n,:)=Xnovo;
			phi(n,:) = phinovo;
                        Fit(n)=fobj(Xnovo);

                        total_moves_r=total_moves_r+1;
                end;


                % Criterio de parada
                % qual deve ser o criterio de parada?
                % usando media movel das ultimas 10 solucoes
                [Fitsort,k]=sort(Fit,'ascend');
                if length(FitWindow)>windowsize
                        FitWindow=FitWindow(2:windowsize);
                end;
                FitWindow=[FitWindow mean(Fit(k(1:elitesize)))];

                if std(FitWindow)<erro
			if (verbose>0)
				printf('Population stalled after %d iterations\n',iteration);
			end;
                        break;
                else
                        if (verbose==1)
                                printf('%d: %1.20f (Prod: %d) (%d)\n', iteration, mean(FitWindow),P(1),P_cont(P(1)));
                        elseif (verbose==2)
                                printf('(%4d): X=[  ', iteration);
                                printf('%8.04f  ',mean(X(k(1:elitesize),:)));
                                printf("]    fx=%f\n",mean(FitWindow));
                        end;

                end

        end

	if (verbose>0)
		printf('Movimentos (Prod/Rangers): (%d/%d)\n', total_moves_p,total_moves_r);
	end;

        Fit = evaluatePopulation( X, popsize, fobj );

        [Fitsort,k]=sort(Fit,'ascend');
        X=X(k,:);
        FX=Fitsort;

end



%% Function: selectProducers
%  Return array of indices of producers based on their fitness
function [P, S, R] = selectMembers( NumProducers, NumScroungers, Fit )
        P=[]; S=[]; R=[];

        [Fitsort,k]=sort(Fit,'ascend');
        P=k(1:NumProducers);

        while ( length(S) < NumScroungers )
                ns=round(rand(1)*(length(Fit)-1)+1);
                if ~(sum(find(P==ns)) | sum(find(S==ns)))
                        S=[S ns];
                end
        end

        nr = 0;
        while ( length(R) < (length(Fit)-NumProducers-NumScroungers) )
                nr = nr + 1;
                if ~(sum(find(P==nr)) | sum(find(S==nr)) | sum(find(R==nr)))
                        R=[R nr];
                end;
        end
end

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

function Fit = evaluatePopulation( X, popsize, fobj )
    Fit=[];
    for i=1:popsize
        Fit(i)=fobj(X(i,:));
    end;
end


%% Function: sph2car
% funcao para converter coordenatas esfécas para cartesianas
% no hiper espaç
function D=sph2car(phi)
        dim=max(size(phi))+1;
        D(1)=cos(phi(1)) ;
        for j=2:dim-1
                D(j)=cos(phi(j)) ;
                for q=1:j-1
                        D(j)=D(j)*sin(phi(q)) ;
                end;
        end;
        D(dim)=prod(sin(phi(1:dim-1)));
end


