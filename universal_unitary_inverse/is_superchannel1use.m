function [C E]=is_superchannel1use(C,dims)
% Code that imposes SPD constrains on a variable C to enforce that C is a valid
% superchannel that makes a single use of the input-operation
% 'dims' corresponds to the dimension of the systems in space 1, 2, 3, and
% 4 and should be inputted as dims=[d1 d2 d3 d4]

d1=dims(1);
d2=dims(2);
d3=dims(3);
d4=dims(4);

    cvx_begin SDP
        PartialTrace(C,4,[d1 d2 d3 d4])==kron( PartialTrace(C,[3 4],[d1 d2 d3 d4]),eye(d3)/d3);
        PartialTrace(C,[2 3 4],[d1 d2 d3 d4])==eye(d1)*d3;
    cvx_end
end
