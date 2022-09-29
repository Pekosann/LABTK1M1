clc
close all
clear all
format compact
format short e

g = 9.80665;%m/s2
T = 27;% C

%A.2-3 Gean
rho = interp1([25 30],[997.08 995.68],T);
gamma = g*rho;

%Data
single2 = table2array(readtable('Single2937.xlsx'));
% 1.Bukaan Valve 2.Velocity rpm 3.P1 bar 4.P2 bar 5.Debit l/hr 6.Torsi N.m

Bukaan2 = single2(:,1);
n2 = single2(:,2);
P12 = single2(:,3);
P22 = single2(:,4);
Q2 = single2(:,5);
Torsi2 = single2(:,6);
z = 0.21;

H2 = (P22-P12).*100000./gamma+z;
W2 = H2.*g;
NH2 = gamma.*Q2./3600./1000.*H2;
NM2 = n2.*pi().*Torsi2./30;
eta2 = NH2./NM2.*100;

Tabel2 = table(Bukaan2,H2,W2,NH2,NM2,eta2)

TrendlineW2 = polyfit(Q2,W2,2)
TrendlineNM2 = polyfit(Q2,NM2,3)
Trendlineeta2 = polyfit(Q2,eta2,3)

etaa2 = polyder(Trendlineeta2);
etamax2 = roots(etaa2)
NilaiAkhir2 = polyval(Trendlineeta2,etamax2)

%Data
single = table2array(readtable('Single.xlsx'));
% 1.Bukaan Valve 2.Velocity rpm 3.P1 bar 4.P2 bar 5.Debit l/hr 6.Torsi N.m

Bukaan = single(:,1);
n = single(:,2);
P1 = single(:,3);
P2 = single(:,4);
Q = single(:,5);
Torsi = single(:,6);
z = 0.21;

H = (P2-P1).*100000./gamma+z;
W = H.*g;
NH = gamma.*Q./3600./1000.*H;
NM = n.*pi().*Torsi./30;
eta = NH./NM.*100;

Tabel = table(Bukaan,H,W,NH,NM,eta)

TrendlineW = polyfit(Q,W,2)
TrendlineNM = polyfit(Q,NM,3)
Trendlineeta = polyfit(Q,eta,3)

etaa = polyder(Trendlineeta);
etamax = roots(etaa)
NilaiAkhir = polyval(Trendlineeta,etamax)

f= figure;
set(gcf, 'Position', [100, 100, 800, 500])

ax1 = axes; 
yyaxis left

satu2 = plot(Q2,W2,'o','Color','r');
hold on
set(gca,'Position',[0.15 0.15 0.75 0.75])
pause(0.1)
ax1.XTickMode = 'manual'; 
ax1.YTickMode = 'auto'; 
ax1.YLim = [0, max(ax1.YTick)+10];
ax1.XLim = [0 max(Q2)+100];
ax1.XLimMode = 'manual'; 
satu = plot(Q,W,'o','Color','[0.6350 0.0780 0.1840]');
satua = fplot(poly2sym(TrendlineW),ax1.XLim,':','Color','[0.6350 0.0780 0.1840]');
satua2 = fplot(poly2sym(TrendlineW2),ax1.XLim,':','Color','r');
grid(ax1,'off')
ytick = ax1.YTick;  
yyaxis right
ylabel('NM (W)')
dua = plot(Q,NM,'square','Color','b');
duaa = fplot(poly2sym(TrendlineNM),ax1.XLim,'--','Color','b');
dua2 = plot(Q2,NM2,'square','Color','[0 0.4470 0.7410]');
duaa2 = fplot(poly2sym(TrendlineNM2),ax1.XLim,'--','Color','[0 0.4470 0.7410]');
ax2 = axes('position', ax1.Position);
tiga2 = plot(ax2,Q2,eta2, '.','MarkerSize',12,'Color','[0.4940 0.1840 0.5560]	');
hold on
tiga = plot(ax2,Q,eta, '.','MarkerSize',12,'Color','k');
tigaa2 = fplot(poly2sym(Trendlineeta2),ax1.XLim,'-.','Color','[0.4940 0.1840 0.5560]	');
tigaa = fplot(poly2sym(Trendlineeta),ax1.XLim,'-.','Color','k');
hold off
pause(0.1)
ax2.Color = 'none'; 
grid(ax2, 'off')
ax2.XLim = ax1.XLim; 
ax2.XTick = ax1.XTick; 
ax2.YLim = [0 max(eta2)+5];
ax2.YLimMode = 'manual'; 
yl = ax2.YLim; 
ax2.YTick = linspace(yl(1), yl(2), length(ytick));
ax2.YTickLabel = strcat(ax2.YTickLabel, {'       '}); 

