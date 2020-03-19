clc; clear all; close all;
t=linspace(0,1,1000);
f=10;
n=1;
M=2^n;
tb=0.1;
temp=40;
for i=1:M
    phi(i)=(i-1)*((pi)/(M));
end
i=0;
while i~=1000
   msg(i+1)=randi([0,1]);
   j=0;
    while j~=100
        msg(i+1+j)=msg(i+1);
       j=j+1;
    end
    i=i+100;
end
figure(1);
subplot(3,1,1);
plot(t,msg);
xlabel('TIME');
ylabel('AMPLITUDE');
title('MESSAGE');

for i=1:M
    for j=1:1000
        carrier(i,j)=sqrt(2/tb)*sin(2*pi*f*t(j)+phi(i));
    end
end
subplot(3,1,2);
plot(t,carrier(1,:));
xlabel('TIME');
ylabel('AMPLITUDE');
title('CARRIER1');
subplot(3,1,3);
plot(t,carrier(2,:));
xlabel('TIME');
ylabel('AMPLITUDE');
title('CARRIER2');

k=1;
for i=1:100:1000
    x=msg(i);
    for j=1:100
        mod(1,k)=carrier(x+1,j);
        k=k+1;
    end
end
figure(2);
subplot(3,1,1);
plot(t,mod);
xlabel('TIME');
ylabel('AMPLITUDE');
title('MODULATED');
for i=1:M
    for j=1:1000
        v(i,j)=carrier(i,j).*mod(1,j);
    end
end
syms t;
for i =1:M
  y(i,:)=int(v(i,:),t,0,1);
end
t=linspace(0,1,1000);
y=double(y);

for i=1:M
    x= reshape(y(i,:),100,10);
    meanism(i,:)=mean(x);
end

for i=1:10
    [l, idx]=max(meanism(:,i));
    demod(i)=idx-1;
end

for i=1:10
    for j=1:100
        demodulation(j+(i-1)*100)=demod(i);
    end
end

subplot(3,1,2);
plot(t,demodulation);
xlabel('TIME');
ylabel('AMPLITUDE');
title('DEMODULATED');

subplot(3,1,3);
plot(t,msg);
xlabel('TIME');
ylabel('AMPLITUDE');
title('MESSAGE');


figure(3);
subplot(2,1,1);
plot(t,v(1,:));
xlabel('TIME');
ylabel('AMPLITUDE');
title('PRODUCT OF MOD WITH CARRIER1');

subplot(2,1,2);
plot(t,v(2,:));
xlabel('TIME');
ylabel('AMPLITUDE');
title('PRODUCT OF MOD WITH CARRIER2');

