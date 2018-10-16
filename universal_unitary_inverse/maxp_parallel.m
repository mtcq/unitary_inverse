function [maxp S F]=maxp_parallel(Jin,Jout,k,isComplex)
% Code that evaluates the maximal probability of transforming the set of
% k unitaries encoded in Choi operators Jin and obtain the unitary
% operators Jout in  sequential protocol.
% Jin and Jout are tenors with 'n' Choi operators that should be written as
% Jin(:,:,i), where the variable 'i' ranges from 1 to 'n'
% 'k' corresponds to the number of uses of the input-operation
% if isComplex is '0', the code only consider supermaps with real numbers
% is isComples is '1', the code considers general supermaps with complex
% numbers

d_in=size(Jin,1);  %Evaluate the dimension of input Choi matrices
d_out=size(Jout,1);%Evaluate the dimension of output Choi matrices
n_in=size(Jin,3);  %Count the number of choi operators
 
d4=sqrt(d_out); %Calculate the dimension of the output-unitary
d1=d4; %The dimension of 1 is the same as 4
d2=sqrt(d_in)^k; %Calculate the dimension of the k input-unitaries
d3=d2;  %The dimension of 3 is the same as 2

dims=[d1 d2 d3 d4];
d=d4;
'PARALLEL PROTOCOL'
     cvx_begin SDP quiet
    %cvx_solver MOSEK

    %Declare the SDP variable related to the probability p
    variable p
    
    % Declare the SDP variables related to S and F

    if isComplex==1
        variable S(d4*d1*d2*d3,d4*d1*d2*d3) complex semidefinite
        variable F(d4*d1*d2*d3,d4*d1*d2*d3) complex semidefinite
    else
        variable S(d4*d1*d2*d3,d4*d1*d2*d3) semidefinite
        variable F(d4*d1*d2*d3,d4*d1*d2*d3) semidefinite
    end
    
    for i=1:n_in
          % We now re-agroup the 'k' input Choi operators as a single one
          Jin_now=Tensor(Jin(:,:,i),k);
          %If k>1, we should re-arange the terms such that we can
          %understand the 'k' input operatoins as one
    if k==2
        Jin_now=PermuteSystems(Jin_now,[1 3 2 4],[d d d d]);
    end
    if k==3
        Jin_now=PermuteSystems(Jin_now,[1 3 5 2 4 6],[d d d d d d]);
    end
    if k==4
        Jin_now=PermuteSystems(Jin_now,[1 3 5 7 2 4 6 8],[d d d d d d d d]);
    end
% Impose that the relation between input and output must be satisfied
% This is made exploiting the Choi isomorphism
        PartialTrace(S * Tensor(eye(d1) , transpose(Jin_now) , eye(d4)) ,[2 3],[d1 d2 d3 d4]) == p*Jout(:,:,i);
    end
    maximise p
    %The elements S and F should sum to a SuperChannel with 1
    %input-operation that contains the 'k' unitaries
    C=S+F;
    is_superchannel1use(C,dims);
    cvx_end
    maxp=p;
end
