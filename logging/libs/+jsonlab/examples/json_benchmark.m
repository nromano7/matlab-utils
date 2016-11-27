% jdv

n = 32000; m = 8;
data.force = rand(n,1);
data.accel = rand(n,8);

% create test files
fid1 = fopen('test1.json','w');
fid2 = fopen('test2.json','w');
fid3 = fopen('test3.txt','w');


% test1 json
tic
json1 = savejson('',data);
a(1,1) = toc;
dat1  = loadjson(json1);
a(1,2) = toc;
fwrite(fid1,json1);
a(1,3) = toc

% test2 ubjson
tic
json2 = saveubjson('',data);
a(2,1) = toc;
dat2  = loadubjson(json2);
a(2,2) = toc;
fwrite(fid2,json2);
a(2,3) = toc

% test3 dlmwrite
tic
json3 = dlmwrite('temp3.txt',data.accel,'\t');
a(3,1) = toc; 

% close files
fclose(fid1);
fclose(fid2);
fclose(fid3);