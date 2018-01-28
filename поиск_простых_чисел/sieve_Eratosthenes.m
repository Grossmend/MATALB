
%% решето Эратосфена

clearvars

tic
   
n = 100000000;

mat = (1:1:n);
mat(1) = 0;
for i = 1:n
    if mat(i) > 1
        for j = i*2:i:length(mat)
            mat(j) = 0;
        end
%         ln = length(mat);
%         mat(i*2:i:ln) = 0;
    end
end

mat(mat == 0) = [];
count = length(mat);

toc

%% стандартная функция от MATLAB

clearvars

tic

n = 100000000;
mat = primes(n); %#ok

toc

%% решето Эратосфена булевыми значениями 

clearvars

tic

n = 100000000;
mat = true(n,1);
mat(1) = false;
last = 2;
fsqr = floor(sqrt(n));

while(last < fsqr)
%     for i = last*2:last:n
%         primes(i) = 0;
%     end
    mat(last*2:last:n) = false;
    
    sel = find(mat((last+1):(fsqr+1)));
    if(any(sel))
        last = last + min(sel);
    else
        last = fsqr + 1;
    end
end

mat = find(mat);

toc

%%