function [Str] = MergeStructures( Str1, Str2 )
%MERGESTRUCTURES Combines the fields of two structures into a single structure without
%duplicates
%   Str1 - Structure
%   Str2 - Structure
%   Str  - Final Structure

%       jbb - 7/29/2015

strPairs = [fieldnames(Str1), struct2cell(Str1); fieldnames(Str2), struct2cell(Str2)].';
[~, fieldind, ~] = unique(strPairs(1,:));
strPairs2 = strPairs(:,fieldind);
Str = struct(strPairs2{:});


end

