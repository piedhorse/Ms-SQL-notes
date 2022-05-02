
use kutuphaneyeni

/*DDL KOMUTLARI ( DATA DEFINITION LANGUAGE */
--CREATE: nesne yaratmak i�in

create database deneme
use deneme
create table tbl_ogrenci
(
ogrencino int primary key,
ad nvarchar(30),
soyad nvarchar(30)
)

--ALTER : nesne d�zenlemek i�in
alter table tbl_ogrenci add dtarih date /* tabloya yeni bir sutun ekledi*/
alter table tbl_ogrenci alter column soyad nvarchar(50) /* tablodaki soyad� alan�n�n 
karakter say�s�n� g�ncelledi*/
alter table tbl_ogrenci drop column dtarih /* tablodaki bir alan� silmek i�in*/

alter table tbl_ogrenci add unique (ogrencino)
alter table tbl_ogrenci add primary key (ogrencino)
alter table tbl_ogrenci add foreign key (bolum) references tbl_bolumler(bolumkodu)
alter table tbl_ogrenci add check (dtarih>'01.01.2000')
alter table ogrenci alter column dtarih date
select * from ogrenci

--DROP: nesne silmek i�in*/
drop table tbl_ogrenci
drop database deneme
truncate table tbl_ogrenci


/*DML KOMUTLARI (DATA MANUPULATION LANGUAGE)*/
--INSERT : TABLOYA VER�(KAYIT) G�RER

insert into ogrenci (ad,soyad,dtarih,cinsiyet,sinif) values
 ('sibel','birtane','09.11.1985','K','12c')

insert into ogrenci values ('Baran','Y�lmaz','08.22.2002','E','10a',35)

--DELETE : TABLODAN KAYIT S�LER
delete from ogrenci where ogrno=1001

--UPDATE : KAYIT G�NCELLER
update ogrenci set sinif='12F' where ogrno=10 
update ogrenci set sinif='12F' where ad='melike' and soyad='toprak'

-- SELECT: SORGULAMA/L�STELEME
select * from ogrenci
select ogrno,ad,soyad from ogrenci

select * from ogrenci where ad='ay�e'
select * from ogrenci where ad='ay�e' or ad='emine'
select * from ogrenci where ad='ay�e'and ad='emine'
select * from ogrenci where ad='deniz'and cinsiyet='K'
select * from ogrenci where ad='deniz'and cinsiyet='E'
select * from ogrenci where ad='deniz'or cinsiyet='E'
select * from ogrenci where (ad='ay�e') or (ad='deniz'and cinsiyet='E')

select * from ogrenci order by ad asc /* alfabetik artan s�ralama*/
select * from ogrenci order by ad desc /* alfabetik azalan s�ralama*/
select * from ogrenci order by ad asc, soyad asc /* iki alanda alfabetik artan s�ralama*/

select * from ogrenci where ogrno<20 order by ogrno desc
select * from ogrenci where ogrno>20
select * from ogrenci where ogrno>=20
select * from ogrenci where ogrno<=20
select * from ogrenci where ogrno=20
select * from ogrenci where ogrno!=20
select * from ogrenci where ogrno<>20 

/* puan� 80dan b�y�k olan erkek ��rencileri puan�na g�re azalan s�ralay�n�z*/
select * from ogrenci where puan>80 and cinsiyet='E' order by puan desc


/* S�n�f� 12a,12b,12c,12d olanlar� listeleyinz*/
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

select * from ogrenci where puan is null /* null de�erleri sorgulama*/

select * from ogrenci where puan between 50 and 75 /* iki de�er aras�nda sorgulama*/


/* puan� 50 ve 75 aras�nda olan k�zlar�, puan�na g�re azalan liste*/ 
select * from ogrenci where puan between 50 and 75  and cinsiyet='K'
 order by puan desc

 /*TEKRARSIZ L�STELEME*/
 SELECT distinct(sinif) from ogrenci order by sinif 

 /*okuldaki ��renci say�s�n� bulunuz*/
 select count(*) as [ okuldaki ��renci say�s�] from ogrenci

  /*okuldaki k�z ��renci say�s�n� bulunuz*/
 select count(*) as [ okuldaki ��renci say�s�] from ogrenci where cinsiyet='K'


 /* okulda ka� farkl� �ube var ise say�s�n� getirin*/
 select count(distinct(sinif))as [okuldaki �ube say�s�] from ogrenci

 /* MATEMAT�KSEL FONKS�YONLAR*/
 SELECT 3*5 as [say�lar�n �arp�m�]

 select abs(-1.25) /* mutlak de�er*/
  select sin(45)
  select ceiling(3.45) /* bir �st say�ya yukar�ya yuvarlama*/
  select floor(3.45) /* a�a��ya yuvarlama*/
  select round(3.456,2) /*ka� basamak yuvarlanacaksa*/
  select log10(10) /*logaritma*/
  select pi() /*pi say�s�*/

  select round(pi(),2) /* pi say�s�n� noktadan sonra 2 basamak olacak �ekilde yuvarla*/
  select power(2,5) /* birinci parametre say�, 2.parametre �s. Say�n�n �ss�n� al�r*/


  select rand() /* 0-1 aras�nda random say� �retir.*/

  /*1 ile 10 aras�nda random tam say� �retin*/
