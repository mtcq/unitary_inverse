function is_general_protocol(C,d,k)
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
%Here we have use the notation stabilish in "A purification postulate for quantum mechanics with indefinite causal order" from Mateus Araújo, Adrien Feix, Miguel Navascués, and Časlav Brukner
%https://arxiv.org/abs/1611.08535
%This notation is convenient to describe the case of two and three uses of the input-operation
	PartialTrace(C,[4 5 6],[d d d d d d]) == kron(PartialTrace(C,[3 4 5 6],[d d d d d d]),eye(d))/d;
	PartialTrace(C,[2 3 6],[d d d d d d]) == kron(PartialTrace(C,[2 3 5 6],[d d d d d d]),eye(d))/d;

	WnF=PartialTrace(C,6,[d d d d d d]);
	A0W=kron(PartialTrace(WnF,3,[d d d d d]),eye(d)/d);
	A0W=PermuteSystems(A0W,[1 2 5 3 4],[d d d d d]);

	B0W=kron(PartialTrace(WnF,5,[d d d d d]),eye(d)/d);

	A0B0W=kron(PartialTrace(A0W,5,[d d d d d]),eye(d)/d);

	PartialTrace(C,[2 3 4 5 6],[d d d d d d])==eye(d)*d*d;

	WnF + A0B0W == A0W + B0W; 
end  %end if k==2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% case of 3 copies
if k==3  
%Here we have use the notation stabilish in "A purification postulate for quantum mechanics with indefinite causal order" from Mateus Araújo, Adrien Feix, Miguel Navascués, and Časlav Brukner
%https://arxiv.org/abs/1611.08535
%This notation is convenient to describe the case of two and three uses of the input-operation

    dP=d;
    dAi=d;
    dAo=d;
    dBi=d;
    dBo=d;
    dCi=d;
    dCo=d;
    dF=d;
    
    d = [dP dAi dAo dBi dBo dCi dCo dF];
    W = PartialTrace(C,8,d);
    d = [dP dAi dAo dBi dBo dCi dCo];

    PartialTrace(W,2,[dP dAi*dAo*dBi*dBo*dCi*dCo])==dAo*dBo*dCo*eye(dP);
    
    W_BiBoCiCo   = PartialTrace(W,[4 5 6 7],d);
    W_AoBiBoCiCo = kron(PartialTrace(W,[3 4 5 6 7],d),eye(dAo)/dAo);

    W_BiBoCiCo==W_AoBiBoCiCo;

    W_AiAoCiCo   = PartialTrace(W,[2 3 6 7],d);
    W_AiAoBoCiCo = kron(PartialTrace(W,[2 3 5 6 7],d),eye(dBo)/dBo);

    W_AiAoCiCo==W_AiAoBoCiCo;

    W_AiAoBiBo   = PartialTrace(W,[2 3 4 5],d);
    W_AiAoBiBoCo = kron(PartialTrace(W,[2 3 4 5 7],d),eye(dCo)/dCo);

    W_AiAoBiBo==W_AiAoBiBoCo;

    W_CiCo     = PartialTrace(W,[6 7],d);
    W_AoCiCo   = PermuteSystems(kron(PartialTrace(W,[3 6 7],d),eye(dAo)/dAo),[1 3 2],[dP*dAi dBi*dBo dAo]);
    W_BoCiCo   = kron(PartialTrace(W,[5 6 7],d),eye(dBo)/dBo);
    W_AoBoCiCo = PermuteSystems(kron(PartialTrace(W,[3 5 6 7],d),eye(dAo*dBo)/(dAo*dBo)),[1 3 2 4],[dP*dAi dBi dAo dBo]);

    W_CiCo==W_AoCiCo+W_BoCiCo-W_AoBoCiCo;

    W_BiBo     = PartialTrace(W,[4 5],d);
    W_AoBiBo   = PermuteSystems(kron(PartialTrace(W,[3 4 5],d),eye(dAo)/dAo),[1 3 2],[dP*dAi dCi*dCo dAo]);
    W_BiBoCo   = kron(PartialTrace(W,[4 5 7],d),eye(dCo)/dCo);
    W_AoBiBoCo = PermuteSystems(kron(PartialTrace(W,[3 4 5 7],d),eye(dAo*dCo)/(dAo*dCo)),[1 3 2 4],[dP*dAi dCi dAo dCo]);

    W_BiBo==W_AoBiBo+W_BiBoCo-W_AoBiBoCo;

    W_AiAo     = PartialTrace(W,[2 3],d);
    W_AoAiBo   = PermuteSystems(kron(PartialTrace(W,[2 3 5],d),eye(dBo)/dBo),[1 3 2],[dP*dBi dCi*dCo dBo]);
    W_AiAoCo   = kron(PartialTrace(W,[2 3 7],d),eye(dCo)/dCo);
    W_AiAoBoCo = PermuteSystems(kron(PartialTrace(W,[2 3 5 7],d),eye(dBo*dCo)/(dBo*dCo)),[1 3 2 4],[dP*dBi dCi dBo dCo]);

    W_AiAo==W_AoAiBo+W_AiAoCo-W_AiAoBoCo;

    W_Ao = PermuteSystems(kron(PartialTrace(W,3,d),eye(dAo)/dAo),[1 3 2],[dP*dAi dBi*dBo*dCi*dCo dAo]);
    W_Bo = PermuteSystems(kron(PartialTrace(W,5,d),eye(dBo)/dBo),[1 3 2],[dP*dAi*dAo*dBi dCi*dCo dBo]);
    W_Co = kron(PartialTrace(W,7,d),eye(dCo)/dCo);
    W_AoBo = PermuteSystems(kron(PartialTrace(W,[3 5],d),eye(dAo*dBo)/(dAo*dBo)),[1 4 2 5 3],[dP*dAi dBi dCi*dCo dAo dBo]);
    W_AoCo = PermuteSystems(kron(PartialTrace(W,[3 7],d),eye(dCo*dAo)/(dCo*dAo)),[1 4 2 3],[dP*dAi dBi*dBo dCi*dCo dAo]);
    W_BoCo = PermuteSystems(kron(PartialTrace(W,[5 7],d),eye(dCo*dBo)/(dCo*dBo)),[1 3 2],[dP*dAi*dAo*dBi dCi*dCo dBo]);
    W_AoBoCo = PermuteSystems(kron(PartialTrace(W,[3 5 7],d),eye(dCo*dAo*dBo)/(dCo*dAo*dBo)),[1 4 2 5 3],[dP*dAi dBi dCi*dCo dAo dBo]);

    W==W_Ao+W_Bo+W_Co-W_AoBo-W_AoCo-W_BoCo+W_AoBoCo;    
end %end if k==3
    cvx_end
end
    























 
