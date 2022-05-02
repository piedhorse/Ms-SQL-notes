
create database db_galeri   /*veritaban�n� olu�turduk  */
use db_galeri

/*tablolar�m�z� olu�turduk ve  kategorilerimize parametre ekledik  ard�ndan ise parantez i�inde s�n�rlar�n� belirledik */

--------------------------------------------------------------------------
create table dbo_musteri
(
Mno int primary key identity(1,1), /*primary key (birincil anahtar) tablonun de�i�mez ifadesinin etiketidir*/
Madi nvarchar(20),
Msoyadi nvarchar(20),
Madres nvarchar(50),
Mtel char(11)
)
---------------------------------------------------------------------------

create table dbo_arac
(
Aracno int primary key identity(1,1), /*�DENT�TY (K�ML�K) ise kategorilerin kendisine �zel numaraland�rma yapmas�n� sa�lar*/
Model date,
Marka varchar(50),
Plaka char(8) unique,
Fiyat money
)
----------------------------------------------------------------------------
create table dbo_satis
(
Satno int primary key identity(1,1),
Aracno int foreign key references tbl_arac(Aracno),               /*   foreign key refences (yabanc� anahtar referans� )  ile ba�ka tablonun kategorisini bu tablomuza ba�lad�k   */
Mno int foreign key references tbl_musteri(Mno),
Sat_tarih date,
Sfiyat money
)
-----------------------------------------------------------------------------
create table dbo_alim
(
Alimno int primary key identity(1,1),
Mno int foreign key references tbl_musteri(Mno),
Aracno int foreign key references tbl_arac(Aracno),
Alim_tarih date,
Afiyat money
)

-------------------------------------------------------------------------------





/*  values etiketi tablomuzdaki kategorilere de�er ekler  insert into etiketi ise bunlar� kategorilerin i�ine sokar      */


INSERT into tbl_musteri  values ('Turgut','�zseven','Turhal/Tokat','03562222222')
INSERT into tbl_musteri  values ('Mustafa','�a�layan','Meram/Konya','05112111111')
INSERT into tbl_musteri  values ('Ahmet','Kara','Zile/Tokat','03563333333')
INSERT into tbl_musteri  values ('Murat','Beyaz','Turhal/Tokat','03565555555')
INSERT into tbl_musteri  values ('Elif','Kurt','Be�ikta�/�stanbul','05781471414')
INSERT into tbl_musteri  values ('Ay�e','U�ar','Ta�ova/Amasya','05386666666')
INSERT into tbl_musteri  values ('B�lent','Ayar','Turhal/Tokat','03568888888')



---------------------------------------------------------------------------------------------





INSERT into tbl_arac  values ('2004','Fiat Marea','60TT6060',16000)
INSERT into tbl_arac  values ('2000','Renault Megane','60TT6061',14000)
INSERT into tbl_arac  values ('2007','Ford Focus','60TT6062',28000)
INSERT into tbl_arac  values ('2005','Volkswagen Golf','60TT6063',26000)
INSERT into tbl_arac  values ('1998','Opel Astra','60TT6064',9000)
-----------------------------------------------------------------------------------------------




INSERT into tbl_satis values ('1','1','05.04.2010',17000)
INSERT into tbl_satis values ('4','5','06.01.2010',11500)
INSERT into tbl_satis values ('7','4','06.15.2010',27000)
INSERT into tbl_satis values ('2','1','07.02.2010',17500)



--------------------------------------------------------------------------------------------------------


INSERT into tbl_alim values ('3','1','02.08.2010',15000)
INSERT into tbl_alim values ('6','1','04.12.2010',15500)
INSERT into tbl_alim values ('2','5','04.15.2010',9500)
INSERT into tbl_alim values ('1','2','05.15.2010',14000)
INSERT into tbl_alim values ('5','3','08.22.2010',26000)
    








/*1*/
select * from tbl_musteri order by Madi asc

/*2*/
select * from tbl_arac order by model desc, fiyat asc

/*3*/
select Aracno,Sat_tarih,Sfiyat as [Sati� Fiyat�] from tbl_satis 

/*4*/
select * from tbl_arac where Fiyat>12000 order by Fiyat desc

/*5*/
select * from tbl_arac where Aracno in(select aracno from tbl_satis 
where Sfiyat>10000 or mno=4)

select tbl_arac.* from tbl_arac inner join tbl_satis
on tbl_arac.Aracno=tbl_satis.Aracno
where tbl_satis.Sfiyat>10000 or tbl_satis.Mno=4

/*6*/
select * from tbl_satis where Sat_tarih>'04.30.2010'

select * from tbl_satis where year(Sat_tarih)>='2010' and MONTH(sat_tarih)>4

/*7*/
select aracno, Alim_tarih, Afiyat from tbl_alim where year(alim_tarih)='2010' and
 MONTH(Alim_tarih) between '2' and '6' and Afiyat>10000
 order by Alim_tarih desc, Afiyat desc

 /*8*/
 select * from tbl_satis where Sfiyat between '10000' and '20000' and mno in(2,4)

 /*9*/
 select * from tbl_satis where mno in(select mno from tbl_musteri where Madres like 
 '%turhal%')

 select tbl_satis.*  from tbl_satis inner join tbl_musteri 
 on tbl_musteri.Mno=tbl_satis.Mno
 where tbl_musteri.Madres like '%turhal%'

 select tbl_satis.Satno, tbl_musteri.Madi, tbl_musteri.Msoyadi, tbl_musteri.Madres,
 tbl_satis.Sat_tarih, tbl_satis.Aracno, tbl_satis.Sfiyat 
 from tbl_satis inner join tbl_musteri 
 on tbl_musteri.Mno=tbl_satis.Mno
 where tbl_musteri.Madres like '%turhal%'

 /*10*/
 select * from tbl_musteri where Madres like '%tokat%' and Mtel like '%6%'

 /*11*/
 select madi,msoyadi,Madi,Mtel from tbl_musteri where Madi like 'A%'

 /*12*/
 select marka, model, fiyat from tbl_arac where marka like '%opel%' or marka like '%Fiat%'

 /*13*/
 select * from tbl_arac where model in('1998','2005','2007')


 /*PART 2 SORULAR*/
