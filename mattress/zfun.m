function z=zfun(y0,y)
n=size(y,2);
elen1=0;
elen2=0;
for i=1:n
    elen1=elen1+(y(n)-mean(y)).^2;
    elen2=elen2+(y(n)-y0).^2;
%     elen1=elen1+(y(n)-mean(y));
%     elen2=elen2+y(n);
end
z=elen1/elen2;
