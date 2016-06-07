%���X�g7A.2�v���O����traffic-��ʗ��̘A���̎�������
% traffic -��~�M���ɂ������ʗ���\����ʉ��o�[�K�[�Y��������
%�����v���O����
clear all; help traffic;%�����������������ăw�b�_��\��
%*�v�Z�̊e��p�����[�^�i���ԍ��ݕ��A�i�q�Ԋu�Ȃǁj��ݒ肷��B
method = menu('���l�@��I�����Ă�������', ...
    'FTCS','���b�N�X','���b�N�X�E�x���h���t');
N = input('�i�q�_�̐����w�肵�Ă�������');
L = 400;%�n�̒����i���[�g���j
h = L/N;%�������E�����̊i�q�_�Ԋu
v_max = 25;%�Ԃ̍ō����x(m/s)
fprintf('�������鎞�ԍ��ݕ���%g�ł��B\n',h/v_max);
tau = input('���ԍ��ݕ�(tau)���w�肵�Ă�������');
fprintf('�Ō�̎Ԃ������o���̂�%g���݌�ł��B\n', ...
    (L/4)/(v_max*tau));
nstep = input('���ԍ��ݐ����w�肵�Ă�������');
coeff = tau/(2*h); % ���ׂĂ̐��l�@�ɋ��ʂɗp����W��
coefflw = tau^2/(2*h^2); %���b�N�X�E�x���h���t�@�ŗp����W��
%*������������ю������E������ݒ肷��B
rho_max = 1.0; %���x�̍ő�l
Flow_max = 0.25*rho_max*v_max;%����̍ő�l
%*����������x L / 4 ����x = 0 �܂ł̕��`�p���X
rho = zeros(1,N);
for i=round(N/4):round(N/2-1)
    rho(i) = rho_max; %���`�p���X���̍ő喧�x
end
rho(round(N/2)) = rho_max/2;%���̍s���R�����g�A�E�g���Ď��s���Ă݂�
%�������E������p����
ip(1:N) = (1:N)+1; ip(N) = 1; % ip = i+1���L������
im(1:N) = (1:N)-1; im(1) = N; % im = i-l���L������

%*�v���b�g�p�z�������������B
iplot=1;
xplot = ((1:N)-1/2)*h - L/2;%�v���b�g�p�ɂ����W���L�^
rplot(:,1) = rho (:); %������Ԃ��L�^
figure(1); clf; %��ʂ����������đO�ʂɕ\��
%*���]�̎��ԍ��ݐ��܂Ōv�Z���J��Ԃ��B
for istep=1:nstep
    %*���ꁁ�i���x)*(���x�j���v�Z
    F1ow = rho .* (v_max*(1 - rho/rho_max));
    
    %*FTCS�@�A���b�N�X�@�A���邢�̓��b�N�X�E�x���h���t�@
    % �Ŗ��x�̐V�����l���v�Z
    if( method == 1 )%%%FTCS%%%
        rho(1:N) = rho(1:N) - coeff*(Flow(ip)-Flow(im));
    elseif( method == 2 ) %%%���c�N�X�@����
        rho(1:N) = .5*(rho(ip)+rho(im)) ...
            - coeff*(Flow(ip)-Flow(im));
    else % % % ���b�N�X�E�x���h���t�@���t
        cp = v_max*(1 - (rho(ip)+rho(1:N))/rho_max) ;
        cm = v_max*(1 - (rho(1:N)+rho(im))/rho_max) ;
        rho(1:N) = rho(1:N) - coeff*(Flow(ip)-Flow(im)) ...
            + coefflw*(cp.*(Flow(ip)-Flow(1:N)) ...
            - cm.*(Flow(1:N)-Flow(im)));
    end
    
    %*�v���b�g�p�ɖ��x���L�^����B
    iplot=iplot+1;
    rplot(:,iplot)=rho(:);
    tplot(iplot)=tau*istep;
    
    %*�ʒu�Ζ��x�̃X�i�b�v�V���b�g���O���t�\������B
    plot(xplot,rho,'-',xplot,Flow/Flow_max,'-');
    xlabel('x'); ylabel('���x����ї���');
    legend('\rho(x,t)','F(x,t)');
    axis([-L/2, L/2,-0.1, 1.1]);
end

%*�ʒu����ю����Ɩ��x�̊֌W���i�q�ԃO���t�\������B
figure(1); clf; %�O���t��ʂ����������đO�ʂɕ\��
mesh(tplot,xplot,rplot)
xlabel('t'); ylabel('x'); zlabel('\rho');
title('�ʒu����ю����Ɩ��x�̊֌W');
view([100 30]) ;%�}�����₷���p�x�ɉ�]������
pause(1); % 1�b�Î~
%*�ʒu����ю����Ɩ��x�̊֌W�𓙒l���O���t�\������B
figure (2); clf; % 2�Ԗڂ̉�ʂ����������đO�ʂɕ\��
% contour(rplot)�͂��΂��̃O���t�Ȃ̂ŁA���΂��̃O���t��rot90�֐���p����
clevels = 0: (0.1) :1; %���l���̃��x��
clabel(cs) ; % ���l���Ƀ��x��������
xlabel('x'); ylabel('����'); title('���x�̓��l��') ;