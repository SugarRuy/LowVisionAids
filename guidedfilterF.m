function I_enhanced = guidedfilterF(I)
% 基于引导滤波的图像增强操作
% 灰度变换
if isrgb(I)
    I=I;
else
    I=cat(3,I,I,I);
end

% 引导滤波图像增强
IF = double(I) / 255;
p = IF;

r = 16;
eps = 0.1^2;

q = zeros(size(IF));

q(:, :, 1) = guidedfilter(IF(:, :, 1), p(:, :, 1), r, eps);
q(:, :, 2) = guidedfilter(IF(:, :, 2), p(:, :, 2), r, eps);
q(:, :, 3) = guidedfilter(IF(:, :, 3), p(:, :, 3), r, eps);

I_enhanced = (IF - q) * 5 + q;
