function [output] = inner_product_forward(input, layer, param)

d = size(input.data, 1);
k = size(input.data, 2); % batch size
n = size(param.w, 2);
batch_size=input.batch_size;
%size(param.w)
%size(param.b)

% Replace the following line with your implementation.
output.data = zeros([n, k]);
%size(output.data)
for i=1:batch_size
    %size(input.data(:,1))
    output.data(:,i) = reshape(input.data(:,i),[1,d]) * param.w + param.b;
end
output.height=input.height;
output.width=input.width;
output.channel=input.channel;
output.batch_size=input.batch_size;

end

