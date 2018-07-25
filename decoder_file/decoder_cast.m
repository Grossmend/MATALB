
% функция перекодировки в кириллицу ()
function outputVar = decoder_cast(inputVar)

    % коды русских букв
    rus = [1040:1103 1025 1105];
    
    % если есть русские буквы, то не надо перекодировать
    if numel(find(rus==max(abs(inputVar))))>0 
        outputVar = inputVar;
    % перекодировка из dos (английские буквы при этом не меняются)    
    else
        a = unicode2native(inputVar,'windows-1251');
        outputVar = native2unicode(abs(a),'UTF-8');
    end
    
end
