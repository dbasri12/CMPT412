p3d = pts3d(:,1:3);
pts_err1 = 0;
pts_err2 = 0;
re_pro1 = P1*p3d;
re_pro2 = P2*p3d;

for j = 1:size(re_pro1,2)
    re_pro1(:,j) = re_pro1(:,j)/re_pro1(3,j);
    re_pro2(:,j) = re_pro2(:,j)/re_pro2(3,j);
    
    single_error1 = sqrt((p(1,j)-re_pro1(1,j)).^2 + (p(2,j)-re_pro1(2,j)).^2 );
    pts_err1 = pts_err1 + single_error1;
    
    single_error2 = sqrt((p_2(1,j)-re_pro2(1,j)).^2 + (p_2(2,j)-re_pro2(2,j)).^2 );
    pts_err2 = pts_err2 + single_error2;
end


pts_err1 = pts_err1/size(re_pro1,2)
pts_err2 = pts_err2/size(re_pro2,2)