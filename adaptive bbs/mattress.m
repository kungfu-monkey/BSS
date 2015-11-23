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


% %robustica
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

% figure(2);
% % waveTransform(y);
% p=-2:t0:2;%窗口范围为[-2,2]?
% L2=length(p);
% g=zeros(1,length(p));%rectangle?window
% g(201:601)=1;
% L2=length(g);
% normofg=norm(g,2);
% g=g/normofg;
% FWT=wft(y,g);
% fwt=zeros(L,fix(L2/2)+1);%显示的频谱
% w=fs/2*linspace(0,1,L2/2+1);
% for n=1:L;
%     fwt(n,:)=abs(FWT(n+fix(L2/2),1:fix(L2/2)+1));
% end
% subplot(1,2,1);
% mesh(t,w,fwt');%F(w,t)的频谱,x-time,w-frequence?
% xlabel('Time/s');ylabel('Frequence/Hz');%title('WFT');
% subplot(1,2,2);
% % plot(p,g);
% pcolor(t,w,fwt');
% xlabel('Time/s');ylabel('Frequence/Hz');%title('WFT');
% shading interp;
% 
% figure(3);
% % waveTransform(s(mark,:));
% FWT=wft(s(mark,:),g);
% fwt=zeros(L,fix(L2/2)+1);%显示的频谱
% w=fs/2*linspace(0,1,L2/2+1);
% for n=1:L;
%     fwt(n,:)=abs(FWT(n+fix(L2/2),1:fix(L2/2)+1));
% end
% subplot(1,2,1);
% mesh(t,w,fwt');%F(w,t)的频谱,x-time,w-frequence?
% xlabel('Time/s');ylabel('Frequence/Hz');%title('WFT');
% subplot(1,2,2);
% % plot(p,g);
% pcolor(t,w,fwt');
% xlabel('Time/s');ylabel('Frequence/Hz');%title('WFT');
% shading interp;
% 
% figure(4);
% n=0:1:1023;
% fft_y=abs(fft(y));
% fft_y(1)=0;
% % hold on;
% plot(n,fft_y,'b--');
% figure(5);
% fft_s=abs(fft(s(mark,:)));
% fft_s(1)=0;
% plot(n,fft_s,'r-');
% % hold off;
% % legend('s(t)频谱','y(t)频谱','0');

