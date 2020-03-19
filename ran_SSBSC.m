clc;
clear all;
close all;
Ac1=10;
Ac2=10;
Am1=10;
Am2=10;
Fm1=100;
Fm2=100;
Fc=1000;
Fs=10000;
t=0:0.0001:1;
f=1:10001;
mt1 = Am1*cos(2*pi*Fm1*t);
mt2 = Am2*cos(2*pi*Fm2*t+(pi/2));
ct1 = Ac1*cos(2*pi*Fc*t);
ct2 = Ac2*cos(2*pi*Fc*t+(pi/2));
figure(1);
subplot(4,2,1)
plot(t,mt1)
axis([0 .02 -12 12]);
xlabel('time(sec)');
ylabel('AMP');
title('MESSAGE SIGNAL-1');
subplot(4,2,3)
plot(t,mt2)
axis([0 .02 -12 12]);
xlabel('time(sec)');
ylabel('AMP');
title('MESSAGE SIGNAL-2');
subplot(4,2,5)
plot(t,ct1)
axis([0 500 0 5000]);
xlabel('time(sec)');
ylabel('AMP');
title('CARRIER SIGNAL-1');
axis([0 .01 -12 12]);
subplot(4,2,7)
plot(t,ct2)
axis([0 .01 -12 12]);
xlabel('time(sec)');
ylabel('AMP');
title('CARRIER SIGNAL-2');

subplot(4,2,2)
a1=abs(fft(mt1));
plot(a1);
axis([0 500 0 5000]);
xlabel('freq(Hz)');
ylabel('AMP');
title('MESSAGE SIGNAL-1 POWER SPECTRUM');

subplot(4,2,4)
a1=abs(fft(mt2));
plot(a1);
axis([0 500 0 5000]);
xlabel('freq(Hz)');
ylabel('AMP');
title('MESSAGE SIGNAL-2 POWER SPECTRUM');

subplot(4,2,6)
a1=abs(fft(ct1));
plot(a1);
axis([0 5000 0 5000]);
xlabel('freq(Hz)');
ylabel('AMP');
title('CARRIER SIGNAL-1 POWER SPECTRUM');

subplot(4,2,8)
a1=abs(fft(ct2));
plot(a1);
axis([0 5000 0 5000]);
xlabel('freq(Hz)');
ylabel('AMP');
title('CARRIER SIGNAL-2 POWER SPECTRUM');


figure(2);
y1=Ac1*Am1*(cos(2*pi*Fm1*t).*cos(2*pi*Fc*t));
y2=Ac2*Am2*(cos(2*pi*Fm1*t+(pi/2)).*cos(2*pi*Fc*t+(pi/2)));
st=y1+y2;
subplot(3,2,1)
plot(t,st);
axis([0 .02 -150 150]);
xlabel('time(sec)');
ylabel('AMP');
title('SSBSC');

a=(1/50)*fft(st);
b=abs(a);
subplot(3,2,2);
plot(b);
axis([0 5000 0 10000]);
xlabel('freq(Hz)');
ylabel('AMP');
title('MODULATED SIGNAL POWER SPECTRUM');

pt1=st.*ct1;
subplot(3,2,3);
plot(t,pt1);
axis([0 .05 -1500 1500]);
xlabel('time(sec)');
ylabel('AMP');
title('PRODUCT OF MODULATED SIGNAL WITH CARRIER-1');

subplot(3,2,4)
a1=abs(fft(pt1));
plot(a1);
axis([0 5000 0 100000]);
xlabel('freq(Hz)');
ylabel('AMP');
title('PRODUCT(s(t)&c(t)"1") SIGNAL POWER SPECTRUM');

pt2=st.*ct2;
subplot(3,2,5);
plot(t,pt2);
axis([0 .05 -1500 1500]);
xlabel('time(sec)');
ylabel('AMP');
title('PRODUCT OF MODULATED SIGNAL WITH CARRIER-2');

subplot(3,2,6)
a1=abs(fft(pt1));
plot(a1);
axis([0 5000 0 100000]);
xlabel('freq(Hz)');
ylabel('AMP');
title('PRODUCT(s(t)&c(t)"2") SIGNAL POWER SPECTRUM');

figure(3);
w=2*pi*(Fm1/Fs);
n=-200:200;
y1=filter((w/pi).*sinc(w.*n),1,pt1);
subplot(2,2,1);
plot(t,y1);
axis([0.05 1 -500 500]);
title('DEMODULATED SIGNAL-1');
xlabel('AMP');
ylabel('time(sec)');

mes1=(1/10000).*fft(y1);
c=abs(mes1);
subplot(2,2,2);
plot(f,c);
axis([70 210 0 100]);
title('DEMODULATED SIGNAL-1 POWER SPECTRUM');
xlabel('freq(Hz)');
ylabel('AMP');

w=2*pi*(Fm1/Fs);
n=-200:200;
y2=filter((w/pi).*sinc(w.*n),1,pt2);
subplot(2,2,3);
plot(t,y2);
axis([0.05 1 -500 500]);
title('DEMODULATED SIGNAL-2');
xlabel('AMP');
ylabel('time(sec)');

mes2=(1/10000).*fft(y2);
c2=abs(mes2);
subplot(2,2,4);
plot(f,c2);
axis([70 210 0 100]);
title('DEMODULATED SIGNAL-2 POWER SPECTRUM');
xlabel('freq(Hz)');
ylabel('AMP');


