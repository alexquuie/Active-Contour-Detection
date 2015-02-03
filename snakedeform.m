function [x,y] = snakedeform(x,y,alpha,beta,gamma,u,v,ITER)

u = BoundMirrorExpand(u);
v = BoundMirrorExpand(v);
[ux uy]=gradient(u);
[vx vy]=gradient(v);
div=divergence(u,v);
ux = BoundMirrorShrink(ux);
uy = BoundMirrorShrink(uy);
vx = BoundMirrorShrink(vx);
vy = BoundMirrorShrink(vy);
u = BoundMirrorShrink(u);
v = BoundMirrorShrink(v);

N = length(x);


for count = 1:ITER
    %Take derivate of x,y
    x_pre = x;
    x_post= [x(size(x,1),1);x(1:size(x,1)-1,1)];
    xp=x_pre-x_post;
    y_pre = y;
    y_post= [y(size(y,1),1);y(1:size(y,1)-1,1)];
    yp=y_pre-y_post;
    
    %Take second derivate of x,y
    xp_pre =[x(size(x,1),1);x(1:size(x,1)-1,1)];
    xp_middle = x;
    xp_post= [x(2:size(x,1),1);x(1,1)];    
    xpp=xp_pre-2*xp_middle+xp_post;
    
    yp_pre = [y(size(y,1),1);y(1:size(y,1)-1,1)];
    yp_middle = y;
    yp_post= [y(2:size(y,1),1);y(1,1)];    
    ypp=yp_pre+yp_post-2*yp_middle;
    
    %Normalize the normal
    cp = sqrt(xp.*xp+yp.*yp);
    nyp=yp./cp;
    nxp=xp./cp;
    
    %Curvature
    kp=(ypp.*xp-xpp.*yp)./(cp.^3);
    
    %Interpolate the ux & vy
    ux_tmp = interp2(ux,x,y,'*linear');
    vy_tmp = interp2(vy,x,y,'*linear');
    div_tmp = interp2(div,x,y,'*linear');
%     f_tmp = interp2(f,x,y,'*linear');
    
   % deform snake
   x =  (gamma*x -alpha*kp.*nyp-beta*nyp.*(ux_tmp+vy_tmp))/gamma;
   y =  (gamma*y +alpha*kp.*nxp+beta*nxp.*(ux_tmp+vy_tmp))/gamma;
end

