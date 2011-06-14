
% parametros definidos no artigo
n = 2;
U = 65536 *ones(1,n);
L =-65536 *ones(1,n);
niter = 3000;

options = gsoptions();
options.a           = round(sqrt(n+1));
options.tmax        = pi/(options.a)^2;
options.amax        = options.tmax/2;
options.limitspace  = 'dont_move';
options.niterations = niter;
options.nscroungers = 0.8;
options.nproducers  = 1;
options.error       = 0;
options.popsize     = 48;
options.elitesize   = 10;
options.stall       = 10;
options.verbose     = 1;
options.lmax        = 185364;

tic;
[x fx]=gso(@fun14,U,L,options);
	
fprintf('Function f14: \t Solution: %e \t Time: %f\n', min(fx),toc);

