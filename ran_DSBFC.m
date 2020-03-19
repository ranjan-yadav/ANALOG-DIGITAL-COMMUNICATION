clc;
clear all;
close all;
Ac = 10;
Am = 8;
Fm = 100;
Fc = 1000;
Fs=10000;
t=0:0.0001:1;
f=0:1:10000;
u=Am/Ac;
mt = Am*cos(2*pi*Fm*t);
ct = Ac*cos(2*pi*Fc*t);

figure(1);
subplot(2,2,1)
plot(t,mt);
axis([0 .02 -12 12]);
xlabel('time(sec)');
ylabel('AMP');
title('MESSAGE SIGNAL');

subplot(2,2,2)
a1=abs(fft(mt));
plot(a1);
axis([0 500 0 5000]);
xlabel('freq(Hz)');
ylabel('AMP');
title('MESSAGE SIGNAL POWER SPECTRUM');

subplot(2,2,3)
plot(t,ct)
title('Carrier');
axis([0 .01 -12 12]);
xlabel('time(sec)');
ylabel('AMP');
title('CARRIER SIGNAL');

subplot(2,2,4)
a1=abs(fft(ct));
plot(a1);
axis([0 5000 0 5000]);
xlabel('freq(Hz)');
ylabel('AMP');
title('CARRIER SIGNAL POWER SPECTRUM');

figure(2);
st=Ac*(1+(Am/Ac)*cos(2*pi*Fm*t)).*cos(2*pi*Fc*t);
subplot(2,2,1)
plot(t,st);
axis([0 .05 -25 25]);
xlabel('time(sec)');
ylabel('AMP');
title('MODULATED SIGNAL');

subplot(2,2,2)
a1=abs(fft(st));
plot(a1);
axis([0 5000 0 10000]);
xlabel('freq(Hz)');
ylabel('AMP');
title('MODULATED SIGNAL POWER SPECTRUM');

pt=(Ac*(1+u*cos(2*pi*Fm*t)).*cos(2*pi*Fc*t)).*cos(2*pi*Fc*t);
subplot(2,2,3);
plot(t,pt);
axis([0 .05 -25 25]);
xlabel('time(sec)');
ylabel('AMP');
title('PRODUCT OF MODULATED SIGNAL WITH CARRIER');

subplot(2,2,4)
a1=abs(fft(pt));
plot(a1);
axis([0 5000 0 10000]);
xlabel('freq(Hz)');
ylabel('AMP');
title('PRODUCT(s(t)&c(t)) SIGNAL POWER SPECTRUM');

figure(3);
w=2*pi*(Fm/Fs);
n=-200:200;
y1=filter((w/pi).*sinc(w.*n),1,pt);
subplot(2,1,1);
plot(t,y1);
title('DEMODULATED SIGNAL');
xlabel('AMP');
ylabel('time(sec)');
axis([0.05 1 -5 5]);

new_mes=(1/10000).*fft(y1);
c=abs(new_mes);
subplot(2,1,2);
plot(c);
axis([70 210 0 2]);
title('DEMODULATED SIGNAL POWER SPECTRUM');
xlabel('freq(Hz)');
ylabel('AMP');



