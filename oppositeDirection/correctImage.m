function [correctFrame] = correctImage(a,b,frame)

    inversefn = @(img)[polinom(img,-a)+img(:,1), polinom(img,-b)+img(:,2)];
    tform = geometricTransform2d(inversefn);
    correctFrame = imwarp(frame,tform);

end

