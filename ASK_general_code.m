clc;clear all;close all;
t=linspace(0,1,1000);
n=3; %%put number of bits __change it acc to need 
M=2^n;%%evel
fc=40;%%carrier_freq
tb=0.1;%%bit duration
carrier=sqrt(2/tb)*cos(2*pi*fc*t);
subplot(3,1,1);
plot(t,carrier);
xlabel('T');
ylabel('AMP');
title('CARR');
count=0;
i=0;
while i~=1000
   msg(i+1)=randi([0,M-1]);
   j=0;
    while j~=100
        msg(i+1+j)=msg(i+1);
       j=j+1;
    end
    i=i+100;
    count=count+1;
end
subplot(3,1,2);
plot(t,msg);
xlabel('T');
ylabel('AMP');
title('MSG');

mod=msg.*carrier;
subplot(3,1,3);
plot(t,mod);
xlabel('T');
ylabel('AMP');
title('MOD');

v=carrier.*mod;
syms t;
y=int(v,t,0,1);
t=linspace(0,1,1000);
y=double(y);

x= reshape(y,100,10);
meanism=mean(x);
demod=(1/10)*ceil(meanism);

figure(2);
plot(t,msg);
xlabel('TIME');
ylabel('AMPLITUDE');
title('MESSAGE');

for i=1:10
    for j=1:100
        demodulation(j+(i-1)*100)=demod(i);
    end
end
figure(3);
plot(t,demodulation);
xlabel('TIME');
ylabel('AMPLITUDE');
title('DEMODULATED');


















