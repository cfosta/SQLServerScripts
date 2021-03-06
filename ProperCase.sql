

-- Convert a phrase so that the first letter of each work is capitalized and the
-- rest are lower case.
-- ex. select [dbo].ProperCase('UPPER CASE') = 'Upper Case'

if object_id('ProperCase') > 0
	drop function [dbo].ProperCase
go

create function dbo.ProperCase (
	@InputString nvarchar(2000)
)
returns nvarchar(2000)

as

begin
	
	declare @InputStringLength int
	declare @Counter int
	declare @CharacterCode int
	declare @Character nvarchar(1)
	declare @ReturnString nvarchar(2000)
	declare @UseUpper bit

	set @InputString = ltrim(@InputString)
	set @InputStringLength = len(@InputString)
	set @Counter = 0
	set @ReturnString = ''
	set @UseUpper = 1

	while (@Counter <= @InputStringLength)
		begin
			set @Counter = @Counter + 1
			set @Character = substring(@InputString, @Counter, 1)
			set @CharacterCode = ascii(@Character)

			if (@CharacterCode = 32)
				set @UseUpper = 1

			if (@CharacterCode between 65 and 90) 
			  begin
				if @UseUpper = 0
					set @Character = lower(@Character)
	
				set @UseUpper = 0
			  end
			
			set @ReturnString = @ReturnString + @Character
		end

	return @ReturnString

end

go
