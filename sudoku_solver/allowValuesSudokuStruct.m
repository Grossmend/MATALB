% детерминированный логический алгоритм

function [allow] = allowValuesSudokuStruct(M)

N = ones(9,9,9);
k = 1;

% zero out untrue entries for input
[row,col]=find(M);

for i=1:length(row)
    N(row(i),col(i),: )= 0;
    N(row(i),col(i),M(row(i),col(i))) = 1;
end

% получаем индексы строк и столбцов заполненных значений
[row,col] = find(sum(N,3)<2);

% выжигание значений (на выходе получаем гипотетические значения где могут стоять, там 1)
for i = 1:length(row)
    
    v = find(N(row(i),col(i),:));
    M(row(i),col(i)) = v;
    % убираем колонку с данным числом (больше в колонке его быть не может)
    N(:,col(i),v) = 0; 
    % убираем строку с данным числом (больше в строке его быть не может)
    N(row(i),:,v) = 0; 
    
    br = floor((row(i)-.5)/3)*3+1;
    bc = floor((col(i)-.5)/3)*3+1;
    
    % убираем субквадрат (9 значеий) с данным числом (больше в субквадрате его быть не может)
    N(br:br+2,bc:bc+2,v) = 0; 
    
    N(row(i),col(i),v) = 1;
    
end

% поиск и проверка возможных значений в каждой клетке, если возможно
% только одно значение, то проставляем его в клетку
for col = 1:9
    for row = 1:9
        v = find(N(row,col,:));
        allow.(sprintf('cell_%d',k)) = v;
        k = k + 1;
    end
end

return