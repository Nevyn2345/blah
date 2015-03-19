function xplusone = addOne(x)

narginchk(1, 1) % enforce single imput
validateattributes(x, {'double', 'char'},  {'nonempty'})

xplusone = x + 1;

if ischar(x) == 1
    xplusone = char(x+1);
end
    
end % addOne