clc;clear;clf;
t=0:0.002:9.998;
% t=0:0.002:3.998;
Num=5000;
x1=load('D:\matlab workspace\adaptive bbs\ECG_data.txt');
x1=x1(1:Num)';
ii=0;


for j=0:0.025:1
 ii=ii+1;   
% y= awgn(x1,j,'measured');
x2=j*sin(2*pi*40*t);
% x2=j*sin(2*pi*40*t).*(1+sin(2*pi*80*t));

y=x1+x2;
snr(ii)=SNR_singlech(x1,y);
nsr(ii)=1/snr(ii);

%eemd
imf1=eemd(y,0.1,100);
m=size(imf1,2);
%去掉原信号
imf=imf1(:,2:m);
m=m-1;
%计算每个IMF分量及最后一个剩余分量residual与原始信号的相关性 
for i=1:m;
a=corrcoef(imf(:,i),y);
xg(i)=a(1,2);
end
xg;

%pca
[coeff,score,latent]=pca(imf);
%将latent总和统一为100，便于观察贡献率 
latent=100*latent/sum(latent);
% pareto(latent);%调用matlab画图
tranMatrix=coeff(:,1:3);
X=imf-repmat(mean(imf),Num,1);    %测试样本减去均值
y2=X*tranMatrix;

 m=size(y2,2);

% eemd-pca-ica
y3=ICA(y2');
%  p=size(imf,2);
%计算还原信号与原始信号的相关系数
for i=1:m;
    a=corrcoef(y3(i,:),x1);
    corr1(ii,i)=a(1,2);
end
corrcoef1(ii)=max(abs(corr1(ii,:)));


%eemd-pca-robustia
y4=robustica(y2', [], 1e-3, 1e3, 0, 'r', 0);
for i=1:m;
    a=corrcoef(y4(i,:),x1);
    corr4(ii,i)=a(1,2);
end
corrcoef4(ii)=max(abs(corr4(ii,:)));


%robustica
s=robustica(y2', [], 1e-3, 1e3, 0, 'r', 0);

for i=1:m;
    a=corrcoef(s(i,:),x1);
    corr2(ii,i)=a(1,2);
end
corrcoef2(ii)=max(abs(corr2(ii,:)));


%eemd-robustica
% s1= robustica(imf', [], 1e-3, 1e3, 0, 'r', 0);
s1=ICA(imf');
p=size(imf,2);
for i=1:p;
    a=corrcoef(s1(i,:),x1);
    corr3(ii,i)=a(1,2);
end
corrcoef3(ii)=max(abs(corr3(ii,:)));



 end
figure(1);
hold on;
plot(nsr,corrcoef2,'ok-');
plot(nsr,corrcoef1,'^k-');
plot(nsr,corrcoef3,'*k-');
%plot(nsr,corrcoef4,'dk-');
% xlabel('NSR');
xlabel('NSR','FontName','Times News Roman','FontSize',16);
% ylabel( 'correlation coefficient');
ylabel(strcat('correlation coefficient'),'FontName','Times News Roman','FontSize',16);
%legend('EPF-EEMD-PCA-ICA','EEMD—ICA','EEMD-PCA-ICA','EPSE-EEMD-PCA-ICA','0');
legend('EPF-EEMD-PCA-ICA','EEMD-PCA-ICA','EEMD—ICA','0');
hold off;
