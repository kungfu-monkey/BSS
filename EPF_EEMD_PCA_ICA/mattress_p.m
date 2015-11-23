clc;clear;clf;
t=0:0.005:5.115;
y=importdataFromtxt('D:\matlab workspace\11_11data\data0089.txt','tmp.txt');
figure(1);
plot(t,y,'k');
xlim([0,5])
xlabel('Time(s)','FontName','Times News Roman','FontSize',16);
ylabel(strcat('�۲��ź�����'),'FontName','Times News Roman','FontSize',16);

%eemd
imf1=eemd(y,1.41,100);
m=size(imf1,2);
%ȥ��ԭ�ź�
% for i=1:m-1
%     imf(:,i)=imf1(:,i+1);
% end
imf=imf1(:,2:m);
m=m-1;
figure(2);
for i=1:m
%     subplot(m,1,i);
    subplot(5,2,i);
    plot(t,imf(:,i),'k');
    xlim([0,5])
    s=['imf',num2str(i)];
     ylabel(strcat(s),'FontName','Times News Roman','FontSize',16);
end
%����ÿ��IMF���������һ��ʣ�����residual��ԭʼ�źŵ������ 
for i=1:m;
a=corrcoef(imf(:,i),y);
xg(i)=a(1,2);
end
xg;

%pca
figure(3);
[coeff,score,latent]=pca(imf);
%��latent�ܺ�ͳһΪ100�����ڹ۲칱���� 
latent=100*latent/sum(latent);
% pareto(latent);%����matlab��ͼ
bar(latent,'k');
% title('Eigenvalues');
title('Eigenvalues','FontName','Times News Roman','FontSize',16);
tranMatrix=coeff(:,1:2);
X=imf-repmat(mean(imf),1024,1);    %����������ȥ��ֵ
y2=X*tranMatrix;

figure(4);
% m=size(y2,2);
% for i=1:m
%     subplot(m,1,i);
% %     plot(t,y2(:,i));
%      plot(t,y2(:,i),'k');
%      xlim([0,5])
%     str=['y',num2str(i),'(t)'];
%    ylabel(strcat(str),'FontName','Times News Roman','FontSize',16);
% end
 plot(t,y2(:,1),'k');
  xlim([0,5])
 ylabel('ECG��ȡ�ź�','FontName','Times News Roman','FontSize',16);

% %ICA
% y3=ICA(y2');
% [p,q]=size(y3);
% figure(5);
% for i=1:p
%     subplot(p,1,i);
%     plot(t,y3(i,:));
% end
% 
% 
% 
% %robustica
% s=robustica(y2', [], 1e-3, 1e3, 0, 'r', 0);
% [p,q]=size(s);
% figure(6);
% for i=1:p
%     subplot(p,1,i);
%     plot(t,s(i,:));
% end




