syms k z a T;
assumeAlso([a T] > 0)
q = exp(-a*T); 

%%
Fa = simplify( ztrans( cos(k*a*T), k, z ) )
fa_rec = simplify( iztrans(Fa, z, k) ) 

%%
Fb = simplify( ztrans( (k*T)^2 * exp(-a*k*T), k, z ) )
fb_rec = simplify( iztrans(Fb, z, k) ) 
fb_rec1 = simplify( subs(fb_rec, nchoosek(k-1,2), (k-1)*(k-2)/2) )

%%
Fc = simplify( ztrans( (1/a)*(a*k*T - 1 + exp(-a*k*T)), k, z ) )
fc_rec = simplify( iztrans(Fc, z, k) )