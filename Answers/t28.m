clear; close all; clc; rng(1)

% --- ground truth function ---
f = @(t) (t.^2).*exp(-5*t).*sin(t);

% --- sparse samples (toggle noiseLevel if you want noise) ---
tmin = 0; tmax = 3;
Nsp  = 12;                                 % 稀疏采样点数
t_s  = linspace(tmin,tmax,Nsp).';
y_s  = f(t_s);

noiseLevel = 0.00;                         % 设置为 0.02 之类加噪声
y_s = y_s + noiseLevel*max(abs(y_s))*randn(size(y_s));

% --- dense grid for comparison ---
t = linspace(tmin,tmax,2000).';
y = f(t);

% --- interpolation methods ---
methods = {'linear','pchip','spline'};
YI = zeros(numel(t), numel(methods));
rmse = zeros(numel(methods),1);

for k = 1:numel(methods)
    YI(:,k) = interp1(t_s, y_s, t, methods{k}, 'extrap');  % 一维插值拟合
    rmse(k) = sqrt(mean((YI(:,k) - y).^2));
end

% --- plots: curve comparison ---
figure('Color','w','Position',[100 100 1100 440]);
tiledlayout(1,2,"Padding","compact","TileSpacing","compact");

nexttile; hold on; grid on;
plot(t, y, 'k-', 'LineWidth',1.5);                      % 真值
plot(t_s, y_s, 'ko', 'MarkerFaceColor',[.95 .95 .95]);  % 稀疏点
plot(t, YI(:,1), '-', 'LineWidth',1.1);
plot(t, YI(:,2), '-', 'LineWidth',1.1);
plot(t, YI(:,3), '-', 'LineWidth',1.1);
legend(['truth', 'samples', methods], 'Location','northeast');
xlabel('t'); ylabel('y'); title('Interpolation vs. ground truth');

% --- error plot ---
nexttile; hold on; grid on;
plot(t, abs(YI(:,1)-y), 'LineWidth',1.0);
plot(t, abs(YI(:,2)-y), 'LineWidth',1.0);
plot(t, abs(YI(:,3)-y), 'LineWidth',1.0);
legend(methods,'Location','northeast');
xlabel('t'); ylabel('|interp - truth|'); title('Absolute error');

% --- print RMSE table ---
T = table(methods.', rmse, 'VariableNames',{'method','RMSE'});
disp(T);
