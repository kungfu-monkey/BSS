clc;clear;clf;
N=1024;%��������
Ts=0.005;%��ʱ���ж����ʱ�䣬��������
t=linspace(0,Ts*N,N);
y=importdataFromtxt('D:\matlab workspace\11_11data\data0047.txt','tmp.txt');

%��ԭʼ�źŽ��о���ģʽ�ֽ�emd
%����ÿ��IMF���������һ��ʣ�����residual��ԭʼ�źŵ������
c=eemd(y,0,1);
[m,n]=size(c);
for i=1:m;
a=corrcoef(c(i,:),y);
xg(i)=a(1,2);
end
xg;

%����ÿ��IMF���������һ��ʣ�����residual��ͼ��
figure(1);
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

%����ÿ��IMF������ʣ�����residual�ķ�Ƶ����
figure(2);
subplot(m+1,1,1);
[f,z]=fftfenxi(t,y);
plot(f,z,'k');
ylabel(int2str(m-1));
title('orignal signal');

for i=1:m-1
subplot(m+1,1,i+1);
[f,z]=fftfenxi(t,c(i,:));
plot(f,z,'k');
ylabel(['imf',int2str(i)])
end
subplot(m+1,1,m+1);
[f,z]=fftfenxi(t,c(m,:));
plot(f,z,'k');
ylabel(['r',int2str(m-1)])


%����pca��ά
y1=pca(c)';
y2=ICA(y1);
[p,q]=size(y2);
figure(3);

for i=1:p
subplot(p,1,i);
plot(t,y2(i,:));
end


deta=t(2)-t(1);
m=0:N-1;
f=1./(N*deta)*m;
figure(4);
for i=1:p
    fft_y2(i,:)=abs(fft(y2(i,:)));
    fft_y2(i,1)=0;
    subplot(p,1,i);
    plot(f,fft_y2(i,:));
end