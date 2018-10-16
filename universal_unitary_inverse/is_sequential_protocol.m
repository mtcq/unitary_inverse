function is_sequential_protocol(C,d,k)
% Code that imposes SPD constrains on a variable C to enforce that C is a valid
% sequential superchannel
% 'd' corresponds to the dimension of the systems in which the
% output-operation is applied
% 'k' corresponds to the number of uses of the input-operation

    cvx_begin SDP
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% case of 1 copy
if k==1
    PartialTrace(C,4,[d d d d])==kron(PartialTrace(C,[3 4],[d d d d]),eye(d)/d);
    PartialTrace(C,[2 3 4],[d d d d])==eye(d)*d;
end %end if k==1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% case of 2 copies
if k==2
     % Declare the SDP variables corresponding to the encoders with memory
     PartialTrace(C,6,[d d d d d d]) == kron(PartialTrace(C,[5 6],[d d d d d d]),eye(d)/d);
     PartialTrace(C,[4 5 6],[d d d d d d]) == kron(PartialTrace(C,[3 4 5 6],[d d d d d d]),eye(d)/d);
     PartialTrace(C,[2 3 4 5 6],[d d d d d d])==eye(d)*d^2;
end %end if k==2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% case of 3 copies
if k==3  
    PartialTrace(C,8, [d d d d d d d d])==kron(PartialTrace(C,[7 8], [d d d d d d d d]),eye(d)/d);
    PartialTrace(C,[6 7 8], [d d d d d d d d])==kron(PartialTrace(C,[5 6 7 8], [d d d d d d d d]),eye(d)/d);
    PartialTrace(C,[4 5 6 7 8], [d d d d d d d d])==kron(PartialTrace(C,[3 4 5 6 7 8], [d d d d d d d d]),eye(d)/d);
    PartialTrace(C,[2 3 4 5 6 7 8], [d d d d d d d d])==eye(d)*d^3;     
end %end if k==3
    cvx_end
end
