function snr=SNR_singlech(I,In)
% 计算信噪比函数
% I :original signal
% In:noisy signal(ie. original signal + noise signal)
% snr=0;
% Ps=0;
% Pn=0;
Ps=sum(sum((I-mean(mean(I))).^2));%signal power
Pn=sum(sum((I-In).^2));           %noise power
% len=size(I,2);
% for i=1:len
%     Ps=Ps+I(i).^2;
%     Pn=Pn+(In(i)-I(i)).^2;
% end
% snr=10*log10(Ps/Pn);
snr=sqrt(Ps/Pn);

