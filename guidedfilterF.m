function I_enhanced = guidedfilterF(I)
% ���������˲���ͼ����ǿ����
% �Ҷȱ任
if isrgb(I)
    I=I;
else
    I=cat(3,I,I,I);
end

% �����˲�ͼ����ǿ
IF = double(I) / 255;
p = IF;

r = 16;
eps = 0.1^2;

q = zeros(size(IF));

q(:, :, 1) = guidedfilter(IF(:, :, 1), p(:, :, 1), r, eps);
q(:, :, 2) = guidedfilter(IF(:, :, 2), p(:, :, 2), r, eps);
q(:, :, 3) = guidedfilter(IF(:, :, 3), p(:, :, 3), r, eps);

I_enhanced = (IF - q) * 5 + q;
