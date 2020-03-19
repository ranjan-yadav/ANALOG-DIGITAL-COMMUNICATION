clc;
clear all;
close all;
f=2; %MSG_FREQ
am=4; %MSG_AMP
n=3; %NUMBER OF BITS
l=2^n; %NUMBER OF LEVELS
t=linspace(0,1,1000);
msg=am*sin(2*pi*f*t); %MSG GENERATION
subplot(3,1,1);
plot(t,msg);
title('message');


subplot(3,1,2)
stem(t,msg);
title('sampled signal');

vmax=am;
vmin=-am;
ss=(vmax-vmin)/l;
del=ss/2;
part=vmin:ss:vmax;
code=vmin-del:ss:vmax+del;
[ind,q]=quantiz(msg,part,code); %QUANTIZATION

for i=1:length(ind)
    if(ind(i)~=0)
        ind(i)=ind(i)-1;
    end
end

for i=1:length(q)
    if(q(i)==vmin-del)
        q(i)=vmin+del;
    end
end

subplot(3,1,3)
plot(t,q);
title('quantized signal');

code=de2bi(ind,'left-msb');
k=1;
for i=1:length(ind)
    for j=1:n
        coded(k)=code(i,j);
        k=k+1;
    end
end
figure(2);
subplot(3,1,1)
stem(coded);
title('Encoded signal');

decod=reshape(coded,n,length(coded)/n);
index=bi2de(decod','left-msb');
a=(((ss*index)+vmin+del));
subplot(3,1,2)
plot(t,a);
title('DECODEd signal');

w=2*pi*f/1000;
n=-500:500;
demod=4*filter(((w/pi).*sinc(w.*n)),1,a);
subplot(3,1,3)
plot(t,demod);
axis([0.5 1 -9 9]);
title('Demodulated signal');



