

/*Bir m��teri no girildi�inde, bu m��teriye ka� araba sat�ld���n� bulan
bir kullan�c� tan�ml� fonksiyon olu�turunuz ve bu fonksiyonu �al��t�r�n�z.*/
create function [dbo].[f_satissay]/* fonksiyonu olu�turdum ve fonksiyon ismimi belirttim*/
(@mno int)/*mno olarak parametre ismimi belirttim yan�na da veri tipini yazd�m*/

returns int /*fonksiyondan d�nen sonucun veri tipi*/
as 
begin  /*alaca�� komutlar�n ba�lang�c� i�in kulland�k */
declare @sonuc int     /*DECLARE KOMUTU: De�i�ken tan�mlamak i�in kullan�l�r. Veriler
                                         bellekte ge�ici olarak kaydedilir. 
			                             Tan�mlad���m�z bu de�i�kene de�er atama i�lemi 
                                         i�in de set ve select komutu kullan�labilir*/ 

set @sonuc=(select count(*) from tbl_satistablosu where mno=@mno)
/*sat�� tablosundaki m��teri numaras�n� 
say b�ylece girilen m��teriye ka� araba sat�ld���n� bulursun*/
return @sonuc /*sonucu d�nd�r*/

end /*bitti*/

select dbo.f_satissay(7) as [satis say�s�] /*girilen m��teri no 7 dir as(alias) ile de 
                                           takma isim verilmi� sat�� say�s� olarak sat�� say�s� g�r�necektir  */
-------------------------------------------------------------------------------------------------







/*Girilen tarihler aras�nda yap�lan al�m sat��lardan el edilen kar/zarar de�erini bulan
kullan�c� tan�ml� fonksiyonu yaz�n�z*/

create function f_karzarar /*fonksiyon olu�turdum */

(@tarih1 date, @tarih2 date) /*parametre ad� ve veri tipini verdim*/

returns money /*fonksiyondan d�necek sonucun veri tipi*/
as
begin /*alaca�� komutlar�n ba�lang�c� i�in kulland�k*/
declare @sonuc money, @alimtutar money, @satistutar money /*de�i�ken tan�mlad�k*/
/*tan�mlad���m�z de�i�kenlere set ile de�er at�yoruz*/

set @alimtutar=(select sum(afiyat) from tbl_alimtablosu where alim_tarih between @tarih1 and @tarih2) /*al�m tablosundaki girilen tarihler aras�nda 
                                                                                                        al�� fiyatlar�n� topla*/
set @satistutar=(select sum(sfiyat) from tbl_satistablosu where sat_tarih between @tarih1 and @tarih2)

set @sonuc=@satistutar-@alimtutar/*birbirinden ��kararak kar/zarar i�lemini yap�yoruz*/
return @sonuc
end


select dbo.f_karzarar('01.01.2010','06.30.2010') as karzarar




------------------------------------------------------------------------------------


/*klavyeden girilen iki say�y� toplayan kull_fonk yaz�n�z.*/
create function f_topla
(@a int, @b int)
returns int
as
begin
return(@a+@b)
end

select dbo.f_topla(11545,385)

/*kuvvet alma i�in kull_tan�ml� bir fon yaz�n�z.*/

create function f_kuvvet
(@sayi int, @us int)
returns bigint
as
begin
declare @sonuc bigint,@sayac int
set @sonuc=1
set @sayac=1
while (@sayac<=@us)
begin
set @sonuc=@sonuc*@sayi
set @sayac=@sayac+1
end
return @sonuc
end

select dbo.f_kuvvet(5125,4)

/*y�ksekli�i ve taban� klavyeden  girilen ��genin alan�n� hesaplayan fon*/
create function f_alan
(@h int, @a int)
returns float
as
begin
return((@a*@h)/2)
end

select dbo.f_alan(5,12)

/**/

/*katsay�lar� girilen denklemin delta fonksiyonu bulan kull_fon yaz�n�z*/
create function f_delta
(@a int,@b int, @c int)
returns int
as
begin
declare @delta int
set @delta=(SQUARE(@b)-(4*@a*@c))
return @delta
end


select dbo.f_delta(2,10,7)


select DATENAME(month,getdate())

/*girilen tarihte ay�n ad�n� getiren t�rk�e d�nd�ren kull_fonk*/

create function f_ayadi
(@tarih date)
returns nvarchar(20)
as
begin
declare @ayno int
set @ayno=(select month(@tarih))
return (select case @ayno 
			when 1 then 'Ocak'
			when 2 then '�ubat'
			when 3 then 'mart'
			when 4 then 'nisan'
			when 5 then 'may�s'
			when 6 then 'haziran'
			when 7 then 'temmuz'
			when 8 then 'a�ustos'
			when 9 then 'eyl�l'
			when 10 then 'ekim'
			when 11 then 'kas�m'
			when 12 then 'aral�k'
			else 'tan�ms�z'
			end
			)
			end


select dbo.f_ayadi(getdate())
select datename(month,getdate())


create function f_ayadi2
(@tarih date)
returns nvarchar(20)
as
begin
declare @ayno int, @ayadi nvarchar(20)
set @ayno=(select month(@tarih))
if (@ayno=1)
set @ayadi='ocak'
else if (@ayno=2)
set @ayadi='�ubat'
else if (@ayno=3)
set @ayadi='mart'
else if (@ayno=4)
set @ayadi='nisan'
else if (@ayno=5)
set @ayadi='may�s'
else if (@ayno=6)
set @ayadi='haziran'
else if (@ayno=7)
set @ayadi='temmuz'
else if (@ayno=8)
set @ayadi='agustos'
else if (@ayno=9)
set @ayadi='eyl�l'
else if (@ayno=10)
set @ayadi='ekim'
else if (@ayno=11)
set @ayadi='kas�m'
else if (@ayno=12)
set @ayadi='aral�k'
else 
set @ayadi='tan�ms�z'
return @ayadi
end

select dbo.f_ayadi2('10.10.2021')