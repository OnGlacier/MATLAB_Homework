%%
f1  = @(x) exp(-(x+1).^2) + (pi/2)*sin(5*x + 2);

X   = linspace(-10,10,20001);
sgn = sign(f1(X));
chg = find(diff(sgn)~=0);

roots1 = [];
for k = chg
    a = X(k); b = X(k+1);
    try
        r = fzero(f1,[a,b]);
        roots1(end+1,1) = r; 
    catch
        % 如果 fzero 报错（端点正好为零或间隔太小），跳过
    end
end

if ~isempty(roots1)
    roots1 = unique(round(roots1,10));   
end

res1  = abs(f1(roots1));
ok1   = res1 < 1e-10;

fprintf('\n(1) 找到 %d 个根（[-10,10]），最大残差 = %.3e\n', ...
        numel(roots1), max(res1,[],'omitnan'));
disp(table(roots1,res1,ok1,'VariableNames',{'root','|f(root)|','pass'}));

%%
f2  = @(x,y) (x.^2 + y.^2 + x.*y).*exp(-(x.^2 + y.^2 + x.*y));
g2  = @(v) f2(v(1),v(2)).^2;  

starts = [-3 -3; -3 0; -3 3; 0 -3; 0 0; 0 3; 3 -3; 3 0; 3 3];

sols = []; vals = [];
opts = optimset('Display','off','TolX',1e-12,'TolFun',1e-16);
for i = 1:size(starts,1)
    [v,fval] = fminsearch(g2, starts(i,:), opts);
    sols(end+1,:) = v;           
    vals(end+1,1) = fval;        
end

mask     = vals < 1e-14;
cand     = sols(mask,:);
roots2   = unique(round(cand,12),'rows');   
res2     = arrayfun(@(i) abs(f2(roots2(i,1),roots2(i,2))), 1:size(roots2,1)).';
ok2      = res2 < 1e-10;

fprintf('\n(2) 二元方程搜索到 %d 个候选根，最终唯一根如下（理论应为 (0,0)）：\n', size(roots2,1));
disp(table(roots2(:,1),roots2(:,2),res2,ok2, ...
     'VariableNames',{'x','y','|f(x,y)|','pass'}));