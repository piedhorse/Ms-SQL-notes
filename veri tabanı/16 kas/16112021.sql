
use kutuphaneyeni

/*DDL KOMUTLARI ( DATA DEFINITION LANGUAGE */
--CREATE: nesne yaratmak için

create database deneme
use deneme
create table tbl_ogrenci
(
ogrencino int primary key,
ad nvarchar(30),
soyad nvarchar(30)
)

--ALTER : nesne düzenlemek için
alter table tbl_ogrenci add dtarih date /* tabloya yeni bir sutun ekledi*/
alter table tbl_ogrenci alter column soyad nvarchar(50) /* tablodaki soyadý alanýnýn 
karakter sayýsýný güncelledi*/
alter table tbl_ogrenci drop column dtarih /* tablodaki bir alaný silmek için*/

alter table tbl_ogrenci add unique (ogrencino)
alter table tbl_ogrenci add primary key (ogrencino)
alter table tbl_ogrenci add foreign key (bolum) references tbl_bolumler(bolumkodu)
alter table tbl_ogrenci add check (dtarih>'01.01.2000')
alter table ogrenci alter column dtarih date
select * from ogrenci

--DROP: nesne silmek için*/
drop table tbl_ogrenci
drop database deneme
truncate table tbl_ogrenci


/*DML KOMUTLARI (DATA MANUPULATION LANGUAGE)*/
--INSERT : TABLOYA VERÝ(KAYIT) GÝRER

insert into ogrenci (ad,soyad,dtarih,cinsiyet,sinif) values
 ('sibel','birtane','09.11.1985','K','12c')

insert into ogrenci values ('Baran','Yýlmaz','08.22.2002','E','10a',35)

--DELETE : TABLODAN KAYIT SÝLER
delete from ogrenci where ogrno=1001

--UPDATE : KAYIT GÜNCELLER
update ogrenci set sinif='12F' where ogrno=10 
update ogrenci set sinif='12F' where ad='melike' and soyad='toprak'

-- SELECT: SORGULAMA/LÝSTELEME
select * from ogrenci
select ogrno,ad,soyad from ogrenci

select * from ogrenci where ad='ayþe'
select * from ogrenci where ad='ayþe' or ad='emine'
select * from ogrenci where ad='ayþe'and ad='emine'
select * from ogrenci where ad='deniz'and cinsiyet='K'
select * from ogrenci where ad='deniz'and cinsiyet='E'
select * from ogrenci where ad='deniz'or cinsiyet='E'
select * from ogrenci where (ad='ayþe') or (ad='deniz'and cinsiyet='E')

select * from ogrenci order by ad asc /* alfabetik artan sýralama*/
select * from ogrenci order by ad desc /* alfabetik azalan sýralama*/
select * from ogrenci order by ad asc, soyad asc /* iki alanda alfabetik artan sýralama*/

select * from ogrenci where ogrno<20 order by ogrno desc
select * from ogrenci where ogrno>20
select * from ogrenci where ogrno>=20
select * from ogrenci where ogrno<=20
select * from ogrenci where ogrno=20
select * from ogrenci where ogrno!=20
select * from ogrenci where ogrno<>20 

/* puaný 80dan büyük olan erkek öðrencileri puanýna göre azalan sýralayýnýz*/
select * from ogrenci where puan>80 and cinsiyet='E' order by puan desc


/* Sýnýfý 12a,12b,12c,12d olanlarý listeleyinz*/
select * from ogrenci where sinif='12a' or sinif='12b' or sinif='12c' or sinif='12d' 
order by sinif asc, ad asc

select * from ogrenci where sinif in('12a','12b','12c','12d' ) order by sinif asc, ad asc

select * from ogrenci where ad like 'A%'


select * from ogrenci where ad like '%An%'
select * from ogrenci where ad like '%An'

select * from ogrenci where ad like '___'/*ismi 3 harfli olanlar*/
select * from ogrenci where ad like '_D_' /*ismi 3 harfli olup, ikinci harfi d olanlar*/
select * from ogrenci where ad like '[AD]%' order by ad
select * from ogrenci where ad like '[A-D]%' and cinsiyet='E' and sinif like '10_' 
order by ad

select * from ogrenci where ad like '[A-D]%' and cinsiyet='E' and sinif not like '10_' 
order by ad

select * from ogrenci where ad like '[^A-Y]%' order by ad

select * from ogrenci where puan is null /* null deðerleri sorgulama*/

select * from ogrenci where puan between 50 and 75 /* iki deðer arasýnda sorgulama*/


/* puaný 50 ve 75 arasýnda olan kýzlarý, puanýna göre azalan liste*/ 
select * from ogrenci where puan between 50 and 75  and cinsiyet='K'
 order by puan desc

 /*TEKRARSIZ LÝSTELEME*/
 SELECT distinct(sinif) from ogrenci order by sinif 

 /*okuldaki öðrenci sayýsýný bulunuz*/
 select count(*) as [ okuldaki öðrenci sayýsý] from ogrenci

  /*okuldaki kýz öðrenci sayýsýný bulunuz*/
 select count(*) as [ okuldaki öðrenci sayýsý] from ogrenci where cinsiyet='K'


 /* okulda kaç farklý þube var ise sayýsýný getirin*/
 select count(distinct(sinif))as [okuldaki þube sayýsý] from ogrenci

 /* MATEMATÝKSEL FONKSÝYONLAR*/
 SELECT 3*5 as [sayýlarýn çarpýmý]

 select abs(-1.25) /* mutlak deðer*/
  select sin(45)
  select ceiling(3.45) /* bir üst sayýya yukarýya yuvarlama*/
  select floor(3.45) /* aþaðýya yuvarlama*/
  select round(3.456,2) /*kaç basamak yuvarlanacaksa*/
  select log10(10) /*logaritma*/
  select pi() /*pi sayýsý*/

  select round(pi(),2) /* pi sayýsýný noktadan sonra 2 basamak olacak þekilde yuvarla*/
  select power(2,5) /* birinci parametre sayý, 2.parametre üs. Sayýnýn üssünü alýr*/


  select rand() /* 0-1 arasýnda random sayý üretir.*/

  /*1 ile 10 arasýnda random tam sayý üretin*/
