% by Grossmend, 2016

% метод отжига ( на примере задачи коммивояжера )

%--------------------------------------------------------------------------
tic

% clearvars -except cities
clearvars

% -----------------------------ИТЕРАЦИИ------------------------------------
% кол-во итераций
m = 1000000;
% -----------------------------ПАРАМЕТРЫ-----------------------------------
% начальная температура
Tstart = 100000;

% конечная температура
Tend = 0.1;

% начальная температура для вычислений
T = Tstart;

% расстояние
S = inf;

% количество городов
n = 250;

% рисовать графику?
g = 1;

% --------------------------------ПАМЯТЬ-----------------------------------

% матрица расстояний
dist = zeros(n,n); 

% -------------------------------------------------------------------------

% генерация городов (x,y)
cities = rand(n,2)*100;

% формируем заранее список случайных чисел
RANDONE = rand(m,1);

% формируем два случайных города заранее
D = randi(n,m,2);

% задаем случайный маршрут
ROUTE = randperm(n);

% создаем матрицу расстояний
for i = 1:n
    
    for j = 1:n
        
        % dist ( расстояния )
        dist(i,j) = sqrt((cities(i,1) - cities(j,1))^2 + ...
           (cities(i,2) - cities(j,2))^2);       
            
    end
    
end
 
% поехали оптимизировать, время от кол-ва итераций
for k = 1:m
    
    
    % сбрасываем потенциальное расстояние
    Sp = 0;
    
    % здесь условие создания потенциальных маршрутов, ROUTEp -
    % потенциальный маршрут
    
    % потенциальный маршрут
    ROUTEp = ROUTE;

    % два случайных города
    transp = D(k,[1,2]);
    
    % если тут не понятно, посмотрите код из первой части статьи.
    
    if transp(1) < transp(2)
        
        if transp(1) ~= 1 && transp(2) ~= n
            
            S = dist(ROUTE(transp(1)-1),ROUTE(transp(1))) + ...
                dist(ROUTE(transp(2)),ROUTE(transp(2)+1));
            
        elseif transp(1) ~= 1 && transp(2) == n
            
            S = dist(ROUTE(transp(1)-1),ROUTE(transp(1))) + ...
                dist(ROUTE(transp(2)),ROUTE(1));
            
        elseif transp(1) == 1 && transp(2) ~= n
            
            S = dist(ROUTE(end),ROUTE(transp(1))) + ...
                 dist(ROUTE(transp(2)),ROUTE(transp(2)+1));
             
        end           
            
    else
              
        if transp(2) ~= 1 && transp(1) ~= n
            
            S = dist(ROUTE(transp(2)-1),ROUTE(transp(2))) + ...
                 dist(ROUTE(transp(1)),ROUTE(transp(1)+1));
            
        elseif transp(2) ~= 1 && transp(1) == n
            
            S = dist(ROUTE(transp(2)-1),ROUTE(transp(2))) + ...
                 dist(ROUTE(transp(1)),ROUTE(1));
            
        elseif transp(2) == 1 && transp(1) ~= n
            
            S = dist(ROUTE(end),ROUTE(transp(2))) + ...
                 dist(ROUTE(transp(1)),ROUTE(transp(1)+1));
             
        end        
    end
    
 %-------------------------------------------------------------------------
    
     if transp(1) < transp(2)
        ROUTEp(transp(1):transp(2)) = ROUTEp(transp(2):-1:transp(1));
        
        if transp(1) ~= 1 && transp(2) ~= n
            
            Sp = dist(ROUTEp(transp(1)-1),ROUTEp(transp(1))) + ...
                dist(ROUTEp(transp(2)),ROUTEp(transp(2)+1));
            
        elseif transp(1) ~= 1 && transp(2) == n
            
            Sp = dist(ROUTEp(transp(1)-1),ROUTEp(transp(1))) + ...
                dist(ROUTEp(transp(2)),ROUTEp(1));
            
        elseif transp(1) == 1 && transp(2) ~= n
            
            Sp = dist(ROUTEp(end),ROUTEp(transp(1))) + ...
                 dist(ROUTEp(transp(2)),ROUTEp(transp(2)+1));          
                      
        end           
            
    else
        
        ROUTEp(transp(2):transp(1)) = ROUTEp(transp(1):-1:transp(2));
        
        if transp(2) ~= 1 && transp(1) ~= n
            
            Sp = dist(ROUTEp(transp(2)-1),ROUTEp(transp(2))) + ...
                 dist(ROUTEp(transp(1)),ROUTEp(transp(1)+1));
            
        elseif transp(2) ~= 1 && transp(1) == n
            
            Sp = dist(ROUTEp(transp(2)-1),ROUTEp(transp(2))) + ...
                 dist(ROUTEp(transp(1)),ROUTEp(1));
            
        elseif transp(2) == 1 && transp(1) ~= n
            
            Sp = dist(ROUTEp(end),ROUTEp(transp(2))) + ...
                 dist(ROUTEp(transp(1)),ROUTEp(transp(1)+1));            
             
        end        
     end
    
%--------------------------------------------------------------------------    
    if Sp < S
        ROUTE = ROUTEp;
        iter = k;                          
    else

        % вычисляем вероятность перехода
        P = exp((-(Sp - S)) / T);
       
            if RANDONE(k) <= P
                ROUTE = ROUTEp;                          
            end
        
    end
    
    	% уменьшаем температуру
        T = Tstart / k;

        % проверяем условие выхода
        if T < Tend
            break;
        end;      
end

% рисуем графику
citiesOP(:,[1,2]) = cities(ROUTE(:),[1,2]);
plot([citiesOP(:,1);citiesOP(1,1)],[citiesOP(:,2);citiesOP(1,2)],'-r.')

msgbox ('Выполнено!')

% очищаем переменые
clearvars -except cities ROUTE S iter

% смотрим время
toc