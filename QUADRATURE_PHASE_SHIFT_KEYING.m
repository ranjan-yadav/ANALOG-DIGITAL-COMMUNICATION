clc;
clear all;
close all;
t=linspace(0,1,1000);
i=0;
while i~=1000
    msg(i+1)=randi([0,1]);
    j=0;
    while j~=100
        msg(i+j+1)=msg(i+1);%MESSAGE GENERATION
        j=j+1;
    end
    i=i+100;
end
f=10;
c1=cos(2*pi*f*t); %CARRIER1
c2=sin(2*pi*f*t); %CARRIER2 SHIFTED BY 180.
k=1;
for i=1:5
      for j=1:200
          even((i-1)*200+j)=msg(k+100);
      end
      k=k+200;
end

k=1;
for i=1:5
      for j=1:200
          odd((i-1)*200+j)=msg(k);
      end
      k=k+200;
end

for i=1:5
    if(even(((i-1)*200)+1)==0)
        for j=1:200
            mod1((i-1)*200+j)=c1(j);
        end
    else
        for j=1:200
            mod1((i-1)*200+j)=-c1(j);
        end
    end
end

for i=1:5
    if(odd((i-1)*200+1)==0)
        for j=1:200
            mod2((i-1)*200+j)=c2(j);
        end
    else
        for j=1:200
            mod2((i-1)*200+j)=-c2(j);
        end
    end
end

mod=mod1+mod2;


subplot(3,1,1);
plot(t,msg);
title('message');
subplot(3,1,2);
plot(t,mod);
title('modulation');


v1=mod.*c1;
v2=mod.*c2;
syms t;
y1=int(v1,t,0,1);
y2=int(v2,t,0,1);
t=linspace(0,1,1000);
y1=double(y1);
y2=double(y2);

x1=reshape(y1,200,5);
demod1=mean(x1)
x2=reshape(y2,200,5);
demod2=mean(x2)

for i=1:5
    if demod1(i)<0 && demod2(i)<0
    for j=1:200
        demodulation((i-1)*200+j)=1;
    end
    elseif demod1(i)>0 && demod2(i)>0
    for j=1:200
        demodulation((i-1)*200+j)=0;
    end
    elseif demod1(i)<0 && demod2(i)>0
    for j=1:100
        demodulation((i-1)*200+j)=0;
    end
    for j=101:200
        demodulation((i-1)*200+j)=1;
    end
    elseif demod1(i)>0 && demod2(i)<0
    for j=1:100
        demodulation((i-1)*200+j)=1;
    end
    for j=101:200
        demodulation((i-1)*200+j)=0;
    end
    end
end
subplot(3,1,3);
plot(t,demodulation);
title('demodulation');

    
    
       

