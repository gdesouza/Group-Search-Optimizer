
% parametros definidos no artigo
n = 30;
U = 10 *ones(1,n);
L =-10 *ones(1,n);
niter = 3000;

options = gsoptions();
options.a           = round(sqrt(n+1));
options.tmax        = pi/(options.a)^2;
options.amax        = options.tmax/2;
options.niterations = niter;
options.nscroungers = 0.8;
options.nproducers  = 1;
options.error       = 0;
options.popsize     = 48;
options.elitesize   = 10;
options.stall       = 10;
options.verbose     = 0;
options.lmax        = 1095.445115010332;

tic;
[x fx]=gso(@f2,U,L,options);
	
fprintf('Function f2: \t Solution: %e \t Time: %f\n', min(fx),toc);

