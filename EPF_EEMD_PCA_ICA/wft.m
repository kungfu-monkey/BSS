function FWT=wft(f,g)
Lf=length(f);
Lg=length(g);
FWT=zeros(Lf+Lg,Lg);%ʱƵ���Ƶ���ܶ�?
fleft=fliplr(f(1:Lg));%������?
fright=fliplr(f(Lf-Lg+1:Lf));%������?
%fleft=f(Lf-Lg+1:Lf);%��������
%fright=f(1:Lg);%��������?
%fleft=zeros(1,Lg);%����?
%fright=zeros(1,Lg);%����
fn=[fleft,f,fright];
for m=1:Lf+Lg; %m��Ӧ��ɢ��ʱ��????
    ft=fn(m:m+Lg-1).*g;
    FWT(m,:)=fft(ft);%?��fft(��Ӧmʱ�̵�Ƶ��)?
end