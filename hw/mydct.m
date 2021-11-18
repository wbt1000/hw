function B = mydct(A)
    A = double(A);
    B = zeros(8,8);
    for u=1:8
        for v=1:8
            sum=0;
            for x=1:8
                for y=1:8
                    sum = sum+cos((2*x-1)*(u-1)*pi/16)*cos((2*y-1)*(v-1)*pi/16)*A(x,y);
                end
            end
            B(u,v)=sum/4;
        end
    end             
end

