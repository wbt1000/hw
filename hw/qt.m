function B = qt(A,table)
    B = zeros(size(A,1),size(A,2));
    for i=1:8
        for j=1:8
            B(i,j) = A(i,j)/table(i,j);
        end
    end
end

