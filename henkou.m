%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
set(gca,'nextplot','replacechildren'); 
set(gcf, 'color', 'black');
set(gca, 'color', 'black');
set(gcf, 'InvertHardCopy', 'off');
set(gca,'XColor','w')
set(gca,'YColor','w')
set(gca,'ZColor','w')

t=1:1000;
hold on
view([21 24 ])
plot3(t,t*0,t*0,'w');
plot3(0*t,(t-500)/500,0*t,'w');
plot3(0*t,0*t,(t-500)/500,'w');
axis off

for k=1:1000;
    a1=[cos(2*pi*k/250); cos(2*pi*k/250-pi/2)];
    a2=[cos(2*pi*k/250); cos(2*pi*k/250)];
    a3=[cos(2*pi*k/250); cos(2*pi*k/250+pi/4)];
    a=a1;
    plot3(k,a(1),a(2),'ro-',k,a(1),k*0,'b.-',k,k*0,a(2),'g.-');
    axis([0 1000 -1 1 -1 1])

    M(k) = getframe(gcf);
end
for k=1001:1100
      
       view([21+60/100*(k-1000)  24-16/100*(k-1000) ])
    M(k)=getframe(gcf);
end
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%à»è„