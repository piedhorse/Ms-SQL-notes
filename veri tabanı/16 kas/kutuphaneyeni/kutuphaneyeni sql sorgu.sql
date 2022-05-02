

select top(5) ogrenci.ogrno, ogrenci.ad,ogrenci.soyad,ogrenci.sinif,puan 
from ogrenci order by puan desc, sinif asc

select * from ogrenci where sinif='10E' and cinsiyet='K'
select count(*) as [10E sýnýfýnýn kýz öðrenci sayýsý]  from ogrenci where sinif='10E' 
and cinsiyet='K'

select count(*) as [kütüphaneye üye olan erkek sayýsý] from ogrenci where cinsiyet='E'
select count(*) as [kütüphaneye üye olan kýz sayýsý] from ogrenci where cinsiyet='K'

select count(*) as [kütüphaneye üye olan 10.sýnýftaki kýz sayýsý] 
from ogrenci where cinsiyet='K' and sinif like '%10%'


select * from ogrenci where (year(dtarih) between 1980 and 1999) and cinsiyet='E' 
order by dtarih asc

select count(distinct(ad)) from ogrenci

select distinct(kitap.ad) from kitap

select kitap.ad from kitap where turno=(select turno from tur where tur.ad='Roman')

select kitap.ad, kitap.sayfasayisi from kitap 
where kitap.yazarno=(select yazar.yazarno from yazar where yazar.ad='Namýk' 
and yazar.soyad='Kemal')

select avg(puan) from ogrenci  where cinsiyet='E'
select avg(puan) from ogrenci  where cinsiyet='K' and sinif like '%12%'


