use Northwind

if exists(select * from sys.objects where object_id = object_id('dbo.NewObjectId'))
    drop function [dbo].[NewObjectId]
go

create function [dbo].[NewObjectId](@counter binary(3))
    returns binary(12)
    as begin
    return cast(datediff(ss, '1/1/1970', getutcdate()) as binary(4)) +
            cast(hashbytes('MD5', host_name()) as binary(3)) +
            cast(@@SPID as binary(2)) +
            @counter
end
go

alter table [dbo].[Categories]
    add ObjectId binary(12) not null
    default dbo.NewObjectId(crypt_gen_random(3))
go

alter table [dbo].[Products]
    add ObjectId binary(12) not null
    default dbo.NewObjectId(crypt_gen_random(3))
go

alter table [dbo].[Customers]
    add ObjectId binary(12) not null
    default dbo.NewObjectId(crypt_gen_random(3))
go

alter table [dbo].[Orders]
    add ObjectId binary(12) not null
    default dbo.NewObjectId(crypt_gen_random(3))
go
