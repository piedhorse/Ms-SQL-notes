

/*Bir müþteri no girildiðinde, bu müþteriye kaç araba satýldýðýný bulan
bir kullanýcý tanýmlý fonksiyon oluþturunuz ve bu fonksiyonu çalýþtýrýnýz.*/
create function [dbo].[f_satissay]/* fonksiyonu oluþturdum ve fonksiyon ismimi belirttim*/
(@mno int)/*mno olarak parametre ismimi belirttim yanýna da veri tipini yazdým*/

returns int /*fonksiyondan dönen sonucun veri tipi*/
as 
begin  /*alacaðý komutlarýn baþlangýcý için kullandýk */
declare @sonuc int     /*DECLARE KOMUTU: Deðiþken tanýmlamak için kullanýlýr. Veriler
                                         bellekte geçici olarak kaydedilir. 
			                             Tanýmladýðýmýz bu deðiþkene deðer atama iþlemi 
                                         için de set ve select komutu kullanýlabilir*/ 

set @sonuc=(select count(*) from tbl_satistablosu where mno=@mno)
/*satýþ tablosundaki müþteri numarasýný 
say böylece girilen müþteriye kaç araba satýldýðýný bulursun*/
return @sonuc /*sonucu döndür*/

end /*bitti*/

select dbo.f_satissay(7) as [satis sayýsý] /*girilen müþteri no 7 dir as(alias) ile de 
                                           takma isim verilmiþ satýþ sayýsý olarak satýþ sayýsý görünecektir  */
-------------------------------------------------------------------------------------------------







/*Girilen tarihler arasýnda yapýlan alým satýþlardan el edilen kar/zarar deðerini bulan
kullanýcý tanýmlý fonksiyonu yazýnýz*/

create function f_karzarar /*fonksiyon oluþturdum */

(@tarih1 date, @tarih2 date) /*parametre adý ve veri tipini verdim*/

returns money /*fonksiyondan dönecek sonucun veri tipi*/
as
begin /*alacaðý komutlarýn baþlangýcý için kullandýk*/
declare @sonuc money, @alimtutar money, @satistutar money /*deðiþken tanýmladýk*/
/*tanýmladýðýmýz deðiþkenlere set ile deðer atýyoruz*/

set @alimtutar=(select sum(afiyat) from tbl_alimtablosu where alim_tarih between @tarih1 and @tarih2) /*alým tablosundaki girilen tarihler arasýnda 
                                                                                                        alýþ fiyatlarýný topla*/
set @satistutar=(select sum(sfiyat) from tbl_satistablosu where sat_tarih between @tarih1 and @tarih2)

set @sonuc=@satistutar-@alimtutar/*birbirinden çýkararak kar/zarar iþlemini yapýyoruz*/
return @sonuc
end


select dbo.f_karzarar('01.01.2010','06.30.2010') as karzarar




------------------------------------------------------------------------------------


/*klavyeden girilen iki sayýyý toplayan kull_fonk yazýnýz.*/
create function f_topla
(@a int, @b int)
returns int
as
begin
return(@a+@b)
end

select dbo.f_topla(11545,385)

/*kuvvet alma için kull_tanýmlý bir fon yazýnýz.*/

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

/*yüksekliði ve tabaný klavyeden  girilen üçgenin alanýný hesaplayan fon*/
create function f_alan
(@h int, @a int)
returns float
as
begin
return((@a*@h)/2)
end

select dbo.f_alan(5,12)

/**/

/*katsayýlarý girilen denklemin delta fonksiyonu bulan kull_fon yazýnýz*/
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

/*girilen tarihte ayýn adýný getiren türkçe döndüren kull_fonk*/

create function f_ayadi
(@tarih date)
returns nvarchar(20)
as
begin
declare @ayno int
set @ayno=(select month(@tarih))
return (select case @ayno 
			when 1 then 'Ocak'
			when 2 then 'þubat'
			when 3 then 'mart'
			when 4 then 'nisan'
			when 5 then 'mayýs'
			when 6 then 'haziran'
			when 7 then 'temmuz'
			when 8 then 'aðustos'
			when 9 then 'eylül'
			when 10 then 'ekim'
			when 11 then 'kasým'
			when 12 then 'aralýk'
			else 'tanýmsýz'
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
set @ayadi='þubat'
else if (@ayno=3)
set @ayadi='mart'
else if (@ayno=4)
set @ayadi='nisan'
else if (@ayno=5)
set @ayadi='mayýs'
else if (@ayno=6)
set @ayadi='haziran'
else if (@ayno=7)
set @ayadi='temmuz'
else if (@ayno=8)
set @ayadi='agustos'
else if (@ayno=9)
set @ayadi='eylül'
else if (@ayno=10)
set @ayadi='ekim'
else if (@ayno=11)
set @ayadi='kasým'
else if (@ayno=12)
set @ayadi='aralýk'
else 
set @ayadi='tanýmsýz'
return @ayadi
end

select dbo.f_ayadi2('10.10.2021')