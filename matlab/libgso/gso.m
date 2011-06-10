function [X Fit]=gso( fobj, U, L, options  )
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
%               nproducers: number of producers
%               nscroungers: number of scroungers (in % of population)
%               a: range constant
%               tmax: maximum pursuit angle
%               amax: maximum turning angle
%               lmax: maximum pursuit distance
%               niterations: maximum number of iterations
%               deviation: maximum deviation
%               stall: number of iterations within deviation which will stall the optimization
%               verbose: verbose level

        X=[];
        Fit=[];

        % Check the dimension size
        if sum(size(U) ~= size(L))
                disp('Incompatible sizes: size(U) != size(L)\n');
                return;
        end;

        % number of dimensions
        dim=length(U);

        % read options
        gsoptions.popsize     = 100;
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

        % verbose level
        verbose = gsoptions.verbose;

        % moving average window 
        windowsize=gsoptions.stall;
        FitWindow=9999*ones(1,windowsize);


        % Search space lower bounds
        Xmin=ones(gsoptions.popsize,dim); 
        for i=1:gsoptions.popsize 
            Xmin(i,:)=ones(1,dim).*L; 
        end;
        
        % Search space upper bounds
        Xmax=ones(gsoptions.popsize,dim); 
        for i=1:gsoptions.popsize 
            Xmax(i,:)=ones(1,dim).*U; 
        end;

        if ~(exist('options','var'))
                gsoptions.lmax        = sqrt(sum(Xmax(1,:)-Xmin(1,:))^2);
        end;

        % population size
        popsize = gsoptions.popsize;

        % Number of producers
        NumProducers=gsoptions.nproducers;

        % Number of scroungers
        NumScroungers=ceil(gsoptions.nscroungers*(popsize-NumProducers));

        % ranger coeficient (a)
        arange = gsoptions.a;

        % maximum pursuit angle
        tmax=gsoptions.tmax;

        % maximum turnung angle
        amax=gsoptions.amax;

        % maximum pursuit distance
        lmax=gsoptions.lmax;

        % error
        erro=gsoptions.error;

        % number of iterations
        niterations=gsoptions.niterations;

        % Initialize population
        phi=ones(popsize,dim-1)*pi/4;
        X=Xmin+rand(popsize,dim).*(Xmax-Xmin);
        
        % Evaluate members
        Fit = evaluatePopulation(X,popsize,fobj);

        % focus variables
        P_cont = zeros(1,popsize); 
        phi_0 = zeros(popsize,dim-1);
        P = []; R = [];
        
        for iteration=1:niterations

                % save old rangers and producers
                R_old = R; P_old = P;
                
                % select producers, scroungers and rangers
                [P, S, R] = selectMembers( NumProducers, NumScroungers, Fit );

                % Perform producing
                for np=1:NumProducers
                        n=P(np);
						
                        % tell whether a ranger finds a better spot
						if (verbose>0)
                            if find(n==R_old) 
                                fprintf('Goldmine!\n'); 
                            end;
						end;

                        % increase counter in case the producer is
                        % producing again
                        if find(n==P_old) 
							P_cont(n) = P_cont(n) + 1; 
                        end;

                        % generate random numbers
                        r1=randn(1);
                        r2=rand(1,dim-1);

                        % calculate distance
                        D =sph2car(phi(n,:));
                        Dr=sph2car(phi(n,:)+r2*tmax/2);
                        Dl=sph2car(phi(n,:)-r2*tmax/2);

                        % scan 3 points whithin the hypercube
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


                        % calculate fitness
                        fXz=fobj(Xz);
                        fXr=fobj(Xr);
                        fXl=fobj(Xl);

                        % choose the best point
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

                                P_cont(n) = 0;
								phi_0(n,:) = phi(n,:);
                        else
								% if the producer can not find a better area after a iterations, 
								% it will turn its head back to zero degree.
                                if P_cont(n) > 5
										if (verbose>0)
											fprintf('FOCUS!!!\n');
										end;
                                        phi(n,:) = phi_0(n,:);
                                        P_cont(n) = 0;
								else
										r2=rand(1,dim-1);
										phi(n,:)=phi(n,:)+r2*amax;
                                end
                        end
                end

                % Perform scrounging
                for ns=1:length(S)
                        n = S(ns);
						
						% Each scrounger randomly selects a producer to move towards
						np = P(randi(length(P),1)); 
						
                        % generate random numbers
                        r2=rand(1,dim-1);
                        r3=rand(1,dim);
						
                        % follow the producer
                        X(n,:)   = X(n,:) + r3 .* (X(np,:)-X(n,:));  
                        phi(n,:) = phi(n,:) + r2*amax;             
                        Fit(n)   = fobj(X(n,:));
                end


                % perform ranging
                for nr=1:length(R)
                        n=R(nr);
                        
                        % generate random numbers
                        r1=randn(1);
                        r2=rand(1,dim-1);

                        phinovo=phi(n,:)+r2*amax;

                        li = arange*r1;
                        D=sph2car(phinovo);
                        Xnovo = X(n,:)+li*D*lmax;

                        % limit the search space
                        Vmax=find(Xnovo>Xmax(n,:)); Xnovo(Vmax)=X(n,Vmax);
                        Vmin=find(Xnovo<Xmin(n,:)); Xnovo(Vmin)=X(n,Vmin);

                        % fly to new random position
                        X(n,:)   = Xnovo;
                        phi(n,:) = phinovo;						
                        Fit(n)   = fobj(Xnovo);
                end;
                
                
                % Stop criterium
                % using moving average of last solutions
                FitWindow=[FitWindow(2:windowsize) mean(Fit(P(1)))];

                if std(FitWindow)<erro
						if (verbose>0)
							fprintf('Population stalled after %d iterations\n',iteration);
						end;
                        break;
                else
                        if (verbose==1)
                                fprintf('%d: %1.20f \n', iteration, mean(FitWindow));
                        end;
                end

        end
end





