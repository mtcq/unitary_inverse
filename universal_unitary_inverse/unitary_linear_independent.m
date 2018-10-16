function nLI=unitary_linear_independent(list_U)
%This funcion calculate the number of linearly independent linear maps
%(in particular, unitary channels) in a list of operators 'list_U'.
%The variable 'list_U' should be in the form list_U(:,:,i), where i ranges
%from 1 to the number of linear operators

    N=size(list_U,3); %Evaluate the number of elements in the list
    d=size(list_U,1); %Evaluate the dimension of the operators in the list
    A=nan(d^4,N); %Initialise a matrix that will stock the operators as vectors
    phiP=IsotropicState(d,1);  %Initialise a matrix that will stock the operators as vectors
    for i=1:N
        Unow=list_U(:,:,i);
        %Create the Choi operator associated to the map induced by the
        %operator Unow
        aux=kron(Unow,eye(d))*phiP*kron(Unow,eye(d))'; 
        %Stock the this choi operator in a matrix
        A(:,i)=aux(:);
    end
    %The number of linear independent maps is the rank of the matrix A
    nLI=rank(A);
end
