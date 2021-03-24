clear, clc, close all;

%Sinüs dalgası tanımlanır. Frekans = 210Hz. 
syms t real;
f = 210;
S(t) = sin(2*pi*f*t);

% Tanımlanan sinüs dalgasının tek periyotta görünümü.
t1 = linspace(0,1/f,1000);
figure
plot(t1,S(t1))

% Örnekleme frekansı ve sinüs dalgasının tek periyodundaki örnekleme sayısı.
fs = 1600;
n = fs/f;

% Örnekleme frekansı dalganın frekansıyla örtüşene kadar bir döngü döndürülür. 
% Bu soru için, 21 dalga periyodunda örtüşmektedirler. Toplam 160 örnekleme
% yapılmıştır.
for i = 1:fs
    delta = abs(i*n - round(i*n));
    if delta < 0.0001
        TotalPeriod = i;
        TotalSample = round(i*n);
        break
    end
end

% Kuantizasyon seviyeleriyle bir dizi oluşturulur. Dizide 256 eleman olup
% ilk eleman -1, son eleman 1 olmak üzere her elemanda sabit bir artış
% vardır.
x = 2/255;
A = zeros(256,1);
for i = 1:256
    A(i) = -1 + (i-1)*x;
end

% Orjinal sinyal, önce elde edilen TotalSample = 160 kere örneklenir ve
% dizi haline getirilir.
Sarr = zeros(TotalSample,2);
for i = 1:TotalSample
    Sarr(i,1) = S((i-1)/fs);
    Sarr(i,2) = (i-1)/fs;
end

% Oluşturulan dizi çizilir ve orjinal sinyal ile karşılaştırılır.
figure 
plot(Sarr(:,2),(Sarr(:,1)))
hold on 
t1 = linspace(0,TotalPeriod/f,1000);
plot(t1,S(t1))

% Örnekleme seviyeleri ile örneklenen dizi karşılaştırılır ve eşleştirilir.
% Bu sayede kuantizasyon seviyeleri elde edilir ve kuantizasyon dizisi
% oluşturulur.
j = 1;
QuArr = zeros(TotalSample, 1);
for j = 1:TotalSample
    for i = 1:256
        if A(i) >= Sarr(j,1)
            QuArr(j) = i-1;
            j = j + 1;
            break
        end
    end
end

% Kuantizasyon dizisi ile sinyal tekrar oluşturulur ve orjinal sinyal ile
% karşılaştırılır.
DigiSig = zeros(160,2);
DigiSig(:,1) = QuArr*2/255-1;
x = 1:160;
DigiSig(:,2) = (x-1)/fs;
plot(DigiSig(:,2),(DigiSig(:,1)))
hold on 
t1 = linspace(0,TotalPeriod/f,1000);
plot(t1,S(t1))

% Kuantizasyon seviyelerinin bulunduğu dizi, art arda eklenerek bir satırda
% yazdırılır.
for i = 1:TotalSample
    if i == 1
        result = int2str(QuArr(i));
    else
        result = append(result,',',int2str(QuArr(i)));
    end
end
result = append(result,'\n');
fprintf(result);