% dftcs -���ԑO�������E��Ԓ��S�����̕��@(Forward Time Centered
% Space method: FTCS�@�j�ɂ���Ċg�U�������������v���O����
clear; help dftcs;%�g�����������������ăw�b�_��\��
%�ၙ�e�p�����[�^���������i���ԍ��ݕ��A�i�q�Ԋu���j����B
tau = input('���ԍ��ݕ����͂��Ă�������');
N = input('�i�q�_�̐�����͂��Ă�������');
L = 1.; %�n�̒�����x=-L/2����x=L/2�܂łƂ���B
h = L/(N-1);%�i�q�Ԋu
kappa = 1.;%�g�U�W��
coeff = kappa*tau/h^2;
if( coeff < 0.5 )
    disp ( ' . . . ������������܂��D �D �D ');
else
    disp ( ' �x���P ���͕s����ɂȂ�܂��B' ) ;
end
%������������ы��E������ݒ肷��B
tt = zeros ( N , 1 ) ; %���ׂĂ̊i�q�_�̉��x���O �ɏ�����
tt(round(N/2)) = 1/h ;%���������͒����ɃX�p�C�N�����f���^�֐�
%%���E������tt(l) = tt(N) = 0
%*�v���b�g�p�̕ϐ��ƌJ��Ԃ����[�v�������B
xplot = (0:N-l)*h - L/2;%�v���b�g�p�����W���L�^
iplot = 1 ; %�v���b�g�𐔂���J�E���^
nstep = 300; %�ő�J��Ԃ���
nplots = 50 ; %�v���c�g�p�ɃX�i�c�v�V���b�g���Ƃ鐔
plot_step = nstep/nplots; %�X�i�c�v�V���b�g�Ԃ̎��ԍ��ݐ�
%*���]�̎��ԍ��ݐ��܂Ōv�Z���J��Ԃ��B
for istep = 1:nstep %%�僋�[�v%%
 %*FTCS�@�ŐV�������x���v�Z����B
 tt(2:(N-1)) = tt(2:(N-1)) +...
     coeff*(tt(3:N) + tt(1:(N-2)) - 2*tt(2:(N-1)));
 
 %*�v���b�g�p�ɒ���I�ɉ��x���L�^����B
 if( rem(istep,plot_step)<1) % ���ԍ��� plot_step ���ɋL�^
     ttplot(:,iplot)=tt(:); %   �v���b�g�p�� tt(i) ���L�^
     tplot(iplot) = istep*tau;  % �v���b�g�p�Ɏ������L�^
     iplot = iplot+1;
 end
end

%*���Ƃ��ɑ΂��鉷�x�̕ω����i�q���}�Ɠ��l���}�Ńv���b�g����B
mesh ( tplot , xplot , ttplot ) ; % �i�q�Ԃ̖ʃv���b�g
xlabel('����'); ylabel ('x'); zlabel ('T (x, t) ') ;
title ( ' �f���^�֐��̊g�U');
contourLevels = 0:0.5:10; contourLabels = 0:5;
cs = contour ( tplot , xplot , ttplot , contourLevels ) ; % ���l���v���b�g
clabel ( cs , contourLabels ) ; %���l���Ƀ��x��������B
xlabel ( '����' ) ; ylabel ( ' x ' ) ;
title ('�����x�v���b�g');