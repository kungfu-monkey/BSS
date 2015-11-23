t=0:0.005:1;
x1=sin(2*pi*8*t);
% x2=0.*(t>=0&t<0.2)+0.1*sin(2*80*pi*t).*(t>=0.2&t<0.5)+0.*(t>=0.5&t<0.7)+0.1*sin(2*80*pi*t).*(t>=0.7&t<=0.1);
x2=0.1*sin(2*80*pi*t).*((t>=0.2&t<0.5)|(t>=0.7&t<1));
x=x1+x2;
figure(1);
subplot(3,1,1);
plot(t,x1,'k');
xlabel('Time(s)','FontName','Times News Roman','FontSize',16);
ylabel(strcat('x1'),'FontName','Times News Roman','FontSize',16);
subplot(3,1,2);
plot(t,x2,'k');
xlabel('Time(s)','FontName','Times News Roman','FontSize',16);
ylabel(strcat('x2'),'FontName','Times News Roman','FontSize',16);
subplot(3,1,3);
plot(t,x,'k');
xlabel('Time(s)','FontName','Times News Roman','FontSize',16);
ylabel(strcat('x'),'FontName','Times News Roman','FontSize',16);

imf=emd(x);
len=size(imf,1);

figure(2);
for i=1:len
    subplot(len,1,i);
    plot(t,imf(i,:),'k');
    s=['imf',num2str(i)];
    ylabel(strcat(s),'FontName','Times News Roman','FontSize',16);
end
xlabel('Time(s)','FontName','Times News Roman','FontSize',16);

figure(3)
plot(t,imf(1,:),'k')
xlabel('Time(s)','FontName','Times News Roman','FontSize',16);
ylabel(strcat('IMF1'),'FontName','Times News Roman','FontSize',16);




