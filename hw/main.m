img = imread("C:\Users\Olympia\Desktop\hw\leaf\leaf-BMP.bmp");
load("C:\Users\Olympia\Desktop\hw\bright");
load("C:\Users\Olympia\Desktop\hw\color");

r=img(:,:,1);
g=img(:,:,2);
b=img(:,:,3);
width = size(img,2);
height = size(img,1);
block_num = uint8(width*height/64);
YCBCR = rgb2ycbcr(img);
y=YCBCR(:,:,1);
u=YCBCR(:,:,2);
v=YCBCR(:,:,3);

y_blocks = block(y,width,height);
y_blocks_DCT_QT = zeros(8,8*block_num);
for i=1:block_num
    y_blocks_DCT_QT(:,(i-1)*8+1:i*8) = qt(mydct(y_blocks(:,(i-1)*8+1:i*8)),bright);
end

u_blocks = block(u,width,height);
u_blocks_DCT_QT = zeros(8,8*block_num);
for i=1:block_num
    u_blocks_DCT_QT(:,(i-1)*8+1:i*8) = qt(mydct(u_blocks(:,(i-1)*8+1:i*8)),color);
end


v_blocks = block(v,width,height);
v_blocks_DCT_QT = zeros(8,8*block_num);
for i=1:block_num
    v_blocks_DCT_QT(:,(i-1)*8+1:i*8) = qt(mydct(v_blocks(:,(i-1)*8+1:i*8)),color);
end

Y = uint8(y_blocks_DCT_QT);
U = uint8(u_blocks_DCT_QT);
V = uint8(v_blocks_DCT_QT);

y_dc = zeros(1,block_num);
u_dc = zeros(1,block_num);
v_dc = zeros(1,block_num);
y_dc(1,1) = Y(1,1);
u_dc(1,1) = Y(1,1);
v_dc(1,1) = Y(1,1);
for i=2:block_num
    y_dc(1,i) = y_dc(1,i-1)-Y(1,(i-1)*8+1);
    u_dc(1,i) = u_dc(1,i-1)-U(1,(i-1)*8+1);
    v_dc(1,i) = v_dc(1,i-1)-V(1,(i-1)*8+1);
end

y_ac=[];

for i=1:block_num
    current_block = Y(:,(i-1)*8+1:i*8);
    f=0;
    last_num = current_block(1,2);
    current_num;
    i=1;j=2;
    step = [1,2,3,4];%1:right_up,2:left_down,3:right,4:down]
    last_step = 3;
    next_step = 0;
    while(1)
        current_num = current_block(i,j);
        if current_num==last_num 
            f=f+1;
        else
            y_ac = [y_ac,[last_num;f]];
            last_num = current_num;
            f=1;
        end
    
        if i==8&&j==8
            break;
        end
    
        if i==1
           if last_step == 3
              next_step = 2;
           end
           if last_step == 1
               next_step = 3;
           end 
        elseif i==8
            if last_step == 2
                next_step = 3;
            end
            if last_step == 3
                next_step = 1;
            end
        elseif j==1
            if last_step == 2
                next_step = 4;
            end
            if last_step == 4
                next_step = 1;
            end
        elseif j==8
            if last_step == 1
                next_step = 4;
            end
            if last_step == 4
                next_step = 2;
            end
        end

        switch next_step
            case 1
                i=i-1;
                j=j+1;
                break;
            case 2
                i=i+1;
                j=j-1;
                break;
            case 3 
                j=j+1;
                break;
            case 4
                i=i+1;
                break;
        end
    end
end

