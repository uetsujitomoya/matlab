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
k_wave = pi/sigma ; �g�]���g�̔g��
x = ((l:N)-l/2)*h - L/2; %�i�q�_�̍��W
�����������̓K�E�X�`�p���X
a = cos(k_wave*x)�D��exp(-x�E��2/(2*sigma*2));
���������E�������g�p
ip(l:(N-l)) = 2:N; ip(N) = 1;��yp = i + 1���L������
A MATLAB�̃v���O�������X�g�T
im(2:N) = 1:(N-1); im(l) = N;����m = i-l���L������
�ၙ�v���b�g�p�z�������������B
i p l o t = 1 ; ���v���b�g��
aplot(:,1) = a(:) ;��������Ԃ��L�^
t p l o t ( 1 ) = 0 ; �g�͂��߂̎���
n p l o t s = 5 0 F �g���]�̃v���b�g��
plotStep = nStep/nplots;��v���b�g�Ԃ̎��ԍ��݉�
�ၙ���]�̎��ԍ��ݐ��܂Ōv�Z���J��Ԃ��B
f o r i S t e p = l : n S t e p ���g�僋�[�v�� ��
�����g�̐U���̐V�����l��FTCS�@�A���b�N�X�@�A���邢��
�����b�N�X�E�x���h���t�@�Ōv�Z����B
if( method == 1 ) %%% FTCS�@�펯
e l s e i f ( m e t h o d = = 2 ) �g�����c�N�X�@�t�w
e l s e % % % ���b�N�X�E�x���h���t�@���&
a(l:N) = a(l:N) + coeff*(a(ip)-a(im)) +�A�D�A
������
�����v���b�g�p�Ɉ��Ԋu��a(t)���L�^����B
if( rem(iStep,plotStep) < 1 )�g���ԍ���plot_iter�񖈂ɋL�^
a p l o t ( : , i p l o t ) = a ( : �h ��v���b�g�p��a ( i ) ���L�^
f p r i n t f ( �� ���ԍ��݂��X ��̂����� �X �񊮗�\ n �� �C n S t e p , i S t e p ) ;
������
������
�g���ŏ��ƍŌ�̔g�`���O���t�\������B
figured) ; elf; % 1�߂̃E�C���h�E���������đO�ʂɕ\��
plot(x,aplot (:,1),'�ꁌ�C���C���C�f��ꁌ);
l e g e n d ( �� �ŏ��� �C �� �Ōが �j �G
p a u s e ( 1 ) ; �펟�̃O���t�\���̑O�ɂP �b�҂�
�����ʒu�Ǝ��Ԃɑ΂���U���̕ω����O���t�\������B
figure(2); elf; % 2�߂̃E�C���h�E���������đO�ʂɕ\��
5�U ��V�͕Δ���������11���x�ȗz��@
ylabel(���ʒu��); xlabel(��������); zlabel(���U����);
view([-70 50]);�ጩ�₷���悤�Ɋp�x�𒲐