lgd = legend([satu satu2 dua dua2 tiga tiga2],'W (J/kg) 1803 rpm','W (J/kg) 2937 rpm','NM (W) 1803 rpm','NM (W) 2937 rpm','\eta (%) 1803 rpm','\eta (%) 2937 rpm');
lgd.Location = 'northwest';
title('W, NM, dan ɳ Terhadap Q untuk Single Pump')
xlabel('Q (l/hr)')
ylabel('W (J/kg), \eta (%)')

hold off
%%
%Data
parallel4 = table2array(readtable('Parallel2937.xlsx'));
% 1.Bukaan Valve 2.Velocity rpm 3.P1 bar 4.P2 bar 5.Debit l/hr 6.Torsi N.m

Bukaan4 = parallel4(:,1);
n14 = parallel4(:,2);
n24 = parallel4(:,3);
P14 = parallel4(:,4);
P24 = parallel4(:,5);
P34 = parallel4(:,6);
Q4 = parallel4(:,7);
Torsi4 = parallel4(:,8);
z = 0.21;

H14 = (P24-P14).*100000./gamma+z;
H24 = (P34-P14).*100000./gamma+z;
H4 = H14+H24;
W4 = H4.*g;
NH4 = gamma.*Q4./3600./1000.*H4;
NM14 = n14.*pi().*Torsi4./30;
NM24 = n24.*pi().*Torsi4./30;
NM4 = NM14+NM24;
eta4 = NH4./NM4.*100;

Tabel4 = table(Bukaan4,H4,W4,NH4,NM4,eta4)

TrendlineW4 = polyfit(Q4,W4,2)
TrendlineNM4 = polyfit(Q4,NM4,3)
Trendlineeta4 = polyfit(Q4,eta4,3)

etaa4 = polyder(Trendlineeta4);
etamax4 = roots(etaa4)
NilaiAkhir4 = polyval(Trendlineeta4,etamax4)
%Data
parallel3 = table2array(readtable('Parallel.xlsx'));
% 1.Bukaan Valve 2.Velocity rpm 3.P1 bar 4.P2 bar 5.Debit l/hr 6.Torsi N.m

Bukaan3 = parallel3(:,1);
n13 = parallel3(:,2);
n23 = parallel3(:,3);
P13 = parallel3(:,4);
P23 = parallel3(:,5);
P33 = parallel3(:,6);
Q3 = parallel3(:,7);
Torsi3 = parallel3(:,8);
z = 0.21;

H13 = (P23-P13).*100000./gamma+z;
H23 = (P33-P13).*100000./gamma+z;
H3 = H13+H23;
W3 = H3.*g;
NH3 = gamma.*Q3./3600./1000.*H3;
NM13 = n13.*pi().*Torsi3./30;
NM23 = n23.*pi().*Torsi3./30;
NM3 = NM13+NM23;
eta3 = NH3./NM3.*100;

Tabel3 = table(Bukaan3,H3,W3,NH3,NM3,eta3)

TrendlineW3 = polyfit(Q3,W3,2)
TrendlineNM3 = polyfit(Q3,NM3,3)
Trendlineeta3 = polyfit(Q3,eta3,3)

etaa3 = polyder(Trendlineeta3);
etamax3 = roots(etaa3)
NilaiAkhir3 = polyval(Trendlineeta3,etamax3)

f= figure;
set(gcf, 'Position', [100, 100, 800, 500])

ax1 = axes; 
yyaxis left

satu = plot(Q4,W4,'o','Color','r');

hold on
set(gca,'Position',[0.15 0.15 0.75 0.75])

satu3 = plot(Q3,W3,'o','Color','[0.6350 0.0780 0.1840]');

pause(0.1)
ax1.XTickMode = 'manual'; 
ax1.YTickMode = 'auto'; 
ax1.YLim = [0, max(ax1.YTick)+10];  % see [4]
ax1.XLim = [0 max(Q4)+100];
ax1.XLimMode = 'manual'; 
satua = fplot(poly2sym(TrendlineW4),ax1.XLim,':','Color','r');
satua3 = fplot(poly2sym(TrendlineW3),ax1.XLim,':','Color','[0.6350 0.0780 0.1840]');
grid(ax1,'off')
ytick = ax1.YTick;  
yyaxis right
ylabel('NM (W)')
dua3 = plot(Q3,NM3,'square','Color','b');
duaa3 = fplot(poly2sym(TrendlineNM3),ax1.XLim,'--','Color','b');
dua = plot(Q4,NM4,'square','Color','[0 0.4470 0.7410]');
duaa = fplot(poly2sym(TrendlineNM4),ax1.XLim,'--','Color','[0 0.4470 0.7410]');
ax2 = axes('position', ax1.Position);
tiga = plot(ax2,Q4,eta4, '.','MarkerSize',12,'Color','k');
hold on
tiga3 = plot(ax2,Q3,eta3, '.','MarkerSize',12,'Color','[0.4940 0.1840 0.5560]');
tigaa = fplot(poly2sym(Trendlineeta4),ax1.XLim,'-.','Color','k');
tigaa3 = fplot(poly2sym(Trendlineeta3),ax1.XLim,'-.','Color','[0.4940 0.1840 0.5560]');
hold off
pause(0.1)
ax2.Color = 'none'; 
grid(ax2, 'off')
ax2.XLim = ax1.XLim; 
ax2.XTick = ax1.XTick; 
ax2.YLim = [0 max(eta3)+5];
ax2.YLimMode = 'manual'; 
yl = ax2.YLim; 
ax2.YTick = linspace(yl(1), yl(2), length(ytick));
ax2.YTickLabel = strcat(ax2.YTickLabel, {'       '}); 

