function [f,z]=fftfenxi(t,y)
L=length(t);
N=2^nextpow2(L);
%fftĬ�ϼ�����ź��Ǵ�0��ʼ��
t=linspace(t(1),t(L),N);deta=t(2)-t(1);
m=0:N-1;
f=1./(N*deta)*m;
%��������Y����x(t)�ĸ���Ҷ�任��ֵ

Y=fft(y);
Y(1)=0;
z=sqrt(Y.*conj(Y));
