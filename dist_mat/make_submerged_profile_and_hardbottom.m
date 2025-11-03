% make submerged profile files if they don't exist




% make hardbottom profiles
load work/Reach1_submerged_profile.txt
x = Reach1_submerged_profile(:,1);
zb = Reach1_submerged_profile(:,2);

x_p  = x;
zb_p = zb-2;

% if there is hardbottom on the beach--so landward of the submerged profile:
x_p = [-50 -20 -10 x_p']';
zb_p = [0 3 0 zb_p']';

dum = [x_p(:) zb_p(:)];



fn   = 'Reach1_hardbottom_profile.txt';
fid = fopen(['work/',fn],'w');
fprintf(fid,'%5.3f %5.3f \n',dum');
fclose(fid);


