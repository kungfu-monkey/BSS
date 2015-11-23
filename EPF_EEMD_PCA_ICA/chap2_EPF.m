clc;clear;clf;
L=95;
t=5:1:L;
x=cos(1/25*pi*t)+0.6*cos(2/25*pi*t)+0.5*sin(1/100*pi*t);
% x=sin(2*pi*40*t).*(1+sin(2*pi*80*t));
%求极值点位置
% maxmiumP=find(diff(sign(diff(x)))==-2)+1;
% minimiumP=find(diff(sign(diff(x)))==2)+1;
maxmiumP=find(diff(sign(diff(x)))==-2)+5;
minimiumP=find(diff(sign(diff(x)))==2)+5;
%求极值
maxmiumV=x(find(diff(sign(diff(x)))==-2)+1);
minimiumV=x(find(diff(sign(diff(x)))==2)+1);
%求样条插值系数矩阵及多项式函数
up=csape(maxmiumP,maxmiumV,'second');
upy=ppval(up,t);
down=csape(minimiumP,minimiumV,'second');
downy=ppval(down,t);
hold on;
figure(1)
plot(t,x,'k');
xlim([5,95]);
% plot(t,upy,'b--',t,downy,'r--');
plot(t,upy,'k.',t,downy,'k-.');
plot(maxmiumP,maxmiumV,'ro');
plot(minimiumP,minimiumV,'go');
ylabel(strcat('Simulate single n(t)'),'FontName','Times News Roman','FontSize',16);
xlabel('Time(s)','FontName','Times News Roman','FontSize',16);
legend('源信号','上包络','下包络','极大值点','极小值点');

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
r=zfun(x(L-5+1),yright1);
N=size(x,2);
rm1=x(N)+x(N)*r;
rm2=maxmiumV(len)-x(N)*r;
rsm=max(rm1,rm2);%右端点引入的极大值

len1=size(minimiumV,2);
yright2=minimiumV(len1-2:len1);
r1=zfun(x(L-5+1),yright2);
rn1=x(N)-x(N)*r1;
rn2=minimiumV(len1)+x(N)*r1;
rsn=min(rn1,rn2);%右端点引入的极小值

%加入预测的4个极值
maxP(1)=1+4;                   %注意坐标是从5开始的，故要+4
maxP(2:len+1)=maxmiumP;
maxP(len+2)=N+4;

minP(1)=1+4;
minP(2:len1+1)=minimiumP;
minP(len1+2)=N+4;

maxV(1)=ysm;
maxV(2:len+1)=maxmiumV;
maxV(len+2)=rsm;

minV(1)=ysn;
minV(2:len1+1)=minimiumV;
minV(len1+2)=rsn;

up1=csape(maxP,maxV,'second');
upy1=ppval(up1,t);
down1=csape(minP,minV,'second');
downy1=ppval(down1,t);

figure(2);
hold on;
plot(t,x,'k');
xlim([4,95]);
% plot(t,upy1,'m-.',t,downy1,'g-.');
plot(t,upy1,'k.',t,downy1,'k-.');

% plot(maxmiumP,maxmiumV,'ro');
% plot(minimiumP,minimiumV,'go');
% plot(maxP(1),maxV(1),'r+',maxP(len+2),maxV(len+2),'r+');
% plot(minP(1),minV(1),'g+',minP(len1+2),minV(len1+2),'g+');
plot(maxP,maxV,'ro');
plot(minP,minV,'go');

ylabel(strcat('Simulate single n(t)'),'FontName','Times News Roman','FontSize',16);
xlabel('Time(s)','FontName','Times News Roman','FontSize',16);

legend('源信号','上包络','下包络','极大值点','极小值点');