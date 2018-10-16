function [maxp S F]=maxp_general(Jin,Jout,k,isComplex)
% Code that evaluates the maximal probability of transforming the set of
% k unitaries encoded in Choi operators Jin and obtain the unitary
% operators Jout in  sequential protocol.
% Jin and Jout are tenors with 'n' Choi operators that should be written as
% Jin(:,:,i), where the variable 'i' ranges from 1 to 'n'
% 'k' corresponds to the number of uses of the input-operation
% if isComplex is '0', the code only consider supermaps with real numbers
% is isComplex is '1', the code considers general supermaps with complex
% numbers

d_out=size(Jout,1);%Evaluate the dimension of output Choi matrices
n_in=size(Jin,3);  %Count the number of Choi operators
d=sqrt(d_out);     %Calculate the dimension of the output unitary
'GENERAL PROTOCOL'
     cvx_begin SDP quiet
    %cvx_solver MOSEK
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% case of 1 copy
if k==1
    %Declare the SDP variable related to the probability p
    variable p
    % Declare the SDP variables related to S and F
    if isComplex==1
        variable S(d^4,d^4) complex semidefinite
        variable F(d^4,d^4) complex semidefinite
    else
        variable S(d^4,d^4) semidefinite
        variable F(d^4,d^4) semidefinite
    end
% Impose that the relation between input and output must be satisfied
% This is made exploiting the Choi isomorphism
    for i=1:n_in
        PartialTrace(S * Tensor(eye(d) , transpose(Jin(:,:,i)) , eye(d)) ,[2 3],[d d d d]) == p*Jout(:,:,i);
    end
    maximise p
    %The elements S and F should sum to a sequential SuperChannel
    C=S+F;
    is_general_protocol(C,d,k);
end %end if k==1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% case of 2 copies
if k==2
    %Declare the SDP variable related to the probability p
    variable p
   % Declare the SDP variables related to S and F
    if isComplex==1
        variable S(d^6,d^6) complex semidefinite
        variable F(d^6,d^6) complex semidefinite
    else
        variable S(d^6,d^6) semidefinite
        variable F(d^6,d^6) semidefinite
    end
% Impose that the relation between input and output must be satisfied
% This is made exploiting the Choi isomorphism
    for i=1:n_in
        PartialTrace(S * Tensor(eye(d) , transpose(Tensor(Jin(:,:,i),k)) , eye(d)) ,[2 3 4 5],[d d d d d d]) == p*Jout(:,:,i);
    end
    maximise p
    C=S+F;
    is_general_protocol(C,d,k);
end %end if k==2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% case of 3 copies
if k==3
    %Declare the SDP variable related to the probability p
    variable p
    % Declare the SDP variables related to S and F
    if isComplex==1
        variable S(d^8,d^8) complex semidefinite
        variable F(d^8,d^8) complex semidefinite
    else
        variable S(d^8,d^8) semidefinite
        variable F(d^8,d^8) semidefinite
    end
% Impose that the relation between input and output must be satisfied
% This is made exploiting the Choi isomorphism
    for i=1:n_in
        PartialTrace(S * Tensor(eye(d) , transpose(Tensor(Jin(:,:,i),k)) , eye(d)) ,[2 3 4 5 6 7],[d d d d d d d d]) == p*Jout(:,:,i);
    end
    maximise p
    C=S+F;
    is_general_protocol(C,d,k);
end  % End if k==3
%%%%%%%%%%%%%%%%%%%%%%%%
%finish SDP
    cvx_end
    maxp=p;
end
