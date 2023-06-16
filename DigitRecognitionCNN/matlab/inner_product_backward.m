function [param_grad, input_od] = inner_product_backward(output, input, layer, param)
%size(param.b)
%size(param.w)
%size(output.diff)
%size(input.data)
h_in = input.height;
w_in = input.width;
c = input.channel;
batch_size = input.batch_size;

input_n.height = h_in;
input_n.width = w_in;
input_n.channel = c;

% Replace the following lines with your implementation.
param_grad.b = zeros(size(param.b));
param_grad.w = zeros(size(param.w));
input_od = zeros(size(input.data));
for n=1:batch_size
    input_n.data = input.data(:, n);
    input_od(:,n)=param.w * output.diff(:,n);
end
param_grad.w = input.data * output.diff';
param_grad.b = sum(output.diff, 2);
param_grad.b = reshape(param_grad.b,[1,500]);
end
