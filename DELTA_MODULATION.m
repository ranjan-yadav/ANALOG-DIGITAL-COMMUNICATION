clc;
close all;
clear all;
t=linspace(0,1,1000);
Am=2;
Fm=2;
m=Am*cos(2*pi*Fm.*t);
Ts=0.001;
dm=(2*2*Fm*pi*sin(2*pi*Fm*t));
del=Ts*max(dm);
subplot(3,2,1);
plot(t,m);
xlabel('t');
ylabel('m(t)');
title('MESSAGE');
%calculation of eq(n), mq(n)::-
mq(1)=0;
e(1)=m(1);
eq(1)=del*sign(e(1));
for n=2:1000
    e(n)=m(n)-mq(n-1);
    eq(n)=del*sign(e(n));
    mq(n)=eq(n)+mq(n-1);
    mq(n-1)=mq(n);
end

subplot(3,2,2);
stem(mq);
xlabel('t');
ylabel('AMPLITUDE');
title('MQ(n)');

subplot(3,2,3);
stem(eq);
xlabel('t');
ylabel('AMPLITUDE');
title('EQ(n)');

%ENCODED PART:
for i=1:1000
    if eq(i)>=0
        encod(i)=1;
    else
        encod(i)=0;
    end
end
subplot(3,2,4);
stem(encod);
xlabel('t');
ylabel('AMPLITUDE');
title('ENCODED SIGNAL');

%demodulation part
for i=1:1000
    if encod(i)==1
        dem_del(i)=del;
    else
        dem_del(i)=-del;
    end
end
subplot(3,2,5);
stem(dem_del);
xlabel('t');
ylabel('AMPLITUDE');
title('DEQ(n)');


dmq(1)=0;
for i=2:1000
    dmq(i)=dem_del(i)+dmq(i-1);
    dmq(n-1)=dmq(i);
end

subplot(3,2,6);
stem(dmq);
xlabel('t');
ylabel('AMPLITUDE');
title('DMQ(n)');

%filter design & demodulated part
a=1;
W=2*pi*(Fm)/4.5;
n=-3:3;
b=(W/pi).*sinc(W*n);
y = filter(b,a,dmq); 
figure(2)
subplot(2,1,1);
plot(t,y);
%axis([0.2 1 -2 2]);
title('DEMODULATED SIGNAL');
xlabel('t');
ylabel('y(t)');
subplot(2,1,2);
plot(t,m);
%axis([0.2 1 -2 2]);
xlabel('t');
ylabel('m(t)');
title('ORIGINAL MESSAGE');

