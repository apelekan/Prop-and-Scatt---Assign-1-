[cnfg,scn] = my_read_cat_log();
data = [scn.scndata];

NSamp = scn(1,1).NumSmpls;
data = data(1:NSamp);

t_ns = linspace(cnfg.ScnStrt_ps,cnfg.ScnStp_ps,NSamp)/1000;
dt = (t_ns(end)-t_ns(1))/(NSamp-1);
fs = 1/dt;

window = zeros(1, length(data));
window(305:360) = data(305:360);
% threshold = 500;
% i = 0;
% while (1)
%    i = i + 1; 
%    if abs(data(i)) > threshold
%        window(i) = data(i);
%        threshold = threshold * 0.95;
%    end
%    if (i>3) && (abs(data(i)) <= threshold) && (abs(data(i-1)) > threshold) && (abs(data(i-2)) > threshold) 
%        break;
%    end
% end

figure;plot(t_ns,data);
hold on;
plot(t_ns, window);

fdata = abs(fftshift(fft(window)));
f = -pi:2*pi/length(data):pi;
f = f(1:end-1);
figure; plot(f, fdata)

fanalog = 16.3739/2*10^9/pi*f;
figure;
plot(fanalog, db(fdata))
figure;
semilogy(fanalog, fdata)
% fused = fanalog(1116:1316);
fused=fanalog(fanalog>3e9&fanalog<5e9);
dataused = fdata(fanalog>3e9&fanalog<5e9);
figure;
plot(fused, db(dataused))