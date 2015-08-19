   clear;
   close all;
   clc;
%    path('snake', path); 
%%
     I = imread('images/u64.pgm');
     for i=1:256,
       map(i,[1:3])=[i/256,i/256,i/256];
    end;
    
    I=im2double(I);
    I=I*255;
    
    %Compute its edge map
     f = 1 - I/255; 

   % Compute the GVF of the edge map f   
     disp('Computing GVF, please wait....');  
     [u,v] = GVF(f, 0.2, 80); 
   %Normalize the edge map
     mag = sqrt(u.*u+v.*v);
     pu = u./(mag+1e-10); pv = v./(mag+1e-10); 

  % display the results
     figure(1); 
     subplot(221); imdisp(I); title('test image');
     subplot(222); imdisp(f); title('edge map');

     % display the gradient of the edge map
     [fx,fy] = gradient(f); 
     subplot(223); quiver(fx,fy); 
     axis off; axis equal; axis 'ij';     % fix the axis 
     title('edge map gradient');

     % display the GVF 
     subplot(224); quiver(pu,pv);
     axis off; axis equal; axis 'ij';     % fix the axis 
     title('normalized GVF field');
     subplot(221);
     image(((1-f)+1)*40); 
     axis('square', 'off');
     colormap(gray(64)); 
     t = 0:0.05:6.28;
     x = 32 + 25*cos(t);
     y = 32 + 25*sin(t);
% If you want to initialize the contour by hand, please use the
% following codes
%      delta = 1;
%      [x,y] = snakeinit(delta);
       [x,y] = snakeinterp(x,y,2,0.5);

     snakedisp(x,y,'r');     
     title(['Initial Contour ']);   
     pause(2);
     
     internal_iteration=10;
     for i=1:70
       [x,y] = snakedeform(x,y,0.10,1,0.5,u,v,internal_iteration);
       [x,y] = snakeinterp(x,y,2,0.5);
       if mod(i,5)==0  
           snakedisp(x,y,'r') 
           title(['Deformation in progress,  iter = ' num2str(i*internal_iteration)])
           pause(0.5);
       end
   end

     disp(' Press any key to display the final result');
     pause;
     
     figure, colormap(gray(64)); image(((1-f)+1)*40); axis('square', 'off');
     snakedisp(x,y,'r') 
     title(['Final result,  iter = ' num2str(i*5)]); 
     
     figure,quiver(pu,pv)
     axis off; axis equal; axis 'ij';     % fix the axis
     title('Smoothed Vector field of U64');
     pause;
   
   %% pacman
   clear;
   close all;
   clc;
     I= imread('images/pacman.pgm');  

     for i=1:256,
       map(i,[1:3])=[i/256,i/256,i/256];
    end;
    
    I=im2double(I);
    I=I*255;
    
    % Compute its edge map
    f = 1 - I/255; 

   % Compute the GVF of the edge map f
   disp('Computing GVF, please wait....');  
   [u,v] = GVF(f, 0.2, 1000); 
     
   % Nomalizing the GVF external force
     mag = sqrt(u.*u+v.*v);
     pu = u./(mag+1e-10); pv = v./(mag+1e-10); 

  % display the results
     figure(1); 
     subplot(221); imdisp(I); title('test image');
     subplot(222); imdisp(f); title('edge map');

     % display the gradient of the edge map
     [fx,fy] = gradient(f); 
     subplot(223); quiver(fx,fy); 
     axis off; axis equal; axis 'ij';     % fix the axis 
     title('edge map gradient(image is too big to show)');

     % display the GVF 
     subplot(224); quiver(pu,pv);
     axis off; axis equal; axis 'ij';     % fix the axis 
     title('GVF (image is too big to show)');
     
     subplot(221);
     image(((1-f)+1)*40); 
     axis('square', 'off');
     colormap(gray(64)); 
     t = 0:0.05:6.28;
     x = 100 + 57*cos(t);
     y = 110 + 57*sin(t);
% If you want to initialize the contour by hand, please use the
% following codes
%    delta = 1;
%    [x,y] = snakeinit(delta);
     [x,y] = snakeinterp(x,y,2,0.5);
     snakedisp(x,y,'r');
     title(['Initial Contour ']);   
     pause(2);
     internal_iteration=5;
     for i=1:250
       [x,y] = snakedeform(x,y,0.1,1,0.5,u,v,internal_iteration);      
       [x,y] = snakeinterp(x,y,2,0.5);
       if mod(i,20)==0  
           snakedisp(x,y,'r') 
           title(['Deformation in progress,  iter = ' num2str(i*internal_iteration)])
           pause(0.5);
       end
     end

   
     disp(' Press any key to display the final result');
     pause;
     
     figure, colormap(gray(64)); image(((1-f)+1)*40); axis('square', 'off');
     snakedisp(x,y,'r') 
     title(['Final result,  iter = ' num2str(i*5)]);   
     axis off; axis equal; axis 'ij';     % fix the axis
     title('Smoothed Vector field of Pacman');
