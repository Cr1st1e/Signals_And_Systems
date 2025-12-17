%problem 1
v_a=1:5
v_b=[3;-1;2]
b2=v_b'
v_c=0:0.1:10;
v_d=10:-0.1:0;
zeros(2,3)
ones(2,3)

a = [4 2 5];
b = [3 8 9];

%problem 2
dot_prod = dot(a, b);
mag_a = norm(a);
mag_b = norm(b);
cos_phi = dot_prod / (mag_a * mag_b);
phi = acos(cos_phi); % Result is in radians
phi1 = phi/pi*180;

%problem 3
sum_a=sum((0:100).^2)
sum_b=sum(0:100)

%problem 4
sum1=0;
n=0;
x=-pi/2;
term=x;

while(abs(term)>=1e-8)
n=n+1;
sum1=sum1+term;
k=2*n+1;
term=((-1)^n*(x^k)/factorial(k));
end
sum1
sum2=sin(-pi/2)

%problem 6
t=0:0.01:2;
y1=cos(2*pi*2*t);
plot(y1);