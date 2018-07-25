% детерминированный логический алгоритм
function [M,imp] = CheckSolveSudoku(M)

% еще не возможно
imp = 0;

% фиктивное увеличение матрицы, чтобы цикл запустился
previousM = 2*M;

% цикл до тех пор пока есть что вставлять
while any(M(:)-previousM(:)) 
    
    previousM=M;
    
    N=ones(9,9,9);
    
    % zero out untrue entries for input
    [row,col]=find(M);
    
    for i=1:length(row)
        N(row(i),col(i),:)=0;
        N(row(i),col(i),M(row(i),col(i))) = 1;
    end
    
    if any(any(sum(N,3)<1))
        % нет решения
        imp=1; 
        return
    end
    
    % получаем индексы строк и столбцов заполненных значений
    [row,col]=find(sum(N,3)<2);
    
    % выжигание значений (на выходе получаем гипотетические значения где могут стоять, там 1)
    for i=1:length(row)
        
        if any(any(sum(N,3)<1))
            % нет решения
            imp=1;
            % disp(M(:,1)');
            return
        end
        
        v = find(N(row(i),col(i),:));
        M(row(i),col(i)) = v;
        % убираем колонку с данным числом (больше в колонке его быть не может)
        N(:,col(i),v)=0;
        % убираем строку с данным числом (больше в строке его быть не может)
        N(row(i),:,v)=0; 
        
        br = floor((row(i)-.5)/3)*3+1;
        bc = floor((col(i)-.5)/3)*3+1;
        
        % убираем субквадрат (9 значеий) с данным числом (больше в субквадрате его быть не может)
        N(br:br+2,bc:bc+2,v)=0; 
        N(row(i),col(i),v)=1;
        
    end
    
    % поиск и проверка возможных значений в каждой клетке, если возможно
    % только одно значение, то проставляем его в клетку
    for row=1:9
        for col=1:9
            v=find(N(row,col,:));
            if length(v)==1
                M(row,col)=v;
            end
        end
    end
    
    % поиск и проверка значений по строке, если одна строка содержит
    % только одно уникальное значения для вставки, то вставляем его
    for row=1:9
        for v=1:9
            col=find(N(row,:,v));
            if length(col)==1
                M(row,col)=v;
            end
        end
    end

    % поиск и проверка значений по столбцу, если один столбуц содержит
    % только одно уникальное значения для вставки, то вставляем его
    for col=1:9
        for v=1:9
            row=find(N(:,col,v));
            if length(row)==1
                M(row,col)=v;
            end
        end
    end
    
    % для каждого субквадрата, если субквадрат содержит...
    for row=[1 4 7]
        for col=[1 4 7]
            for v=1:9
                Q=N(row:row+2,col:col+2,v);
                [pr,pc]=find(Q);
                if length(pr)==1
                    M(row+pr-1,col+pc-1)=v;
                end
            end
        end
    end
end

return