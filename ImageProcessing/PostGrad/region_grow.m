function R = region_grow(I,seed_x,seed_y,threshold)
%REGION_GROW this function returns the growing region of a image 
%with selected seed and threshold. 


%change image matrix I to double value for calculation
I = double(I);
[m n] = size(I);

%Result image: the growing region will be assign as 1, others are 0
R = zeros(m,n);
R(seed_x,seed_y) = 1;

%Initial queue, only has 1 element (seed)
queue_x(1) = seed_x;
queue_y(1) = seed_y;

%Growing the region
%Queue x and queue y will change at the same time, 
%So only need to judge one queue 
while( length(queue_x)>=1 )  
    %search 8 neighbour points
    for i = -1:1
        for j = -1:1
            %get next point
            next_x = queue_x(1)+i;
            next_y = queue_y(1)+j;

            %keep next point inside the image scope
            if( next_x<512 && next_x>1 && next_y<512 && next_y>1 )
                %find out whether next point is in the region 
                if (R(next_x,next_y) == 0)
                    
                    %comparing with current pixel 
                    %dynamic seed region grow (threshold = 3 is better, select forehead)
                    %seed is the first element of the queue
                    if(  abs(I(next_x,next_y)-I(queue_x(1),queue_y(1))) <threshold  ) 
                       
                    %comparing with the seed pixel    
                    %static seed region grow threshold (threshold = 40 is better, select forehead)
                    %seed is always the same (first selected seed)
                    %if(  abs(I(next_x,next_y)-I(seed_x,seed_y)) < threshold  )  
                    
                        %add points to the queue that satisfy the criteria defining a region 
                        queue_x(end+1)=next_x;
                        queue_y(end+1)=next_y;
                        %add points to the region
                        R(next_x,next_y)=1;
                    end
                end
            end
        end
    end
    %First in first out
    %Delete the first element in the queue when it's neighbour points are scanned
    queue_x(1) = [];
    queue_y(1) = [];
end

imshow(R);
end

