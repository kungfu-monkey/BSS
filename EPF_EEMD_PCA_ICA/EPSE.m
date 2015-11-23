clc;clear;clf;
L=2000;
t=0:1:L;
x=cos(1/25*pi*t)+0.6*cos(2/25*pi*t)+0.5*sin(1/100*pi*t);
% x=sin(2*pi*40*t).*(1+sin(2*pi*80*t));
%��ֵ��λ��
maxmiumP=find(diff(sign(diff(x)))==-2)+1;
minimiumP=find(diff(sign(diff(x)))==2)+1;
%��ֵ
maxmiumV=x(find(diff(sign(diff(x)))==-2)+1);
minimiumV=x(find(diff(sign(diff(x)))==2)+1);
%��������ֵϵ�����󼰶���ʽ����
up=csape(maxmiumP,maxmiumV,'second');
upy=ppval(up,t);
down=csape(minimiumP,minimiumV,'second');
downy=ppval(down,t);
hold on;
plot(t,x,'k');
plot(t,upy,'b--',t,downy,'r--');

tic;
%�Գ��������ش���
maxPl=0-maxmiumP;
maxPr=L+maxmiumP;

minPl=0-minimiumP;
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
if x(L)>=maxmiumV(N)
    maxV=[maxV x(L) fliplr(maxmiumV)];
    maxP=[maxP L fliplr(maxPr)];
else
    maxV=[maxV  fliplr(maxmiumV)];
    maxP=[maxP  fliplr(maxPr)];
end

M=size(minimiumV,2);
if x(L)<=minimiumV(M)
    minV=[minV x(L) fliplr(minimiumV)];
    minP=[minP L fliplr(minPr)];
else
    minV=[minV  fliplr(minimiumV)];
    minP=[minP  fliplr(minPr)];
end

% t=-L:1:2*L;
up1=csape(maxP,maxV,'second');
upy1=ppval(up1,t);
down1=csape(minP,minV,'second');
downy1=ppval(down1,t);

plot(t,upy1,'m-.',t,downy1,'g-.');
% plot(t,downy1,'g-.');
legend('ԭ�ź�','�ϰ���','�°���','���������ϰ���','���������°���','-1');

hold off;
toc;
%  feature('memstats');
