clear;clc;
%f0=5;????%正弦信号频率?
fs=20;%采样频率?
T=20;%信号时间长度?
L=fs*T+1;%采样点数2^n??为何L取2^nextpow2(fs*T)时，频谱变样？
t=T/(L-1);%采样间隔?
x=0:t:T;
f=sin(0.4*pi*x.^2);%chip信号sin(0.4*pi*t^2)
figure(1);
subplot(3,2,1);
plot(x,f);
xlabel('Time/s');
ylabel('Amplitude');%title('f(t)');?
axis([0 20 -1.2 1.2]);
grid on;
y=-2:t:2;%窗口范围为[-2,2]?
L2=length(y);
g=zeros(1,length(y));%rectangle?window
g(21:61)=1;
L2=length(g);
normofg=norm(g,2);
g=g/normofg;
subplot(3,2,2);
plot(y,g);
xlabel('Time/s');
ylabel('Amplitude');%%title('g(t)');
grid on;
FWT=wft(f,g);%wft?of?f?
fwt=zeros(L,fix(L2/2)+1);%显示的频谱
w=fs/2*linspace(0,1,L2/2+1);
for n=1:L;
    fwt(n,:)=abs(FWT(n+fix(L2/2),1:fix(L2/2)+1));
end
subplot(3,2,3);
mesh(x,w,fwt');%F(w,t)的频谱,x-time,w-frequence?
xlabel('Time/s');ylabel('Frequence/Hz');%title('WFT');
subplot(3,2,4);
pcolor(x,w,fwt');
xlabel('Time/s');ylabel('Frequence/Hz');%title('WFT');
shading interp;
