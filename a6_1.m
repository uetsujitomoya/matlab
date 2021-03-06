% dftcs -時間前方差分・空間中心差分の方法(Forward Time Centered
% Space method: FTCS法）によって拡散方程式を解くプログラム
clear; %help dftcs;%堵メモリを初期化してヘッダを表示
%若☆各パラメータを初期化（時間刻み幅、格子間隔等）する。
tau = input('時間刻み幅入力してください');
N = input('格子点の数を入力してください');
L = 1.; %系の長さはx=-L/2からx=L/2までとする。
h = L/(N-1);%格子間隔
kappa = 1.;%拡散係数
coeff = kappa*tau/h^2;
if( coeff < 0.5 )
    disp ( ' . . . 安定解が得られます． ． ． ');
else
    disp ( ' 警告１ 解は不安定になります。' ) ;
end
%初期条件および境界条件を設定する。
tt = zeros ( N , 1 ) ; %すべての格子点の温度を０ に初期化
tt(round(N/2)) = 1/h ;%初期条件は中央にスパイクを持つデルタ関数
%%境界条件はtt(l) = tt(N) = 0
%*プロット用の変数と繰り返しループを準備。
xplot = (0:N-1)*h - L/2;%プロット用ｘ座標を記録
iplot = 1 ; %プロットを数えるカウンタ
nstep = 300; %最大繰り返し回数
nplots = 50 ; %プロツト用にスナツプシヨットをとる数
plot_step = nstep/nplots; %スナツプシヨット間の時間刻み数
%*所望の時間刻み数まで計算を繰り返す。
for istep = 1:nstep %%主ループ%%
 %*FTCS法で新しい温度を計算する。
 tt(2:(N-1)) = tt(2:(N-1)) +...
     coeff*(tt(3:N) + tt(1:(N-2)) - 2*tt(2:(N-1)));
 
 %*プロット用に定期的に温度を記録する。
 if( rem(istep,plot_step)<1) % 時間刻み plot_step 毎に記録
     ttplot(:,iplot)=tt(:); %   プロット用に tt(i) を記録
     tplot(iplot) = istep*tau;  % プロット用に時刻を記録
     iplot = iplot+1;
 end
end

%*ｘとｔに対する温度の変化を格子線図と等値線図でプロットする。
mesh ( tplot , xplot , ttplot ) ; % 格子網の面プロット
xlabel('時刻'); ylabel ('x'); zlabel ('T (x, t) ') ;
title ( ' デルタ関数の拡散');
contourLevels = 0:0.5:10; contourLabels = 0:5;
cs = contour ( tplot , xplot , ttplot , contourLevels ) ; % 等値線プロット
clabel ( cs , contourLabels ) ; %等値線にラベルをつける。
xlabel ( '時刻' ) ; ylabel ( ' x ' ) ;
title ('等温度プロット');