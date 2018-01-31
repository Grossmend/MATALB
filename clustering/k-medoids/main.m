
tic
close all

%% параметры1

% число точек в каждом формированном кластере
nCluster = 200;
% число кластеров
k = 3;
% рисовать график? (1, 0)
gr = 1;

%% генерация вершин

cities = randn(1,2) + rand()*10;

% засовываем одну вершину под другую
for i=1:k
    cities = [randn(nCluster,2) + rand()*10; cities]; %#ok
end

% избавляемся от отрицательных значений
cities(1,:) = [];
cities(:,1) = cities(:,1) + min(cities(:,1))*-1 + 1;
cities(:,2) = cities(:,2) + min(cities(:,2))*-1 + 1;
if gr == 1
    plot(cities(:,1),cities(:,2),'.')
end


%% формирование матрицы расстояний

n = nCluster*k;
dist = zeros(n,n);
for i = 1:n
    for j = 1:n
        dist(i,j) = sqrt((cities(i,1) - cities(j,1))^2 + ...
           (cities(i,2) - cities(j,2))^2);
    end
end

%% кластеризация

% количество итераций
numberVariant = 100;
bestResult = inf;
for i = 1:numberVariant
    
    % output
    % k - кол-во кластеров
    % dist - матриуа расстояний между точками
    
    % input
    % distrib - разбиение на кластеры (индексация таккая же как точек)
    % center - центроиды каждого кластера 
    % minSum - лучшая найденная кластеризация среди i раз
    
    [distrib, center, minSum] = k_medoids(dist,k);
    
    % запись результатов в структуру
    structDistrib.(sprintf('iter_%d', i)).distrib = distrib;
    structDistrib.(sprintf('iter_%d', i)).center = center;
    structDistrib.(sprintf('iter_%d', i)).minSum = minSum;
    
    if(minSum < bestResult)
        bestResult = minSum;
        bestDistrib = distrib;
        bestMin = minSum;
        betsIter = i;
    end
    
end

%% отрисовка графика кластеризации

if gr == 1

    hold on
    for i = 1:k
        plot(cities(bestDistrib == i,1), cities(bestDistrib == i,2), '.', 'markersize', 13)
    end
    hold off

    % заголовок графика
    title('Кластеризация k-medoids')
    % сетка
    grid on
    % подпись по x
    xlabel('x - data')
    % подпись по y
    ylabel('y - data')
    % присваевание оси черного цвета
    set(gca,'color','k')
    % присваевание сетке белого цвета
    set(gca,'gridcolor', 'w')

end
toc

