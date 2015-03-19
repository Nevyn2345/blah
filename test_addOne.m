function tests = test_addOne()
%TEST_ADDONE: Test Harness for the "addOne" function.
tests = functiontests(localfunctions());
end % test_addOne

function testScalarDouble(T)
input = 1;
expected = 2;
actual = addOne(input);
verifyEqual(T, actual, expected);
end

function testComplex(T)
input = 3+5i;
expected = 4+5i;
actual = addOne(input);
verifyEqual(T, actual, expected);
end

function testColumn(T)
input = [0;0;0;0];
expected = [1;1;1;1];
actual = addOne(input);
verifyEqual(T, actual, expected, 'AbsTol', 1e-6);
% See also the RelTol option
end

function testIdentity(T)
input = [1,0;0,1];
expected = [2,1;1,2];
actual = addOne(input);
verifyEqual(T, actual, expected);
end

function testChar(T)
input = 'Mike';
expected = 'Njlf';
actual = addOne(input);
verifyEqual(T, actual, expected);
end

% Verify the error responses (test that the function throws the right
% errors

function testNargin(T)
% Test with zero inputs.
codeToEvaluate = @() addOne();
verifyError(T, codeToEvaluate, 'MATLAB:narginchk:notEnoughInputs')
% Test with too many inputs.
codeToEvaluate = @() addOne(1,2)
verifyError(T, codeToEvaluate, 'MATLAB:TooManyInputs')
end

function testEmpty(T)
% Test for empty array
codeToEvaluate = @() addOne(double.empty())
verifyError(T, codeToEvaluate, 'MATLAB:expectedNonempty')
end

function testNonDoubleNonChar(T)
% Test for non-double, non-char arrays
codeToEvaluate = @() addOne(single(2))
verifyError(T, codeToEvaluate, 'MATLAB:invalidType')
end

function testNanInf(T)
% NaN:
input = NaN;
expected = NaN;
actual = addOne(input);
verifyEqual(T, actual, expected);
% inf/-inf
input = [inf,-inf];
expected = [inf,-inf];
actual = addOne(input);
verifyEqual(T, actual, expected);
end