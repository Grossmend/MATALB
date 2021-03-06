
% ����������������� ���������� ��������

function [arrSort] = allowValuesSudoku(M)

N = ones(9,9,9);
[row,col] = find(M);
k = 1;

for i = 1:length(row)
    N(row(i),col(i),: )= 0;
    N(row(i),col(i),M(row(i),col(i))) = 1;
end

% �������� ������� ����� � �������� ����������� ��������
[row,col] = find(sum(N,3)<2);

% ��������� �������� (�� ������ �������� �������������� �������� ��� ����� ������, ��� 1)
for i = 1:length(row)
    
    v = find(N(row(i),col(i),:));
    M(row(i),col(i)) = v;
    % ������� ������� � ������ ������ (������ � ������� ��� ���� �� �����)
    N(:,col(i),v) = 0;
    % ������� ������ � ������ ������ (������ � ������ ��� ���� �� �����)
    N(row(i),:,v) = 0; 
    
    br = floor((row(i)-.5)/3)*3+1;
    bc = floor((col(i)-.5)/3)*3+1;

    % ������� ���������� (9 �������) � ������ ������ (������ � ����������� ��� ���� �� �����)
    N(br:br+2,bc:bc+2,v) = 0; 

    N(row(i),col(i),v) = 1;
    
end

% ����� � �������� ��������� �������� � ������ ������

c = 1;
for col = 1:9
    for row = 1:9
        v = find(N(row,col,:));
        if length(v) > 1
            arrSort(c,1) = k;
            arrSort(c,2) = length(v);
            c = c + 1;
        end
        k = k + 1;
    end
end

if exist('arrSort', 'var') == 0
    arrSort = [];
end

return