select ceiling(rand()*10)
select floor(rand()*10)
select round((rand()*10),0)

select sqrt(16) /* karekök alýr*/
select SQUARE(16) /* sayýnýn karesini alýr*/

/* yarýçapý 5 olan dairenin alanýný bulunuz*/
select pi()*SQUARE(5) as[dairenin alaný]

/*TARÝH SAAT FONKSÝYONLARI*/
select getdate() /* anlýk tarih/zaman bilgisi döndürür*/

SELECT dateadd(dd,5,getdate()) /* þunaki zaman bilgisine 5 gün ekle*/
SELECT dateadd(MM,5,getdate()) /* þunaki zaman bilgisine 5 ay ekle*/
SELECT dateadd(YY,5,getdate()) /* þunaki zaman bilgisine 5 yýl ekle*/
SELECT dateadd(hh,5,getdate()) /* þunaki zaman bilgisine 5 saat ekle*/
SELECT dateadd(WW,5,getdate()) /* þunaki zaman bilgisine 5 hafta ekle*/
SELECT dateadd(MINUTE,5,getdate()) /* þunaki zaman bilgisine 5 dakika ekle*/

/*kütüphaneden kitap aldýðý tarihten 15gün geçmiþ kayýtlarý getiriniz.*/
select * from islem where dateadd(dd,15,atarih)<vtarih

select datediff(yy,'09.11.1985',getdate()) /* iki tarih arasýnda yýl çýkarma yapar*/
select datediff(MM,'09.11.1985',getdate()) /* iki tarih arasýnda ay çýkarma yapar*/
select datediff(DD,'09.11.1985',getdate()) /* iki tarih arasýnda gün çýkarma yapar*/
select datediff(WW,'09.11.1985',getdate()) /* iki tarih arasýnda hafta çýkarma yapar*/

/* öðrencilerin aldýklarý kitaplarý kaç günde geri getirdiklerini bulunuz*/
select islemno, ogrno,kitapno, datediff(dd,atarih,vtarih) as [ödünç süresi] 
from islem order by [ödünç süresi] asc

select datename(WEEKDAY,getdate()) as [haftanýn günü]
select datename(MONTH,getdate()) as [ay bilgisi]
select datename(day,getdate()) as [ayýn kaçý bilgisi]
select datename(HOUR,getdate()) as [saat bilgisi]

select datepart(year,getdate()) /* tarih parçalama*/
select datepart(month,getdate())
select datepart(day,getdate())
select datepart(HOUR,getdate())
select datepart(MINUTE,getdate())
select datepart(day, '11.16.2021')
select datepart(day,atarih) from islem

/*kasým ayýnda doðmuþ kýz öðrencileri getirin*/
select * from ogrenci where datepart(mm,dtarih)=11 and cinsiyet='K' order by dtarih
select * from ogrenci where datename(month,dtarih)='november' and cinsiyet='K' order by dtarih

select day(getdate())
select month(getdate())
select year(getdate())
select datepart(quarter,getdate()) /* yýlýn kaçýncý çeyreði*/
select datepart(week,getdate()) /*yýlýn kaçýncý haftasý*/
select datepart(WEEKDAY,getdate()) /*haftanýn kaçýncý günü*/

select SYSDATETIME()
select GETUTCDATE() as [UTC+0]
select getdate() as [utc+3.0]

/*STRING FONKSÝYONLAR*/

Select ASCII('A') /* ascii karakter tablosundaki yerini*/
select char(65) /* ascii karakter deðerini gir, char karþýlýðý*/

select left(ad,3) as [soldan 3harf] from ogrenci /*soldan karakter alma*/
select right(ad,3) as [saðdan 3harf] from ogrenci
select substring(ad,1,3) as [soldan 3harf] from ogrenci /*string parçalama*/
select substring('arel üniversitesi', 2,7)
select len('arel üniversitesi') /*karakter sayýsý*/
select lower('arel üniversitesi') /*küçük harfe çevir*/
select upper('arel üniversitesi') /*büyük harfe çevir*/
select ltrim('    arel üniversitesi     ') /*soldaki boþklarý temizle*/
select rtrim('    arel üniversitesi     ') /*saðdaki boþklarý temizle*/

select replace('arel üniversitesi','i','*') /*i harflerini * ile deðiþtir*/
select reverse('arel üniversitesi') /*tersten yaz*/
select concat(ad,soyad) as [ADSOYAD] from ogrenci /*birleþtirme yapar*/

select ad+space(13)+soyad from ogrenci /*space istediðin kadar boþuk karakteri ekler*/
select concat(rtrim(ad),soyad) from ogrenci

/*isminin sonunda boþluk olan kayýtlarý getirin*/
select ad,soyad from ogrenci where ad like '%[ ]'

/*




