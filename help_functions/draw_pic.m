function [] = draw_pic(data,i, f_s, L_s,T_la, Tx, id, symbol, mark, color)

proj_err = max(data(:,:,1),1);
covar_err = data(:,:,2);
time = data(:,:,3);
number = i;
% id = {'FD','SFD','SpFD10','BKICS-FD'};
% symbol = ['o' 'd' '+' 's','*', '-'];
% color = ['r' 'b' 'k' 'y','c', 'm'];
% f_s = 13;
% L_s = 20;

n1 = size(data,2);
kk = size(data,1);
path = pwd;
content = {'/result/time_','/result/proj_err_', '/result/cov_err_'};
content = path_add(content, path);

x = 1:n1;
figure(1);
hold on

set(0,'DefaultFigureVisible', 'off')

for i = 1:kk
   g1(i) = plot(x,time(i,:),'Marker', symbol(i) ,'LineStyle',mark{i} ,'color',color(i),...
      'Markerfacecolor',color(i));

  
  set(gca,'XTick',Tx) 
  set(gca,'XTickLabel',T_la)
    set(gca,'FontSize',f_s);
      xlabel('The sketch size $\ell$','Interpreter','latex','fontsize',L_s)
  ylabel('\textbf{Running Time (s)}','Interpreter','latex','fontsize',L_s)
end
legend(id,'Location','best')
saveas(1,[content{1},num2str(number)],'epsc')
% title('time');
delete(1)
figure(2)
hold on
for i = 1:kk
   g2(i) = plot(x,proj_err(i,:),'Marker', symbol(i) ,'LineStyle',mark{i},  'color',color(i),...
      'Markerfacecolor',color(i));

  set(gca,'XTick',Tx)
  set(gca,'XTickLabel',T_la)
  set(gca,'FontSize',f_s);
        xlabel('The sketch size $\ell$','Interpreter','latex','fontsize',L_s)
  ylabel('\textbf{Projection Error}','Interpreter','latex','fontsize',L_s)
end
legend(id,'Location','best')
saveas(2,[content{2},num2str(number)],'epsc')
% title('projection error');
delete(2)
figure(3)
hold on
for i = 1:kk
%     mark(i)
   g3(i) = plot(x,covar_err(i,:),'Marker', symbol(i) ,'LineStyle',mark{i},'color',color(i),...
      'Markerfacecolor',color(i));
%   xlabel('the sketch size $\ell$','Interpreter','latex')
%   ylabel('\textbf{2-norm Error}','Interpreter','latex')
%   set(gca,'XTick',[0:20:100]) 
  set(gca,'XTick',Tx) 
  set(gca,'XTickLabel',T_la)
    set(gca,'FontSize',f_s);
          xlabel('The sketch size $\ell$','Interpreter','latex','fontsize',L_s)
  ylabel('\textbf{Covariance  Error}','Interpreter','latex','fontsize',L_s)
end
legend(id,'Location','best')
saveas(3,[content{3},num2str(number)],'epsc')
delete(3)

end


