% ����������������� ���������� ��������
function [M,imp] = CheckSolveSudoku(M)

% ��� �� ��������
imp = 0;

% ��������� ���������� �������, ����� ���� ����������
previousM = 2*M;

% ���� �� ��� ��� ���� ���� ��� ���������
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
        % ��� �������
        imp=1; 
        return
    end
    
    % �������� ������� ����� � �������� ����������� ��������
    [row,col]=find(sum(N,3)<2);
    
    % ��������� �������� (�� ������ �������� �������������� �������� ��� ����� ������, ��� 1)
    for i=1:length(row)
        
        if any(any(sum(N,3)<1))
            % ��� �������
            imp=1;
            % disp(M(:,1)');
            return
        end
        
        v = find(N(row(i),col(i),:));
        M(row(i),col(i)) = v;
        % ������� ������� � ������ ������ (������ � ������� ��� ���� �� �����)
        N(:,col(i),v)=0;
        % ������� ������ � ������ ������ (������ � ������ ��� ���� �� �����)
        N(row(i),:,v)=0; 
        
        br = floor((row(i)-.5)/3)*3+1;
        bc = floor((col(i)-.5)/3)*3+1;
        
        % ������� ���������� (9 �������) � ������ ������ (������ � ����������� ��� ���� �� �����)
        N(br:br+2,bc:bc+2,v)=0; 
        N(row(i),col(i),v)=1;
        
    end
    
    % ����� � �������� ��������� �������� � ������ ������, ���� ��������
    % ������ ���� ��������, �� ����������� ��� � ������
    for row=1:9
        for col=1:9
            v=find(N(row,col,:));
            if length(v)==1
                M(row,col)=v;
            end
        end
    end
    
    % ����� � �������� �������� �� ������, ���� ���� ������ ��������
    % ������ ���� ���������� �������� ��� �������, �� ��������� ���
    for row=1:9
        for v=1:9
            col=find(N(row,:,v));
            if length(col)==1
                M(row,col)=v;
            end
        end
    end

    % ����� � �������� �������� �� �������, ���� ���� ������� ��������
    % ������ ���� ���������� �������� ��� �������, �� ��������� ���
    for col=1:9
        for v=1:9
            row=find(N(:,col,v));
            if length(row)==1
                M(row,col)=v;
            end
        end
    end
    
    % ��� ������� �����������, ���� ���������� ��������...
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