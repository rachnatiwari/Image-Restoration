Im = imread('/Users/rachna/Desktop/Screen Shot 2019-04-19 at 10.12.33 PM.png');
Im=double(Im);
S_=size(Im);
Mask=7;
for i=1:S_(1)
    j=1;
    while(j<S_(2)-Mask)
        T(1:Mask)=Im(i,j:j+(Mask-1));
        Data=harmmean(T);
        Im(i,j+1)=Data;
        j=j+1;
    end;
end;
imshow(uint8(Im));

