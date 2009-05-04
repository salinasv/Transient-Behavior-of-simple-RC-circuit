function Q = init_q(CIRC, val)
%function Q = init_q(CIRC, val)
%
% Generate a matrix Q with an initial charge of val
%
% CIRC: The Circuit matrix
% val: 	Initial value.

Q = val .* CIRC;
