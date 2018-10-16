function dim=find_dimension(d,k)
%Function that evaluate the dimention of the linear space spanned by 'k' copies of 'd'
%dimension unitary channels
%Start generating 'n' random unitary channels
%initialise the 'n' parameter as 10^3
%This value is, in principle, arbitrary. We have chosen 10^3 because we have verified numerically that is relatively fast for the computer to analyse 10^3 unitaries of the form U_d^k 
    n=10^3;
 %Initialise a variable to stock a set of 'k' d-dimentional unitary operators
    list_U_k=zeros(d^k,d^k,n);
    for i=1:n 
        %Creates a dim-dimensional random unitary, sampled by the Haar measure
        U=RandomUnitary(d);
        %Add 'k' copies of the unitary operator into a list
        list_U_k(:,:,i)=Tensor(U,k);
    end
    %Evaluate the number of linear independent unitary channels
    nLI=unitary_linear_independent(list_U_k);
    %This while only stops when the number 'n' is larger nLI
    while n<=nLI
        %Generate more random unitary channels, the value 100 is arbitrary
        n=n+100;
        %Initialise a variable to stock a set of 'k' d-dimentional unitary operators
        list_U_k=zeros(d^k,d^k,n);
        for i=1:n 
            U=RandomUnitary(d);
            list_U_k(:,:,i)=Tensor(U,k);
        end
        %Evaluate the number of linear independent unitary channels
        nLI=unitary_linear_independent(list_U_k);
    end
% toc %Show total time of this funcion
    dim=nLI;
end
