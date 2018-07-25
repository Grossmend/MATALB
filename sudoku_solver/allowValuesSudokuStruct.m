% ����������������� ���������� ��������

function [allow] = allowValuesSudokuStruct(M)

N = ones(9,9,9);
k = 1;

% zero out untrue entries for input
[row,col]=find(M);

for i=1:length(row)
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

% ����� � �������� ��������� �������� � ������ ������, ���� ��������
% ������ ���� ��������, �� ����������� ��� � ������
for col = 1:9
    for row = 1:9
        v = find(N(row,col,:));
        allow.(sprintf('cell_%d',k)) = v;
        k = k + 1;
    end
end

return