function [output] = pooling_layer_forward(input, layer)

    h_in = input.height;
    w_in = input.width;
    c = input.channel;
    batch_size = input.batch_size;
    k = layer.k;
    pad = layer.pad;
    stride = layer.stride;
    
    h_out = (h_in + 2*pad - k) / stride + 1;
    w_out = (w_in + 2*pad - k) / stride + 1;
    
    
    output.height = h_out;
    output.width = w_out;
    output.channel = c;
    output.batch_size = batch_size;


    % Replace the following line with your implementation.
    input_data=reshape(input.data,h_in,w_in,c,batch_size);
    output.data=zeros([h_out,w_out,c,batch_size]);

    input_pad = padarray(input_data, [pad,pad, 0, 0], 'both');
    for n = 1:batch_size
        % Iterate over each channel
        for ch = 1:c
            for i = 1:h_out
                for j = 1:w_out
                    % Extract the region of interest
                    roi = input_pad((i-1)*stride+1:(i-1)*stride+k, (j-1)*stride+1:(j-1)*stride+k,ch,n);
                    % Perform pooling operation (max pooling in this case)
                    output.data(i, j,ch ,n) = max(roi(:));
                end
            end
        end
    end
    output_data=output.data;
    output_data=reshape(output.data,[],size(output.data,4));
    output.data=output_data;

end

