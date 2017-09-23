model Controller "A simple modelica example"
	parameter Real a = 2.0 "a constant";
	input Real u "input";
	output Real y "output";
algorithm
	y:= u + a;
end Controller;

/* vim: set noet ft=modelica fenc=utf-8 ff=unix sts=0 sw=4 ts=4 : */
