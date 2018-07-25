
% ������� ������������� � ��������� ()
function outputVar = decoder_cast(inputVar)

    % ���� ������� ����
    rus = [1040:1103 1025 1105];
    
    % ���� ���� ������� �����, �� �� ���� ��������������
    if numel(find(rus==max(abs(inputVar))))>0 
        outputVar = inputVar;
    % ������������� �� dos (���������� ����� ��� ���� �� ��������)    
    else
        a = unicode2native(inputVar,'windows-1251');
        outputVar = native2unicode(abs(a),'UTF-8');
    end
    
end
