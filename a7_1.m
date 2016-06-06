%���X�g7A.���v���O����advect-�A�������������܂��܂Ȑ��l��@�ŉ���
% advect-�]���ϒ����ꂽ�K�E�X�`�p���X�̗A�������܂��܂�
% ���l��@�Ōv�Z����v���O����
clear all; help advect;%�����������������ăw�b�_��\��
%*�e��ϐ���ݒ肷��i���ԍ��ݕ��A�i�q�Ԋu�Ȃ�)�B
method = menu('�p���鐔�l��@��I�����Ă�������', ...
    'FTCS�@','���b�N�X�@','���b�N�X�E�x���h���t�@');

N = input('�i�q�_�̐�����͂��Ă�������');
L = 1. ;%�n�̒���
h = L/N;%�i�q�Ԋu
c = 1;%�g�̑��x
fprintf('�g���i�q�Ԋu�P����i�ނ̂ɂ����鎞�Ԃ�%g�ł��B\n',h/c) ;
tau = input('���ԍ��ݕ�����͂��Ă�������');
coeff = -c*tau/(2.*h);%���ׂĂ̐��l��@�ŋ��ʂɗp����W��
coefflw = 2*coeff^2;%���b�N�X�E�x���h���t�@�ŗp����W��
fprintf('�g���n���ꏄ����ɂ́A���ԍ���%g���v���܂��B\n',L/(c*tau));
nStep = input('���ԍ��݉񐔂���͂��Ă�������');

%*������������ы��E������ݒ肷��B
sigma = 0.1 ; % �K�E�X�`�p���X�̕�
k_wave = pi/sigma ; %�]���g�̔g��
x = ((1:N)-1/2)*h - L/2; %�i�q�_�̍��W
%���������̓K�E�X�`�p���X
a = cos(k_wave*x) .* exp(-x.^2/(2*sigma^2));
%�������E�������g�p
ip(1:(N-1)) = 2:N; ip(N) = 1; %ip = i + 1���L������
im(2:N) = 1:(N-1); im(1) = N;%��m = i-1���L������
%*�v���b�g�p�z�������������B
iplot = 1 ; %�v���b�g��
aplot(:,1) = a(:); %������Ԃ��L�^
tplot ( 1 ) = 0 ; %�͂��߂̎���
nplots = 50 ; %���]�̃v���b�g��
plotStep = nStep/nplots;%�v���b�g�Ԃ̎��ԍ��݉�
%*���]�̎��ԍ��ݐ��܂Ōv�Z���J��Ԃ��B
for iStep = 1:nStep %%�僋�[�v%%
    %* �g�̐U���̐V�����l��FTCS�@�A���b�N�X�@�A���邢��
    %  ���b�N�X�E�x���h���t�@�Ōv�Z����B
    if( method == 1 ) %%% FTCS�@ %%%
        a(1:N) = a(1:N) + coeff*(a(ip)-a(im));
    elseif ( method == 2 ) %���c�N�X�@
        a(1:N) = a(1:N) + coeff*(a(ip)-a(im));
    else %%% ���b�N�X�E�x���h���t%%
        a(1:N) = a(1:N) + coeff*(a(ip)-a(im)) + ...
            coefflw*(a(ip)+a(im)-2*a(1:N));
    end
    %*�v���b�g�p�Ɉ��Ԋu��a(t)���L�^����B
    if( rem(iStep,plotStep) < 1 ) %���ԍ���plot_iter�񖈂ɋL�^
        iplot = iplot+1;
        aplot ( : , iplot ) = a(:); %�v���b�g�p��a ( i ) ���L�^
        fprintf ( ' ���ԍ��݂�%g��̂���%g�񊮗�\n',nStep,iStep);
    end
end

%* �ŏ��ƍŌ�̔g�`���O���t�\������B
figure(1); clf; % 1�߂̃E�C���h�E���������đO�ʂɕ\��
plot(x,aplot(:,1),'-',x,a,'--');
legend('�ŏ�','�Ō�');
pause(1); % ���̃O���t�\���̑O�ɂP �b�҂�

%* �ʒu�Ǝ��Ԃɑ΂���U���̕ω����O���t�\������B
figure(2); clf; % 2�߂̃E�C���h�E���������đO�ʂɕ\��
mesh(tplot,x,aplot);
ylabel('�ʒu'); xlabel('����'); zlabel('�U��');
view([-70 50]); % ���₷���悤�Ɋp�x�𒲐