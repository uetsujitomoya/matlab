%リスト7A.2プログラムtraffic-交通流の連続の式を解く
% traffic -停止信号における交通流を表す一般化バーガーズ方程式を
%解くプログラム
clear all; help traffic;%メモリを初期化してヘッダを表示
%*計算の各種パラメータ（時間刻み幅、格子間隔など）を設定する。
method = menu('数値法を選択してください', ...
    'FTCS','ラックス','ラックス・ベンドロフ');
N = input('格子点の数を指定してください');
L = 400;%系の長さ（メートル）
h = L/N;%周期境界条件の格子点間隔
v_max = 25;%車の最高速度(m/s)
fprintf('推奨する時間刻み幅は%gです。\n',h/v_max);
tau = input('時間刻み幅(tau)を指定してください');
fprintf('最後の車が動き出すのは%g刻み後です。\n', ...
    (L/4)/(v_max*tau));
nstep = input('時間刻み数を指定してください');
coeff = tau/(2*h); % すべての数値法に共通に用いる係数
coefflw = tau^2/(2*h^2); %ラックス・ベンドロフ法で用いる係数
%*初期条件および周期境界条件を設定する。
rho_max = 1.0; %密度の最大値
Flow_max = 0.25*rho_max*v_max;%流れの最大値
%*初期条件はx L / 4 からx = 0 までの方形パルス
rho = zeros(1,N);
for i=round(N/4):round(N/2-1)
    rho(i) = rho_max; %方形パルス内の最大密度
end
rho(round(N/2)) = rho_max/2;%この行をコメントアウトして実行してみよ
%周期境界条件を用いる
ip(1:N) = (1:N)+1; ip(N) = 1; % ip = i+1かつ有周期性
im(1:N) = (1:N)-1; im(1) = N; % im = i-lかつ有周期性

%*プロット用配列を初期化する。
iplot=1;
xplot = ((1:N)-1/2)*h - L/2;%プロット用にｘ座標を記録
rplot(:,1) = rho (:); %初期状態を記録
figure(1); clf; %画面を初期化して前面に表示
%*所望の時間刻み数まで計算を繰り返す。
for istep=1:nstep
    %*流れ＝（密度)*(速度）を計算
    F1ow = rho .* (v_max*(1 - rho/rho_max));
    
    %*FTCS法、ラックス法、あるいはラックス・ベンドロフ法
    % で密度の新しい値を計算
    if( method == 1 )%%%FTCS%%%
        rho(1:N) = rho(1:N) - coeff*(Flow(ip)-Flow(im));
    elseif( method == 2 ) %%%ラツクス法識＄
        rho(1:N) = .5*(rho(ip)+rho(im)) ...
            - coeff*(Flow(ip)-Flow(im));
    else % % % ラックス・ベンドロフ法諸稚
        cp = v_max*(1 - (rho(ip)+rho(1:N))/rho_max) ;
        cm = v_max*(1 - (rho(1:N)+rho(im))/rho_max) ;
        rho(1:N) = rho(1:N) - coeff*(Flow(ip)-Flow(im)) ...
            + coefflw*(cp.*(Flow(ip)-Flow(1:N)) ...
            - cm.*(Flow(1:N)-Flow(im)));
    end
    
    %*プロット用に密度を記録する。
    iplot=iplot+1;
    rplot(:,iplot)=rho(:);
    tplot(iplot)=tau*istep;
    
    %*位置対密度のスナップショットをグラフ表示する。
    plot(xplot,rho,'-',xplot,Flow/Flow_max,'-');
    xlabel('x'); ylabel('密度および流れ');
    legend('\rho(x,t)','F(x,t)');
    axis([-L/2, L/2,-0.1, 1.1]);
end

%*位置および時刻と密度の関係を格子網グラフ表示する。
figure(1); clf; %グラフ画面を初期化して前面に表示
mesh(tplot,xplot,rplot)
xlabel('t'); ylabel('x'); zlabel('\rho');
title('位置および時刻と密度の関係');
view([100 30]) ;%図を見やすい角度に回転させる
pause(1); % 1秒静止
%*位置および時刻と密度の関係を等値線グラフ表示する。
figure (2); clf; % 2番目の画面を初期化して前面に表示
% contour(rplot)はｘ対ｔのグラフなので、ｔ対ｘのグラフにrot90関数を用いる
clevels = 0: (0.1) :1; %等値線のレベル
clabel(cs) ; % 等値線にラベルをつける
xlabel('x'); ylabel('時刻'); title('密度の等値線') ;