lgd = legend([satu3 satu dua3 dua tiga3 tiga],'W (J/kg) 1803 rpm','W (J/kg) 2937 rpm','NM (W) 1803 rpm','NM (W) 2937 rpm','\eta (%) 1803 rpm','\eta (%) 2937 rpm');
lgd.Location = 'northwest';
title('W, NM, dan ɳ Terhadap Q untuk Parallel Pump')
xlabel('Q (l/hr)')
ylabel('W (J/kg), \eta (%)')
hold off
%%
figure
set(gcf, 'Position', [100, 100, 800, 500])
plot(Q2,W2,'o','DisplayName','Single 2937 rpm','Color','r');
hold on
set(gca,'Position',[0.15 0.15 0.75 0.75])
plot(Q,W,'square','DisplayName','Single 1803 rpm','Color','b');
plot(Q3,W3,'square','DisplayName','Parallel 1803 rpm','Color','g');
plot(Q4,W4,'o','DisplayName','Parallel 2937 rpm','Color','m');

fplot(poly2sym(TrendlineW2),'r');
fplot(poly2sym(TrendlineW)),'b';
fplot(poly2sym(TrendlineW3),'g');
fplot(poly2sym(TrendlineW4),'m')
hold off
title('Perbandingan W(Q)')
xlabel('Q (l/hr)')
ylabel('W (W)')
xlim([0 max(Q4)+100])
ylim([0 max(W4)+10])
legend('Single 2937 rpm','Single 1803 rpm','Parallel 1803 rpm','Parallel 2937 rpm')
%%
figure
set(gcf, 'Position', [100, 100, 800, 500])
plot(Q2,NM2,'o','DisplayName','Single 2937 rpm','Color','r');
hold on
set(gca,'Position',[0.15 0.15 0.75 0.75])
plot(Q,NM,'square','DisplayName','Single 1803 rpm','Color','b');
plot(Q3,NM3,'square','DisplayName','Parallel 1803 rpm','Color','g');
plot(Q4,NM4,'o','DisplayName','Parallel 2937 rpm','Color','m');

fplot(poly2sym(TrendlineNM2),'r');
fplot(poly2sym(TrendlineNM)),'b';
fplot(poly2sym(TrendlineNM3),'g');
fplot(poly2sym(TrendlineNM4),'m')
hold off
title('Perbandingan NM(Q)')
xlabel('Q (l/hr)')
ylabel('NM (W)')
xlim([0 max(Q4)+100])
ylim([0 max(NM4)+10])
legend('Single 2937 rpm','Single 1803 rpm','Parallel 1803 rpm','Parallel 2937 rpm')
%%
figure
set(gcf, 'Position', [100, 100, 800, 500])
plot(Q2,eta2,'o','DisplayName','Single 2937 rpm','Color','r');
hold on
set(gca,'Position',[0.15 0.15 0.75 0.75])
plot(Q,eta,'square','DisplayName','Single 1803 rpm','Color','b');
plot(Q3,eta3,'square','DisplayName','Parallel 1803 rpm','Color','g');
plot(Q4,eta4,'o','DisplayName','Parallel 2937 rpm','Color','m');

fplot(poly2sym(Trendlineeta2),'r');
fplot(poly2sym(Trendlineeta)),'b';
fplot(poly2sym(Trendlineeta3),'g');
fplot(poly2sym(Trendlineeta4),'m')
hold off
title('Perbandingan \eta(Q)')
xlabel('Q (l/hr)')
ylabel('\eta (W)')
xlim([0 max(Q4)+100])
ylim([0 max(eta3)+10])
legend('Single 2937 rpm','Single 1803 rpm','Parallel 1803 rpm','Parallel 2937 rpm')