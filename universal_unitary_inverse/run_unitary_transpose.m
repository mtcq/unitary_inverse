clear
%Code that obtains the maximal success probability of transforming 'k' uses of a set of
%'n' 'd'-dimensional random unitary channels into its inverse
%Please set the parameters 'k','d','n','choose protocol', and 'isComplex'


%Set the dimension d of the unitary that will be inverted

%Set the number k of uses of the input-unitary

%Chose the protocol that will be used
%1 corresponds to parallel
%2 corresponds to sequential
%3 corresponds to general (potentially with indefinite causal order
     
%Set the number of random unitaries that will be used
%If n==0, we set the dimension of the space spanned by k d-dimensional
%unitary channels

%Decide if supermaps can use complex numbers of if we restrict only to real
%numbers.
%Set isComplex=0 to consider supermaps only with complex numbers
%From numerical evidence, we see that all optimal protocols used
%supermaps with only real numbers. When the SDP variable associated to the
%superinstruments is set to be real, the SPDs are faster and require less
%RAM memory
%Set isComplex==1 to consider general complex valued supermaps
        
        d=2               %Dimension 'd'
        k=1               %Number of uses 'k'
        n=0;              %Number of linear independent U_d^k, n==0 implies full basis
        chose_protocol=1; %1 for parallel, 2 for sequential, 3 for general
        isComplex=1;      %Set isComples=0 to restric to supermaps with real coefficients
        
if n==0
% Set 'n' as the dimension of the space spanned by k d-dimensional unitary
% channels
    n=find_dimension(d,k)
else
    % 'The dimension of the space spanned by k d-dimensional channels is:'
    n=n
    dim_k_d_unitaries=find_dimension(d,k)
        if dim_k_d_unitaries>n
            'The dimension of the space spanned by U_d^k is smaller than the number of unitaries n'
            'The value pmax that will be displayed is just an upper bound'
        end
end


    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%   End of Adjustable parameters   %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Create a maximally entangled state and multiply by the dimension 'd'
    max_ent_times_d=IsotropicState(d,1)*d+0;
%Declare variables that contain the Choi input and Choi output operations
    Jin=zeros(d^2,d^2,n);  
    Jout=zeros(d^2,d^2,n);
    list_U=zeros(d,d,n);
%Asign values for Choi inputs and Choi outputs
for i=1:n 
    %Creates a dim-dimensional random unitary, sampled by the Haar measure
        list_U(:,:,i)=RandomUnitary(d);
        U=list_U(:,:,i);
        list_U_k(:,:,i)=Tensor(U,k);
    %Creates the Choi operator for the unitary U and stock at a tensor for
    %the input
        Jin(:,:,i)=kron(U,eye(d)) * max_ent_times_d * kron(U',eye(d));
    %Define the Target unitary as the inverse of U
        Ut=transpose(U);
    %Creates the Choi operator for the unitary U' and stock at a tensor for
    %the output
        Jout(:,:,i)=kron(Ut,eye(d)) * max_ent_times_d * kron(Ut',eye(d));
end
tic;
%Find the maximal success probability of transforming 'k' d-dimensional
%unitaries into its inverse
if chose_protocol==1
    [maxp S F]=maxp_parallel(Jin,Jout,k,isComplex); %Assuming a parallel protocol
end
if chose_protocol==2
    [maxp S F]=maxp_sequential(Jin,Jout,k,isComplex);    %Assuming a sequential protocol
end
if chose_protocol==3
    [maxp S F]=maxp_general(Jin,Jout,k,isComplex);  %Assuming a geleral protocol
end
    maximal_success_probability=maxp
    total_time_in_minutes=toc/60
