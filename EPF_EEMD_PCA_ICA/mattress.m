clc;clear;clf;
fs=200;
L=1024;%采样点数
t0=1/fs;%采样间隔
t=0:1/fs:1023/fs;
x1=importdataFromtxt('D:\matlab workspace\11_11data\data0089.txt','tmp.txt');
y=x1';
figure(1);
subplot(2,1,1);
plot(t,y,'k');
xlim([0,5]);
% ylabel('原信号s(t)');
ylabel(strcat('Source Signal s(t)'),'FontName','Times News Roman','FontSize',16);

%eemd
imf1=eemd(y,0.1,100);
m=size(imf1,2);
%去掉原信号
imf=imf1(:,2:m);
m=m-1;

%pca

[coeff,score,latent]=pca(imf);
tranMatrix=coeff(:,1:3);
X=imf-repmat(mean(imf),1024,1);    %测试样本减去均值
y2=X*tranMatrix;


%robustica
s=robustica(y2', [], 1e-3, 1e3, 0, 'r', 0);
[p,q]=size(s);
for i=1:p;
    a=corrcoef(s(i,:),x1);
    corr3(i)=a(1,2);
end
corrcoef3=max(abs(corr3));
for i=1:p;
    if abs(corr3(i))==corrcoef3
        mark=i
    end
end
subplot(2,1,2);
plot(t,s(mark,:),'k');
xlim([0,5]);
% ylabel('本算法处理后y(t)');
ylabel(strcat('BSS y(t)'),'FontName','Times News Roman','FontSize',16);
xlabel('Time(s)','FontName','Times News Roman','FontSize',16);

