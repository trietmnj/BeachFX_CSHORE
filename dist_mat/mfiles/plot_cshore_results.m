
clear all
iprint = 1;
dirnames = dir('./work/outfiles');
fs = 18;

for i = 3:length(dirnames)
  fnames = dir(['./work/outfiles/',dirnames(i).name,'/*.mat']);
  for j = 1:1:length(fnames)
    disp(['working on /',dirnames(i).name,'/',fnames(j).name])
    load(['./work/outfiles/',dirnames(i).name,'/',fnames(j).name]);
    [j1 j2] = max(results.initial_profile);
    figure(1);clf;clear hh
    %plot(in.x,in.zb,'b'); hold all
    hh(1)=plot(results.x,results.initial_profile,'r','linewidth',2); hold all
    hh(2)=plot(results.x,results.final_profile,'k','linewidth',2); hold all
    if ~isnan(results.hardbottom_profile(1));
      fill([results.x ;flipud(results.x)],[results.hardbottom_profile;flipud(results.hardbottom_profile)-10],[.5 .5 .5]); hold all
    end
    axis([results.x(j2)-100 results.x(j2)+10 -1 results.initial_profile(j2)+2])
    legend(hh,'Initial','Final')
    dum = [dirnames(i).name,'-',fnames(j).name(1:end-4)];
    title(dum,'interpreter','none')
    ylabel('$z [m]$','interpreter','latex','fontsize',fs)
    xlabel('$x [m]$','interpreter','latex','fontsize',fs)
    %title(reaches(i).name,'interpreter','latex','fontsize',fs)
    set(gca,'TickLabelInterpreter','latex','fontsize',fs)

    % xlabel(' x [m]')
    %  ylabel(' z [m]')
    
    if iprint
      print('-dpng',['./work/outfiles/',dirnames(i).name,'/',dum,'.png'])
    end

    
  end

  
  
  
  
end