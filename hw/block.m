function blocks = block(A, width,height)
    temp = zeros(8,8);
    blocks = [];
    for i = 0:height/8-1
        for j = 0:width/8-1
            for a = 1:8
                temp(a,:) = A(i*8+a,j*8+1:j*8+8);
            end
            blocks = [blocks,temp];
        end
    end
end