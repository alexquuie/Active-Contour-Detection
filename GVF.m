function [u,v] = GVF(f, mu, ITER)
[m,n] = size(f);
fmin  = min(f(:));
fmax  = max(f(:));
f = (f-fmin)/(fmax-fmin);  

f = BoundMirrorExpand(f);  
[fx,fy] = gradient(f);    
u = fx; v = fy;            
Sqrf = fx.*fx + fy.*fy; 

for i=1:ITER,
  u = BoundMirrorEnsure(u);
  v = BoundMirrorEnsure(v);
  u = u + mu*4*del2(u)- Sqrf.*(u-fx);
  v = v + mu*4*del2(v)- Sqrf.*(v-fy);
end
u = BoundMirrorShrink(u);
v = BoundMirrorShrink(v);