select ceiling(rand()*10)
select floor(rand()*10)
select round((rand()*10),0)

select sqrt(16) /* karek�k al�r*/
select SQUARE(16) /* say�n�n karesini al�r*/

/* yar��ap� 5 olan dairenin alan�n� bulunuz*/
select pi()*SQUARE(5) as[dairenin alan�]

/*TAR�H SAAT FONKS�YONLARI*/
select getdate() /* anl�k tarih/zaman bilgisi d�nd�r�r*/

SELECT dateadd(dd,5,getdate()) /* �unaki zaman bilgisine 5 g�n ekle*/
SELECT dateadd(MM,5,getdate()) /* �unaki zaman bilgisine 5 ay ekle*/
SELECT dateadd(YY,5,getdate()) /* �unaki zaman bilgisine 5 y�l ekle*/
SELECT dateadd(hh,5,getdate()) /* �unaki zaman bilgisine 5 saat ekle*/
SELECT dateadd(WW,5,getdate()) /* �unaki zaman bilgisine 5 hafta ekle*/
SELECT dateadd(MINUTE,5,getdate()) /* �unaki zaman bilgisine 5 dakika ekle*/

/*k�t�phaneden kitap ald��� tarihten 15g�n ge�mi� kay�tlar� getiriniz.*/
select * from islem where dateadd(dd,15,atarih)<vtarih

select datediff(yy,'09.11.1985',getdate()) /* iki tarih aras�nda y�l ��karma yapar*/
select datediff(MM,'09.11.1985',getdate()) /* iki tarih aras�nda ay ��karma yapar*/
select datediff(DD,'09.11.1985',getdate()) /* iki tarih aras�nda g�n ��karma yapar*/
select datediff(WW,'09.11.1985',getdate()) /* iki tarih aras�nda hafta ��karma yapar*/

/* ��rencilerin ald�klar� kitaplar� ka� g�nde geri getirdiklerini bulunuz*/
select islemno, ogrno,kitapno, datediff(dd,atarih,vtarih) as [�d�n� s�resi] 
from islem order by [�d�n� s�resi] asc

select datename(WEEKDAY,getdate()) as [haftan�n g�n�]
select datename(MONTH,getdate()) as [ay bilgisi]
select datename(day,getdate()) as [ay�n ka�� bilgisi]
select datename(HOUR,getdate()) as [saat bilgisi]

select datepart(year,getdate()) /* tarih par�alama*/
select datepart(month,getdate())
select datepart(day,getdate())
select datepart(HOUR,getdate())
select datepart(MINUTE,getdate())
select datepart(day, '11.16.2021')
select datepart(day,atarih) from islem

/*kas�m ay�nda do�mu� k�z ��rencileri getirin*/
select * from ogrenci where datepart(mm,dtarih)=11 and cinsiyet='K' order by dtarih
select * from ogrenci where datename(month,dtarih)='november' and cinsiyet='K' order by dtarih

select day(getdate())
select month(getdate())
select year(getdate())
select datepart(quarter,getdate()) /* y�l�n ka��nc� �eyre�i*/
select datepart(week,getdate()) /*y�l�n ka��nc� haftas�*/
select datepart(WEEKDAY,getdate()) /*haftan�n ka��nc� g�n�*/

select SYSDATETIME()
select GETUTCDATE() as [UTC+0]
select getdate() as [utc+3.0]

/*STRING FONKS�YONLAR*/

Select ASCII('A') /* ascii karakter tablosundaki yerini*/
select char(65) /* ascii karakter de�erini gir, char kar��l���*/

select left(ad,3) as [soldan 3harf] from ogrenci /*soldan karakter alma*/
select right(ad,3) as [sa�dan 3harf] from ogrenci
select substring(ad,1,3) as [soldan 3harf] from ogrenci /*string par�alama*/
select substring('arel �niversitesi', 2,7)
select len('arel �niversitesi') /*karakter say�s�*/
select lower('arel �niversitesi') /*k���k harfe �evir*/
select upper('arel �niversitesi') /*b�y�k harfe �evir*/
select ltrim('    arel �niversitesi     ') /*soldaki bo�klar� temizle*/
select rtrim('    arel �niversitesi     ') /*sa�daki bo�klar� temizle*/

select replace('arel �niversitesi','i','*') /*i harflerini * ile de�i�tir*/
select reverse('arel �niversitesi') /*tersten yaz*/
select concat(ad,soyad) as [ADSOYAD] from ogrenci /*birle�tirme yapar*/

select ad+space(13)+soyad from ogrenci /*space istedi�in kadar bo�uk karakteri ekler*/
select concat(rtrim(ad),soyad) from ogrenci

/*isminin sonunda bo�luk olan kay�tlar� getirin*/
select ad,soyad from ogrenci where ad like '%[ ]'

/*




