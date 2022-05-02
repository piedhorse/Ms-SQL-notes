create database db_kutuphane
use db_kutuphane

create table tbl_kategori
(
kategorino int primary key,
kategori_adi nvarchar(30)
)

create table tbl_kitaplar
(
ISBN char(13) primary key,
baslık nvarchar(50),
sayfasayisi smallint
)

create table tbl_adresler
(
adresno int primary key identity,
ulke nvarchar(30) default 'türkiye', 
sehir nvarchar(30),
mahalle nvarchar(50),
cadde nvarchar (50),
binano char (4),
postakodu char (5)
)

create table tbl_kutuphaneler
(
kutuphanekodu smallint primary key,
kutuphane_adi nvarchar (50),
aciklama nvarchar (max),
adres int foreign key references  tbl_adresler (adresno)
)

create table tbl_yazarlar
(
yazarno int primary key,
yazar_adi nvarchar (50),
yazar_soyadi nvarchar (50)
)

create table tbl_yazarkitap
(
ISBN char (13) foreign key references tbl_kitaplar (ISBN),
yazar int foreign key references tbl_yazarlar (yazarno)
)

create table tbl_uyeler
(
uyeno int primary key identity (1,1),
uye_adi nvarchar (50),
uye_soyadi nvarchar (50),
eposta varchar (max),
telefon char (10)unique,
adres int foreign key references tbl_adresler  (adresno)
)

create table tbl_kitapkategori
(
ISBN char(13) foreign key references tbl_kitaplar(ISBN),
kategori int foreign key references tbl_kategori(kategorino)
)
create table tbl_kutuphanekitap
(
ISBN char(13) foreign key references tbl_kitaplar (ISBN),
kutuphane smallint foreign key references tbl_kutuphaneler (kutuphanekodu)
)

 create table tbl_emanet
 (
 emanetno int primary key identity (1,1),
 ISBN char(13) foreign key references tbl_kitaplar (ISBN),
 kutuphane smallint foreign key references tbl_kutuphaneler(kutuphanekodu),
  uye int foreign key references tbl_uyeler(uyeno),
  aldigi_tarih date,
  teslim_tarihi date
  )








