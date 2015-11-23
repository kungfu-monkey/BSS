N=1024;%采样点数
Ts=0.005;%定时器中断溢出时间，采样周期
t=linspace(0,Ts*N,N);
L=1024;
x=importdataFromtxt('D:\matlab workspace\11_11data\data0089.txt','tmp.txt');
x=[x]';
plot(t,x,'k');
axis([0,5,1900,2200]);
ylabel('幅值','FontName','Times News Roman','FontSize',16);
xlabel('Time(s)','FontName','Times News Roman','FontSize',16);


