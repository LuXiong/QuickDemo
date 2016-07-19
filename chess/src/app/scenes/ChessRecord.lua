local ChessRecord = class("ChessRecord")

local index = 0
local table_record = {}

function ChessRecord:pushRecord(start,fromX,fromY,target,toX,toY)
	record = {start = start,fromX = fromX,fromY = fromY,target = target,toX = toX,toY = toY}
	index = index+1
	table_record[index] = record
end

function ChessRecord:popRecord()
	table_record[index] = nil
	index = index-1
end

function ChessRecord:top()
	return table_record[index]
end

function ChessRecord:popAll()
	index = 0
	table_record = {}
end

function ChessRecord:ctor()
	
end


return ChessRecord