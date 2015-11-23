function FWT=wft(f,g)
Lf=length(f);
Lg=length(g);
FWT=zeros(Lf+Lg,Lg);%时频域的频谱密度?
fleft=fliplr(f(1:Lg));%镜像函数?
fright=fliplr(f(Lf-Lg+1:Lf));%镜像函数?
%fleft=f(Lf-Lg+1:Lf);%周期延拓
%fright=f(1:Lg);%周期延拓?
%fleft=zeros(1,Lg);%补零?
%fright=zeros(1,Lg);%补零
fn=[fleft,f,fright];
for m=1:Lf+Lg; %m对应离散的时间????
    ft=fn(m:m+Lg-1).*g;
    FWT(m,:)=fft(ft);%?求fft(对应m时刻的频谱)?
end