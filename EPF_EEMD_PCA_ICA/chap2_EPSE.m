clc;clear;clf;
L=95;
t=5:1:L;
x=cos(1/25*pi*t)+0.6*cos(2/25*pi*t)+0.5*sin(1/100*pi*t);
% x=sin(2*pi*40*t).*(1+sin(2*pi*80*t));
%��ֵ��λ��
maxmiumP=find(diff(sign(diff(x)))==-2)+1+4;
minimiumP=find(diff(sign(diff(x)))==2)+1+4;
%��ֵ
maxmiumV=x(find(diff(sign(diff(x)))==-2)+1);
minimiumV=x(find(diff(sign(diff(x)))==2)+1);
%��������ֵϵ�����󼰶���ʽ����
up=csape(maxmiumP,maxmiumV,'second');
upy=ppval(up,t);
down=csape(minimiumP,minimiumV,'second');
downy=ppval(down,t);
hold on;
figure(1);
plot(t,x,'k');
plot(t,upy,'k.',t,downy,'k-.');
plot(maxmiumP,maxmiumV,'ro',minimiumP,minimiumV,'go');
ylabel(strcat('Simulate single n(t)'),'FontName','Times News Roman','FontSize',16);
xlabel('Time(s)','FontName','Times News Roman','FontSize',16);
legend('Դ�ź�','�ϰ���','�°���','����ֵ��','��Сֵ��');


tic;
%�Գ��������ش���
maxPl=5-maxmiumP;
maxPr=L+maxmiumP;

minPl=5-minimiumP;
minPr=L+minimiumP;

% maxP=[maxPl maxmiumP maxPr];
% minP=[minPl minimiumP minPr];

%�ж���˵��Ƿ���뼫ֵ������
if x(1)>=maxmiumV(1)
    maxV=[fliplr(maxmiumV) x(1) maxmiumV];%fliplr��������������
    maxP=[fliplr(maxPl) 1 maxmiumP];
else 
    maxV=[fliplr(maxmiumV)  maxmiumV];
    maxP=[fliplr(maxPl)  maxmiumP];
end

if x(1)<=minimiumV(1)
    minV=[fliplr(minimiumV) x(1) minimiumV];
    minP=[fliplr(minPl) 1  minimiumP];
else
    minV=[fliplr(minimiumV) minimiumV];
     minP=[fliplr(minPl)   minimiumP];
end

N=size(maxmiumV,2);
%�ж��Ҷ˵��Ƿ���뼫ֵ������
if x(L-5+1)>=maxmiumV(N)
    maxV=[maxV x(L-5+1) fliplr(maxmiumV)];
    maxP=[maxP L fliplr(maxPr)];
else
    maxV=[maxV  fliplr(maxmiumV)];
    maxP=[maxP  fliplr(maxPr)];
end

M=size(minimiumV,2);
if x(L-5+1)<=minimiumV(M)
    minV=[minV x(L-5+1) fliplr(minimiumV)];
    minP=[minP L fliplr(minPr)];
else
    minV=[minV  fliplr(minimiumV)];
    minP=[minP  fliplr(minPr)];
end

figure(2);
hold on;
plot(t,x,'k');
% t=-L:1:2*L;
t=-86:1:186;
up1=csape(maxP,maxV,'second');
upy1=ppval(up1,t);
down1=csape(minP,minV,'second');
downy1=ppval(down1,t);

plot(t,upy1,'k.',t,downy1,'k-.');
plot(maxP,maxV,'ro',minP,minV,'go')
xlim([-80,180]);
ylabel(strcat('Simulate single n(t)'),'FontName','Times News Roman','FontSize',16);
xlabel('Time(s)','FontName','Times News Roman','FontSize',16);
legend('Դ�ź�','�ϰ���','�°���','����ֵ��','��Сֵ��');

hold off;
toc;
%  feature('memstats');
