clc;clear;clf;
t=0:0.001:1;
x1=sin(2*pi*40*t);
x2=square(2*pi*100*t,50);
y=x1+x2;
snr=SNR_singlech(x1,y);
nsr=1/snr;
figure(1);
subplot(3,1,1);
plot(t,x1);
subplot(3,1,2);
plot(t,x2);
% grid;
% ylim([-3.5,3.5]);
subplot(3,1,3);
plot(t,y);

%eemd
imf1=eemd(y,1.41,100);
m=size(imf1,2);
%去掉原信号
% for i=1:m-1
%     imf(:,i)=imf1(:,i+1);
% end
imf=imf1(:,2:m);
m=m-1;
figure(2);
for i=1:m
    subplot(m,1,i);
    plot(t,imf(:,i));
end
%计算每个IMF分量及最后一个剩余分量residual与原始信号的相关性 
for i=1:m;
a=corrcoef(imf(:,i),y);
xg(i)=a(1,2);
end
xg;

%pca
figure(3);
[coeff,score,latent]=pca(imf);
%将latent总和统一为100，便于观察贡献率 
latent=100*latent/sum(latent);
pareto(latent);%调用matlab画图
tranMatrix=coeff(:,1:3);
X=imf-repmat(mean(imf),1001,1);    %测试样本减去均值
y2=X*tranMatrix;

figure(4);
m=size(y2,2);
for i=1:m
    subplot(m,1,i);
    plot(t,y2(:,i));
end

%ICA
y3=ICA(y2');
[p,q]=size(y3);
figure(5);
for i=1:p
    subplot(p,1,i);
    plot(t,y3(i,:));
end
%计算还原信号与原始信号的相关系数
for i=1:m;
    a=corrcoef(y3(i,:),x1);
    corr1(i)=a(1,2);
end
corrcoef1=max(abs(corr1));

for i=1:m;
    a=corrcoef(y3(i,:),x2);
    corr2(i)=a(1,2);
end
corrcoef2=max(abs(corr2));

%robustica
s=robustica(y2', [], 1e-3, 1e3, 0, 'r', 0);
[p,q]=size(s);
figure(6);
for i=1:p
    subplot(p,1,i);
    plot(t,s(i,:));
end

for i=1:m;
    a=corrcoef(s(i,:),x1);
    corr3(i)=a(1,2);
end
corrcoef3=max(abs(corr3));

for i=1:m;
    a=corrcoef(s(i,:),x2);
    corr4(i)=a(1,2);
end
corrcoef4=max(abs(corr4));
% 
% 
