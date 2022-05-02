

create trigger tr_stokguncelle
on satislar
for insert
as
declare @satisadeti int, @urunkodu int
select @urunkodu=urunkodu, @satisadeti=satis_adeti from inserted
update urunler set stokadeti=stokadeti-@satisadeti 
where urunkodu=@urunkodu
go

/*trigger'� devred��� b�rakmak i�in*/
alter table satislar disable trigger ALL


create trigger tr_satisiptal
on satislar
for delete
as
declare @iadesatisadeti int, @urunkodu int
select @urunkodu=urunkodu, @iadesatisadeti=satis_adeti from deleted
update urunler set stokadeti=stokadeti+@iadesatisadeti
go

create trigger tr_satisguncelle
on satislar
for update
as
declare @eskisatisadeti int, @yenisatisadeti int, @urunkodu int, 
@fark int

select @urunkodu=urunkodu, @eskisatisadeti=satis_adeti from deleted
select @yenisatisadeti=satis_adeti from inserted
set @fark=@eskisatisadeti-@yenisatisadeti
update urunler set stokadeti=stokadeti+@fark where urunkodu=@urunkodu
go

/*urun satisi yap�l�rken stoktaki adetten fazla sat�lmas�n� engelleyen
 trigger yaz�n�z.*/

alter trigger tr_satisyap
on satislar
for insert
as
declare @satisadeti int, @urunkodu int,@stok int, @satisid int
select @urunkodu=urunkodu,@satisadeti=satis_adeti, @satisid=satis_id 
from inserted
set @stok=(select stokadeti from urunler where urunkodu=@urunkodu)
if (@stok<@satisadeti)
begin
delete from satislar where satis_id=@satisid
print 'Yeterli stok bulunamad�, l�tfen'+convert(varchar,@stok)+'dan k���k 
adet giriniz!'
end
else
update urunler set stokadeti=stokadeti-@satisadeti 
where urunkodu=@urunkodu
go

insert into satislar values (1, 250)





