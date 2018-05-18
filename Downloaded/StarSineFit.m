function  s_struct=StarSineFit(x,y)

%% s=StarSineFit(x,y) 
% x and y must be 1 row vectors of n columns

% The elements of output parameter vector, s ( b in the function ) are:
% 
% s(1): sine wave amplitude (in units of y)
% 
% s(2): period (in units of x)
% 
% s(3): phase (phase is s(2)/(2*s(3)) in units of x)
% 
% s(4): offset (in units of y)
% 
% It provides a good fit.
%%
options = optimset('MaxFunEvals',1000);

yu = max(y);
yl = min(y);
yr = (yu-yl);                               % Range of ‘y’
yz = y-yu+(yr/2);
zx = x(yz .* circshift(yz,[0 1]) <= 0);     % Find zero-crossings
per = 2*mean(diff(zx));                     % Estimate period
ym = mean(y);                               % Estimate offset
fit = @(b,x)  b(1).*(sin(2*pi*x./b(2) + 2*pi/b(3))) + b(4);    % Function to fit
fcn = @(b) sum((fit(b,x) - y).^2);                              % Least-Squares cost function
s = fminsearch(fcn, [yr;  per;  -1;  ym],options)   ;                    % Minimise Least-Squares
xp = linspace(min(x),max(x));
figure(5)
plot(x,y,'b',  xp,fit(s,xp), 'r')
legend('Original','Fit');
grid
s_struct.amplitude=s(1);
s_struct.period=s(2);
s_struct.phase=s(3);
s_struct.offset=s(4);

struct2table(s_struct)


%http://www.mathworks.com/matlabcentral/answers/121579-curve-fitting-to-a-sinusoidal-function