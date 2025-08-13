clc;
clear all;
close all;

files = dir('*.csv');

hold on;
for i = 1:10
    fname = files(i).name;
    x = readmatrix(fname);
    x1 = x(2:end,2:end);
    f = maxk(x1,1);
    ftotal(:,i) = f';
    g0 = maxk(x1,2);
    g = g0(2,:);
    gtotal(:,i) = g';
end

figure;
hold on;
subplot(2,1,1);
boxplot(ftotal,'Symbol','');
set(gca,'YLim',[0.5 0.7]);
subplot(2,1,2);
boxplot(gtotal,'Symbol','');
set(gca,'YLim',[0.3 0.5]);
hold off;

figure;
hold on;
boxplot(ftotal,'Symbol','');
boxplot(gtotal,'Symbol','');
set(gca,'YLim',[0 1.0]);
hold off;

% 
% figure;
% subplot(1,2,1)
% boxplot(f)
% % set(gca,'YLim',[0.546 0.556])
% subplot(1,2,2)
% boxplot(g)
% % set(gca,'YLim',[0.444 0.454])


% for i = 1:10;
%     fname = files(i+1).name;
%     x = readmatrix(fname);
%     x1 = x(:,2);
%     h = histfit(log10(x1),40,'kernel');
%     h(2).Color = rand(1,3);
%     h(1).FaceAlpha = 0;
%     h(1).EdgeAlpha = 0;
%     clear x;
% end 