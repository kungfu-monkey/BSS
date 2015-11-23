function waveTransform(s)
     fs=200;                          %采样频率
     t=0:1/fs:1;
     %小波时频图绘制
     wavename='cmor3-3';
     totalscal=256;                    %尺度序列的长度，即scal的长度
     wcf=centfrq(wavename);            %小波的中心频率
     cparam=2*wcf*totalscal;           %为得到合适的尺度所求出的参数
     a=totalscal:-1:1;  
     scal=cparam./a;                   %得到各个尺度，以使转换得到频率序列为等差序列
     coefs=cwt(s,scal,wavename);       %得到小波系数
     f=scal2frq(scal,wavename,1/fs);   %将尺度转换为频率
     imagesc(t,f,abs(coefs));          %绘制色谱图
     colorbar;
     xlabel('时间 t/s');
     ylabel('频率 f/Hz');
