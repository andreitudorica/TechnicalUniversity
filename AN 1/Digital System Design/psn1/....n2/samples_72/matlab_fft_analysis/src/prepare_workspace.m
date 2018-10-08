%open workspace
workspace;
load windows1024.mat
%prepare plots
bw = 4;
tw = 69;
taskbar = 33;
scrs = get(0,'ScreenSize');
scrs(4) = scrs(4) - taskbar;
pos1 = [bw,taskbar+2*scrs(4)/3,scrs(3)-2*bw,scrs(4)/3-tw-bw];
pos2 = [bw,taskbar,scrs(3)-2*bw,2*scrs(4)/3-tw-bw];
