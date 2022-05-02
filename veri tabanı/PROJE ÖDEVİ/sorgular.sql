/*m��teri tablosu ��kart�r*/
select * from  musteritbl

/*m��terilerin ad�n� alfabede azalan yazar*/
select * from musteritbl order by ad� asc
/*m��terilerin ad�n� soyad�n� birle�tirip azalan alfabede yazar*/
select concat(ad�,soyad�) as [Ad Soyad] from musteritbl order by [Ad Soyad] asc
/*kay�t tarihi 2015 y�l�nda olan �oforleri listeler*/
select * from sofortbl 
where [kay�t tarihi] between '2015-01-01' and '2015-12-31'

/*puan� en fazla olan �ofor*/
select top 1 * from sofortbl order by puan� desc
/*ortalama m��teri bakiyesi listeler*/
select * from musteritbl where musteribakiyesi >(select avg(musteribakiyesi) from musteritbl)
/*En fazla puan� olan m��terinin ad�n� ve puan say�s�*/
select ad�,musteripuani from musteritbl
where musteripuani= (select min(musteripuani) from musteritbl)

