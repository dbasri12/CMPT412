% Q3.3.1
clear all
close all

book_vid = loadVid('data/book.mov');
ar_vid = loadVid('data/ar_source.mov');
cv_cover = imread('data/cv_cover.jpg');
ar_avi = VideoWriter('ar_avi.mp4', 'MPEG-4');
open(ar_avi);
for i = 1: size(ar_vid, 2)
    frame1 = book_vid(i).cdata;
    frame2 = ar_vid(i).cdata;
    [locs1, locs2] = matchPics(cv_cover, frame1);
    [bestH2to1, ~] = computeH_ransac(locs1, locs2);
    frame2= imcrop(frame2, [0 45 size(frame2, 2) size(frame2, 1)-90]);
    scaled_hp_img = imresize(frame2, [size(cv_cover,1) size(cv_cover,2)]);
    imshow(compositeH(bestH2to1.', scaled_hp_img, frame1));
    writeVideo(ar_avi, compositeH(bestH2to1.', scaled_hp_img, frame1));
end
close(ar_avi);