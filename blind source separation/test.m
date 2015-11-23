clc;clear;clf;
% t=-2*pi/10:pi/1024:2*pi/10
t=0:0.0005:1;
x1=2*sin(2*pi*40*t);
x2=3*square(2*pi*100*t,50);
figure(1);
subplot(3,1,1)
plot(t,x1,'b')
subplot(3,1,2)
plot(t,x2,'b')
grid
ylim([-3.5,3.5])
y=x1+x2;
subplot(3,1,3)
plot(t,y,'b');
%对原始信号进行经验模式分解emd
%计算每个IMF分量及最后一个剩余分量residual与原始信号的相关性
c=emd(y);
[m,n]=size(c);
for i=1:m;
a=corrcoef(c(i,:),y);
xg(i)=a(1,2);
end
xg;

%画出每个IMF分量及最后一个剩余分量residual的图形
figure(2);
subplot(m+1,1,1)
plot(t,y)
title('orignal signal');
ylabel('Amplitude');

for i=1:m-1;
subplot(m+1,1,i+1);
plot(t,c(i,:),'k');
ylabel(['imf',int2str(i)]);
end

subplot(m+1,1,m+1);
plot(t,c(m,:),'k');
ylabel(['r',int2str(m)]);



%进行pca降维
y1=pca(c)';
y2=ICA(y1);
[p,q]=size(y2);
figure(3);

for i=1:p
subplot(p,1,i);
plot(t,y2(i,:));
end



