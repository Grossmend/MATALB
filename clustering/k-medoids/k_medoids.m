function [distrib, center, cost_present] = k_medoids(dist,k) 
% ������� ������� ������������� k-medoids ����

    % ���-�� ������
    n = size(dist,1);
    
    % ��������� ����������� �����
    center = randperm(n);
    center = sort(center(1:k));
    
    count = 0;
    while 1
        distrib = clustering(dist,center);
        [center, cost_present] = new_center(dist,distrib,k);
        if(center==404)
            error('������������ ��������� �� ��������. ������� �� ������')
        end
        if count > 0 && cost_present == cost_past
            break;
        end
        cost_past = cost_present;
        count = count + 1;
    end
    
end

% ������� ������������� ������ �� �������� 
function distrib = clustering(dist,center)
    S  = dist(center,:);
    [~,distrib] = min(S,[],1);
end

% ������� ���������� ����������� ����� � i-�� �������� ������ � ������ S
% � ������ �������� �� ������� �������, � ������� ����� ���� ����� �������
% �������� ����� �����������
function [center, cost] = new_center(dist,distrib,k)

    cost = nan(k,1);
    center = zeros(1,k);
    for i = 1:k
        distrib_cluster = find(distrib == i);
        % ���� �� ������� ������� ������-���� ��������, ������ �������� ���
        if(isempty(distrib_cluster)==1)
            center = 404;
            return
        end
        [cost(i), min_idx] = min(sum(dist(distrib_cluster,distrib_cluster),2));
        center(i) = distrib_cluster(min_idx);
    end
    cost = sum(cost);
    
end

