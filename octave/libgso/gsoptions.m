function default_gsoptions = gsoptions
	default_gsoptions.popsize     = 50;
	default_gsoptions.elitesize   = 0.1;
	default_gsoptions.nproducers  = 1;
	default_gsoptions.nscroungers = 0.8;
	default_gsoptions.a           = 5;
	default_gsoptions.tmax        = pi/3;
	default_gsoptions.amax        = pi/6;
	default_gsoptions.lmax        = 10;
	default_gsoptions.niterations = 5000;
	default_gsoptions.limitspace  = 'clip';
	default_gsoptions.error       = 0.0001;
	default_gsoptions.verbose     = 0;
end

