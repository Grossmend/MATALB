
tic
close all

%% ���������1

% ����� ����� � ������ ������������� ��������
nCluster = 200;
% ����� ���������
k = 3;
% �������� ������? (1, 0)
gr = 1;

%% ��������� ������

cities = randn(1,2) + rand()*10;

% ���������� ���� ������� ��� ������
for i=1:k
    cities = [randn(nCluster,2) + rand()*10; cities]; %#ok
end

% ����������� �� ������������� ��������
cities(1,:) = [];
cities(:,1) = cities(:,1) + min(cities(:,1))*-1 + 1;
cities(:,2) = cities(:,2) + min(cities(:,2))*-1 + 1;
if gr == 1
    plot(cities(:,1),cities(:,2),'.')
end


%% ������������ ������� ����������

n = nCluster*k;
dist = zeros(n,n);
for i = 1:n
    for j = 1:n
        dist(i,j) = sqrt((cities(i,1) - cities(j,1))^2 + ...
           (cities(i,2) - cities(j,2))^2);
    end
end

%% �������������

% ���������� ��������
numberVariant = 100;
bestResult = inf;
for i = 1:numberVariant
    
    % output
    % k - ���-�� ���������
    % dist - ������� ���������� ����� �������
    
    % input
    % distrib - ��������� �� �������� (���������� ������ �� ��� �����)
    % center - ��������� ������� �������� 
    % minSum - ������ ��������� ������������� ����� i ���
    
    [distrib, center, minSum] = k_medoids(dist,k);
    
    % ������ ����������� � ���������
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

%% ��������� ������� �������������

if gr == 1

    hold on
    for i = 1:k
        plot(cities(bestDistrib == i,1), cities(bestDistrib == i,2), '.', 'markersize', 13)
    end
    hold off

    % ��������� �������
    title('������������� k-medoids')
    % �����
    grid on
    % ������� �� x
    xlabel('x - data')
    % ������� �� y
    ylabel('y - data')
    % ������������ ��� ������� �����
    set(gca,'color','k')
    % ������������ ����� ������ �����
    set(gca,'gridcolor', 'w')

end
toc

