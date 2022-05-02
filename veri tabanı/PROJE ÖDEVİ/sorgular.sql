/*müþteri tablosu çýkartýr*/
select * from  musteritbl

/*müþterilerin adýný alfabede azalan yazar*/
select * from musteritbl order by adý asc
/*müþterilerin adýný soyadýný birleþtirip azalan alfabede yazar*/
select concat(adý,soyadý) as [Ad Soyad] from musteritbl order by [Ad Soyad] asc
/*kayýt tarihi 2015 yýlýnda olan þoforleri listeler*/
select * from sofortbl 
where [kayýt tarihi] between '2015-01-01' and '2015-12-31'

/*puaný en fazla olan þofor*/
select top 1 * from sofortbl order by puaný desc
/*ortalama müþteri bakiyesi listeler*/
select * from musteritbl where musteribakiyesi >(select avg(musteribakiyesi) from musteritbl)
/*En fazla puaný olan müþterinin adýný ve puan sayýsý*/
select adý,musteripuani from musteritbl
where musteripuani= (select min(musteripuani) from musteritbl)

