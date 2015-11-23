clc;clear;clf;
L=95;
t=5:1:L;
x=cos(1/25*pi*t)+0.6*cos(2/25*pi*t)+0.5*sin(1/100*pi*t);
% x=sin(2*pi*40*t).*(1+sin(2*pi*80*t));
%��ֵ��λ��
% maxmiumP=find(diff(sign(diff(x)))==-2)+1;
% minimiumP=find(diff(sign(diff(x)))==2)+1;
maxmiumP=find(diff(sign(diff(x)))==-2)+5;
minimiumP=find(diff(sign(diff(x)))==2)+5;
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
xlim([5,95]);
% plot(t,upy,'b--',t,downy,'r--');
plot(t,upy,'k.',t,downy,'k-.');

ylabel(strcat('Simulate single n(t)'),'FontName','Times News Roman','FontSize',16);
xlabel('Time(s)','FontName','Times News Roman','FontSize',16);

legend('Դ�ź�','�ϰ���','�°���','EPF������ϰ���','EPF������°���','-1');