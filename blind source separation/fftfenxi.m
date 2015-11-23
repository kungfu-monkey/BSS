function [f,z]=fftfenxi(t,y)
L=length(t);
N=2^nextpow2(L);
%fft默认计算的信号是从0开始的
t=linspace(t(1),t(L),N);deta=t(2)-t(1);
m=0:N-1;
f=1./(N*deta)*m;
%下面计算的Y就是x(t)的傅里叶变换数值

Y=fft(y);
Y(1)=0;
z=sqrt(Y.*conj(Y));
