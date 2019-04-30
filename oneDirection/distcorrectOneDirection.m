clear all

choosefile

opposite_name = [id 'OppositeDirection' filter '.mat'];
load(['mass_image_centers_' opposite_name])
oppositeDirection = A;
clear A
%
load(['harmonicY_' opposite_name]);
load(['harmonicX_' opposite_name]);
[a, b] = get_ab(135, harmonicX, harmonicY);
%}
%{
load('a_135_625.mat')
load('b_135_625.mat')
%}

load(['mass_image_centers_' result_name]);

sz=size(A);
frames = sz(1);

data = fitsread(name,'Table');

angle = data{3};
ansz = size(angle);
for j =1:1:ansz(1)
    if angle(j)>180
        angle(j) = angle(j)-360;
    end
end
angle = angle.*pi/180;

N=2;
bX = zeros(N,N,frames);
bY = zeros(N,N,frames);

ssa = size(A);
ssa = ssa(3);
szop = size(oppositeDirection);
szop=szop(3);
l=5;
k=0;
nn = 16;
for i=1:1:ssa
    x = A(nn,2,i);
    y = A(nn,1,i);
    for j = 1:1:szop
        opx = oppositeDirection(nn,2,j);
        opy = oppositeDirection(nn,1,j);
        r=sqrt(((opx-x).^2)+((opy-y).^2));
        if (r<l)
            k = k+1;
            xtrue_opposite(k) = oppositeDirection(1,2,j);
            ytrue_opposite(k) = oppositeDirection(1,1,j);
            %plot(xtrue_opposite(k), ytrue_opposite(k), 'k+', 'MarkerSize', 10);
            %hold on
            %plot(x, y, 'rs', 'MarkerSize', 5);
        end
    end
end
numObj = k;

%plot(squeeze(oppositeDirection(1,2,:)), squeeze(oppositeDirection(1,1,:)), 'k+', 'MarkerSize', 10);

z=[16 20 10];
for i = 1:1:length(z)
    dang(i) = angle(16) - angle(z(i));
end
aproxOneDirection