--1. Ara�lar�n fiyatlar�n� %20 artt�rarak listelemek i�in gerekli sorguyu yaz�n�z.
select aracno, model, Marka,fiyat*1.2 as [zaml� fiyat] from tbl_arac

--2. Ya�� 15ten k���k ara�lar�n fiyatlar�n� %15 artt�rmak i�in gerekli sorguyu yaz�n�z.
update tbl_arac set Fiyat=fiyat*1.15 where datediff(yy,model,getdate())<15

--3. M��terilerin ad ve soyadlar�n� birle�tirerek tek sut�nda artan s�rada listelemek i�in gerekli sorguyu yaz�n�z.
select concat(madi,msoyadi) as [Ad Soyad] from tbl_musteri order by [Ad Soyad] asc

--4. 1,4,7 nolu m��terilere 1,2 ve 5 nolu ara�lardan yap�lan sati�lar�n tarih ve fiyat bilgisini tek s�tunda tarihe g�re azalan �ekilde listeleyiniz.
  select * from tbl_satis aracno in (1,4,5) where Sfiyat and Sat_tarih  mno in (1,4,7)

--5. M��terilerin ad ve soyad bilgisini tek s�tunda birle�tirerek A.Soyad �eklinde isimlendirerek listeleyiniz.
select concat(madi,msoyadi) as [A. Soyad] from tbl_musteri
--6. Yap�lan al�mlar� sadece ay bilgisine g�re artan, al�� fiyat�na g�re azalan s�rada listelemek i�in gerekli sorguyu yaz�n�z.
select* from tbl_alim where Alim_tarih MONTH order by desc
--7. Soyad� 5 karakterden fazla olan m��terilerin ad ve soyad bilgisini ad�n�n ilk harfini ve soyad�n�n 5 harfini birle�tirerek listeleyiniz.
select Msoyadi,Madi  from tbl_musteri    where Msoyadi LIKE '______'   
--8. M��terilerin sadece il bilgilerini artan �ekilde listeleyiniz.
select * from  tbl_musteri   where Madres MONTH order by asc  
--9. 2008-2010 y�llar�nda 5 ve 6.aylar aras�nda yap�lan sat��lar� bulmak i�in gerekli sorguyu yaz�n�z.
select *from  tbl_satis  where  year(Sat_tarih)= between '2008' and '2010'   MONTH(Sat_tarih) between '5' and '6'  
--10. 2008-2010 y�llar�nda 5 ve 6.aylar aras�nda yap�lan sat��lar�n toplam tutar�n� bulmak i�in gerekli sorguyu yaz�n�z.
select *from  tbl_satis  where  year(Sat_tarih)= between '2008' and '2010'   MONTH(Sat_tarih) between '5' and '6' Sfiyat<> 

--11. 2008-2010 y�llar�nda 1 ve 8.aylar aras�nda yap�lan toplam sat�� tutar�, ortalama sati� tutarlar�n� bulmak i�in gerekli sorguyu yaz�n�z.
select *from  tbl_satis  where  year(Sat_tarih)= between '2008' and '2010'   MONTH(Sat_tarih) between '1' and '8' Sfiyat<>    

--12. Fiyat� en y�ksek olan arac�n marka ve model bilgisini bulmak  i�in gerekli sorguyu yaz�n�z.
select top 1 * from tbl_arac   order by marka,model desc


--13. 2008-2009 y�llar�nda 3 ve 4.aylar aras�nda yap�lan sat��lar� bulmak i�in gerekli sorguyu yaz�n�z.
select *from  tbl_satis  where  year(Sat_tarih)= between '2008' and '2009'   MONTH(Sat_tarih) between '3' and '4'


--14. 2010 y�l�nda yap�lan al�m say�s�n� bulmak i�in gerekli sorguyu yaz�n�z.
select top 1 Alim_tarih from tbl_alim order by  
--15. 01.01.2010 ve 31.12.2010 aras�nda yap�lan sat��lar� listelemek i�in gerekli sorguyu yaz�n�z.
select * from tbl_satis where Sat_tarih between '01.01.2010' and '31.12.2010'
--16. aLIM S�RES� 6aydan fazla olan al�mlar� listelemek i�in gerekli sorguyu yaz�n�z.
select top 1 alim_tarih from tbl_alim MONTH(alim_tarih)  '6' 

--17. Sat��numaras� girilen sat���n hangi g�n oldu�unu bulan ve g�n ismini yazd�ran sorguyu yaz�n�z.
--18. Tokatta ya�ayan m��terilerin say�s�n� bulunuz.
select top 1 * from tbl_musteri  where Madres  like %Tokat% desc

--19. 3 ya��ndan b�y�k ara�lar�n ortalama fiyat�n� bulunuz.

--20. Ortalama al�m fiyat� 10000den y�ksek olan ara�lar� bulmak i�in gerekli sorguyu yaz�n�z.


