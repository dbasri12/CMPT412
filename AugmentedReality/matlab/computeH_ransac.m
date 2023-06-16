function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.
max_c = 0;
best_H = [];
least_dist = 1e10;
data_size=size(loc1,1);
for i = 1: 100
   if size(locs1,1) < 4
       randpoints = randperm(data_size, data_size);
   else
       randpoints = randperm(data_size,4);
   end
   x1 = locs1([randpoints],:);
   x2 = locs2([randpoints],:);
   h = computeH_norm(x2,x1);
   t = projective2d(h.');
   out = transformPointsForward(t, locs2);
   dis = abs(locs1-out);
   count = 0;
   tmp_points = [];
   for j = 1: data_size
       if norm(dis(j,:),2) <= 2.5
           count = count+1;
           tmp_points = [tmp_points, j];
       end
   end 
   if count == max_c
       if sum(dis,'all') < least_dist
            least_dist = sum(dis,'all');
            max_c = count;
            x1 = locs1(tmp_points,:);
            x2 = locs2(tmp_points,:);
            best_H = computeH_norm(x1,x2);
            inliers = locs1(tmp_points,:);
       end
   elseif count > max_c
       least_dist = sum(dis,'all');
        max_c = count;
        x1 = locs1(tmp_points,:);
        x2 = locs2(tmp_points,:);
        best_H = computeH_norm(x1,x2);
        inliers = locs1(tmp_points,:);
   end
end
if size(best_H,1) ==0
    bestH2to1 = computeH_norm(x1,x2);
else
    bestH2to1= best_H.';
end
%Q2.2.3
end

