
create database db_galeri   /*veritabanýný oluþturduk  */
use db_galeri

/*tablolarýmýzý oluþturduk ve  kategorilerimize parametre ekledik  ardýndan ise parantez içinde sýnýrlarýný belirledik */

--------------------------------------------------------------------------
create table dbo_musteri
(
Mno int primary key identity(1,1), /*primary key (birincil anahtar) tablonun deðiþmez ifadesinin etiketidir*/
Madi nvarchar(20),
Msoyadi nvarchar(20),
Madres nvarchar(50),
Mtel char(11)
)
---------------------------------------------------------------------------

create table dbo_arac
(
Aracno int primary key identity(1,1), /*ÝDENTÝTY (KÝMLÝK) ise kategorilerin kendisine özel numaralandýrma yapmasýný saðlar*/
Model date,
Marka varchar(50),
Plaka char(8) unique,
Fiyat money
)
----------------------------------------------------------------------------
create table dbo_satis
(
Satno int primary key identity(1,1),
Aracno int foreign key references tbl_arac(Aracno),               /*   foreign key refences (yabancý anahtar referansý )  ile baþka tablonun kategorisini bu tablomuza baðladýk   */
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





/*  values etiketi tablomuzdaki kategorilere deðer ekler  insert into etiketi ise bunlarý kategorilerin içine sokar      */


INSERT into tbl_musteri  values ('Turgut','Özseven','Turhal/Tokat','03562222222')
INSERT into tbl_musteri  values ('Mustafa','Çaðlayan','Meram/Konya','05112111111')
INSERT into tbl_musteri  values ('Ahmet','Kara','Zile/Tokat','03563333333')
INSERT into tbl_musteri  values ('Murat','Beyaz','Turhal/Tokat','03565555555')
INSERT into tbl_musteri  values ('Elif','Kurt','Beþiktaþ/Ýstanbul','05781471414')
INSERT into tbl_musteri  values ('Ayþe','Uçar','Taþova/Amasya','05386666666')
INSERT into tbl_musteri  values ('Bülent','Ayar','Turhal/Tokat','03568888888')



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
select Aracno,Sat_tarih,Sfiyat as [Satiþ Fiyatý] from tbl_satis 

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
--1. Araçlarýn fiyatlarýný %20 arttýrarak listelemek için gerekli sorguyu yazýnýz.
select aracno, model, Marka,fiyat*1.2 as [zamlý fiyat] from tbl_arac

--2. Yaþý 15ten küçük araçlarýn fiyatlarýný %15 arttýrmak için gerekli sorguyu yazýnýz.
update tbl_arac set Fiyat=fiyat*1.15 where datediff(yy,model,getdate())<15

--3. Müþterilerin ad ve soyadlarýný birleþtirerek tek sutünda artan sýrada listelemek için gerekli sorguyu yazýnýz.
select concat(madi,msoyadi) as [Ad Soyad] from tbl_musteri order by [Ad Soyad] asc

--4. 1,4,7 nolu müþterilere 1,2 ve 5 nolu araçlardan yapýlan satiþlarýn tarih ve fiyat bilgisini tek sütunda tarihe göre azalan þekilde listeleyiniz.
  select * from tbl_satis aracno in (1,4,5) where Sfiyat and Sat_tarih  mno in (1,4,7)

--5. Müþterilerin ad ve soyad bilgisini tek sütunda birleþtirerek A.Soyad þeklinde isimlendirerek listeleyiniz.
select concat(madi,msoyadi) as [A. Soyad] from tbl_musteri
--6. Yapýlan alýmlarý sadece ay bilgisine göre artan, alýþ fiyatýna göre azalan sýrada listelemek için gerekli sorguyu yazýnýz.
select* from tbl_alim where Alim_tarih MONTH order by desc
--7. Soyadý 5 karakterden fazla olan müþterilerin ad ve soyad bilgisini adýnýn ilk harfini ve soyadýnýn 5 harfini birleþtirerek listeleyiniz.
select Msoyadi,Madi  from tbl_musteri    where Msoyadi LIKE '______'   
--8. Müþterilerin sadece il bilgilerini artan þekilde listeleyiniz.
select * from  tbl_musteri   where Madres MONTH order by asc  
--9. 2008-2010 yýllarýnda 5 ve 6.aylar arasýnda yapýlan satýþlarý bulmak için gerekli sorguyu yazýnýz.
select *from  tbl_satis  where  year(Sat_tarih)= between '2008' and '2010'   MONTH(Sat_tarih) between '5' and '6'  
--10. 2008-2010 yýllarýnda 5 ve 6.aylar arasýnda yapýlan satýþlarýn toplam tutarýný bulmak için gerekli sorguyu yazýnýz.
select *from  tbl_satis  where  year(Sat_tarih)= between '2008' and '2010'   MONTH(Sat_tarih) between '5' and '6' Sfiyat<> 

--11. 2008-2010 yýllarýnda 1 ve 8.aylar arasýnda yapýlan toplam satýþ tutarý, ortalama satiþ tutarlarýný bulmak için gerekli sorguyu yazýnýz.
select *from  tbl_satis  where  year(Sat_tarih)= between '2008' and '2010'   MONTH(Sat_tarih) between '1' and '8' Sfiyat<>    

--12. Fiyatý en yüksek olan aracýn marka ve model bilgisini bulmak  için gerekli sorguyu yazýnýz.
select top 1 * from tbl_arac   order by marka,model desc


--13. 2008-2009 yýllarýnda 3 ve 4.aylar arasýnda yapýlan satýþlarý bulmak için gerekli sorguyu yazýnýz.
select *from  tbl_satis  where  year(Sat_tarih)= between '2008' and '2009'   MONTH(Sat_tarih) between '3' and '4'


--14. 2010 yýlýnda yapýlan alým sayýsýný bulmak için gerekli sorguyu yazýnýz.
select top 1 Alim_tarih from tbl_alim order by  
--15. 01.01.2010 ve 31.12.2010 arasýnda yapýlan satýþlarý listelemek için gerekli sorguyu yazýnýz.
select * from tbl_satis where Sat_tarih between '01.01.2010' and '31.12.2010'
--16. aLIM SÜRESÝ 6aydan fazla olan alýmlarý listelemek için gerekli sorguyu yazýnýz.
select top 1 alim_tarih from tbl_alim MONTH(alim_tarih)  '6' 

--17. Satýþnumarasý girilen satýþýn hangi gün olduðunu bulan ve gün ismini yazdýran sorguyu yazýnýz.
--18. Tokatta yaþayan müþterilerin sayýsýný bulunuz.
select top 1 * from tbl_musteri  where Madres  like %Tokat% desc

--19. 3 yaþýndan büyük araçlarýn ortalama fiyatýný bulunuz.

--20. Ortalama alým fiyatý 10000den yüksek olan araçlarý bulmak için gerekli sorguyu yazýnýz.


