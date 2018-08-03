% by Grossmend, 2016

% ����� ������ ( �� ������� ������ ������������ )

%--------------------------------------------------------------------------
tic

% clearvars -except cities
clearvars

% -----------------------------��������------------------------------------
% ���-�� ��������
m = 1000000;
% -----------------------------���������-----------------------------------
% ��������� �����������
Tstart = 100000;

% �������� �����������
Tend = 0.1;

% ��������� ����������� ��� ����������
T = Tstart;

% ����������
S = inf;

% ���������� �������
n = 250;

% �������� �������?
g = 1;

% --------------------------------������-----------------------------------

% ������� ����������
dist = zeros(n,n); 

% -------------------------------------------------------------------------

% ��������� ������� (x,y)
cities = rand(n,2)*100;

% ��������� ������� ������ ��������� �����
RANDONE = rand(m,1);

% ��������� ��� ��������� ������ �������
D = randi(n,m,2);

% ������ ��������� �������
ROUTE = randperm(n);

% ������� ������� ����������
for i = 1:n
    
    for j = 1:n
        
        % dist ( ���������� )
        dist(i,j) = sqrt((cities(i,1) - cities(j,1))^2 + ...
           (cities(i,2) - cities(j,2))^2);       
            
    end
    
end
 
% ������� ��������������, ����� �� ���-�� ��������
for k = 1:m
    
    
    % ���������� ������������� ����������
    Sp = 0;
    
    % ����� ������� �������� ������������� ���������, ROUTEp -
    % ������������� �������
    
    % ������������� �������
    ROUTEp = ROUTE;

    % ��� ��������� ������
    transp = D(k,[1,2]);
    
    % ���� ��� �� �������, ���������� ��� �� ������ ����� ������.
    
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

        % ��������� ����������� ��������
        P = exp((-(Sp - S)) / T);
       
            if RANDONE(k) <= P
                ROUTE = ROUTEp;                          
            end
        
    end
    
    	% ��������� �����������
        T = Tstart / k;

        % ��������� ������� ������
        if T < Tend
            break;
        end;      
end

% ������ �������
citiesOP(:,[1,2]) = cities(ROUTE(:),[1,2]);
plot([citiesOP(:,1);citiesOP(1,1)],[citiesOP(:,2);citiesOP(1,2)],'-r.')

msgbox ('���������!')

% ������� ���������
clearvars -except cities ROUTE S iter

% ������� �����
toc