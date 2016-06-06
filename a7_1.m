%リスト7A.ｌプログラムadvect-輸送方程式をさまざまな数値解法で解く
% advect-余弦変調されたガウス形パルスの輸送をさまざまな
% 数値手法で計算するプログラム
clear all; help advect;%メモリを初期化してヘッダを表示
%*各種変数を設定する（時間刻み幅、格子間隔など)。
method = menu('用いる数値手法を選択してください', ...
    'FTCS法','ラックス法','ラックス・ベンドロフ法');

N = input('格子点の数を入力してください');
L = 1. ;%系の長さ
h = L/N;%格子間隔
c = 1;%波の速度
fprintf('波が格子間隔１つ分を進むのにかかる時間は%gです。\n',h/c) ;
tau = input('時間刻み幅を入力してください');
coeff = -c*tau/(2.*h);%すべての数値手法で共通に用いる係数
coefflw = 2*coeff^2;%ラックス・ベンドロフ法で用いる係数
fprintf('波が系を一巡するには、時間刻み%g回を要します。\n',L/(c*tau));
nStep = input('時間刻み回数を入力してください');

%*初期条件および境界条件を設定する。
sigma = 0.1 ; % ガウス形パルスの幅
k_wave = pi/sigma ; %余弦波の波数
x = ((1:N)-1/2)*h - L/2; %格子点の座標
%初期条件はガウス形パルス
a = cos(k_wave*x) .* exp(-x.^2/(2*sigma^2));
%周期境界条件を使用
ip(1:(N-1)) = 2:N; ip(N) = 1; %ip = i + 1かつ有周期性
im(2:N) = 1:(N-1); im(1) = N;%ｉm = i-1かつ有周期性
%*プロット用配列を初期化する。
iplot = 1 ; %プロット回数
aplot(:,1) = a(:); %初期状態を記録
tplot ( 1 ) = 0 ; %はじめの時刻
nplots = 50 ; %所望のプロット数
plotStep = nStep/nplots;%プロット間の時間刻み回数
%*所望の時間刻み数まで計算を繰り返す。
for iStep = 1:nStep %%主ループ%%
    %* 波の振幅の新しい値をFTCS法、ラックス法、あるいは
    %  ラックス・ベンドロフ法で計算する。
    if( method == 1 ) %%% FTCS法 %%%
        a(1:N) = a(1:N) + coeff*(a(ip)-a(im));
    elseif ( method == 2 ) %ラツクス法
        a(1:N) = a(1:N) + coeff*(a(ip)-a(im));
    else %%% ラックス・ベンドロフ%%
        a(1:N) = a(1:N) + coeff*(a(ip)-a(im)) + ...
            coefflw*(a(ip)+a(im)-2*a(1:N));
    end
    %*プロット用に一定間隔でa(t)を記録する。
    if( rem(iStep,plotStep) < 1 ) %時間刻みplot_iter回毎に記録
        iplot = iplot+1;
        aplot ( : , iplot ) = a(:); %プロット用にa ( i ) を記録
        fprintf ( ' 時間刻みそ%g回のうち%g回完了\n',nStep,iStep);
    end
end

%* 最初と最後の波形をグラフ表示する。
figure(1); clf; % 1つめのウインドウを消去して前面に表示
plot(x,aplot(:,1),'-',x,a,'--');
legend('最初','最後');
pause(1); % 次のグラフ表示の前に１ 秒待つ

%* 位置と時間に対する振幅の変化をグラフ表示する。
figure(2); clf; % 2つめのウインドウを消去して前面に表示
mesh(tplot,x,aplot);
ylabel('位置'); xlabel('時刻'); zlabel('振幅');
view([-70 50]); % 見やすいように角度を調整