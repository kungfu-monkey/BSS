clc;clear;clf;
L=200;
t=0:1:L;
x=cos(1/25*pi*t)+0.6*cos(2/25*pi*t)+0.5*sin(1/100*pi*t);
% x=sin(2*pi*40*t).*(1+sin(2*pi*80*t));
%求极值点位置
maxmiumP=find(diff(sign(diff(x)))==-2)+1;
minimiumP=find(diff(sign(diff(x)))==2)+1;
%求极值
maxmiumV=x(find(diff(sign(diff(x)))==-2)+1);
minimiumV=x(find(diff(sign(diff(x)))==2)+1);
%求样条插值系数矩阵及多项式函数
up=csape(maxmiumP,maxmiumV,'second');
upy=ppval(up,t);
down=csape(minimiumP,minimiumV,'second');
downy=ppval(down,t);
hold on;
plot(t,x,'k');
% plot(t,upy,'b--',t,downy,'r--');
plot(t,upy,'k.',t,downy,'k-.');

tic;
%端点处理
% yleft1=x(1);
% yleft1(2:4)=maxmiumV(1:3);
yleft1=maxmiumV(1:3);
z=zfun(x(1),yleft1);
ym1=x(1)+x(1)*z;
ym2=maxmiumV(1)-x(1)*z;
ysm=max(ym1,ym2);%左端点引入的极大值

yleft2=minimiumV(1:3);
z1=zfun(x(1),yleft2);
yn1=x(1)-x(1)*z1;
yn2=minimiumV(1)+x(1)*z1;
ysn=min(yn1,yn2);%左端点引入的极小值

len=size(maxmiumV,2);
yright1=maxmiumV(len-2:len);
r=zfun(x(L),yright1);
N=size(x,2);
rm1=x(N)+x(N)*r;
rm2=maxmiumV(len)-x(N)*r;
rsm=max(rm1,rm2);%右端点引入的极大值

len1=size(minimiumV,2);
yright2=minimiumV(len1-2:len1);
r1=zfun(x(L),yright2);
rn1=x(N)-x(N)*r1;
rn2=minimiumV(len1)+x(N)*r1;
rsn=min(rn1,rn2);%右端点引入的极小值

%加入预测的4个极值
maxP(1)=1;
maxP(2:len+1)=maxmiumP;
maxP(len+2)=N;

minP(1)=1;
minP(2:len1+1)=minimiumP;
minP(len1+2)=N;

maxV(1)=ysm;
maxV(2:len+1)=maxmiumV;
maxV(len+2)=rsm;

minV(1)=ysn;
minV(2:len1+1)=minimiumV;
minV(len1+2)=rsn;

up1=csape(maxP,maxV,'second');%注意坐标是从5开始的，故要+4
upy1=ppval(up1,t);
down1=csape(minP,minV,'second');
downy1=ppval(down1,t);

% plot(t,upy1,'m-.',t,downy1,'g-.');
plot(t,upy1,'kx',t,downy1,'k:');
ylabel(strcat('Simulate single n(t)'),'FontName','Times News Roman','FontSize',16);
xlabel('Time(s)','FontName','Times News Roman','FontSize',16);
% plot(t,downy1,'g-.');
legend('源信号','上包络','下包络','EPF处理后上包络','EPF处理后下包络','-1');

hold off;
toc;
%  feature('memstats');
