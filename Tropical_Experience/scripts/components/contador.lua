local Contador = Class(function(self, inst)
    self.inst = inst
    self.count = 0
    self.next_interior_ID = 0
end)

function Contador:GetNewID()
	self.next_interior_ID = self.next_interior_ID + 1
	return self.next_interior_ID
end

function Contador:ResetID()
	self.next_interior_ID = 0
end

function Contador:Increment(valor)
    self.count = self.count + valor
end
function Contador:OnSave()
    return
    {
        count = self.count,
--        next_interior_ID = self.next_interior_ID
    }
end

function Contador:OnLoad(data)
    if data then
        self.count = data.count or self.count
--        self.next_interior_ID = data.next_interior_ID or self.next_interior_ID
    end
end

local EAST  = { x =  1, y =  0 }
local WEST  = { x = -1, y =  0 }
local NORTH = { x =  0, y =  1 }
local SOUTH = { x =  0, y = -1 }

local dir =
{
    EAST,
    WEST,
    NORTH,
    SOUTH,
}

local dir_opposite =
{
    WEST,
    EAST,
    SOUTH,
    NORTH,
}


function Contador:GetDir()
	return dir
end

function Contador:GetNorth()
	return NORTH
end
function Contador:GetSouth()
	return SOUTH
end
function Contador:GetWest()
	return WEST
end
function Contador:GetEast()
	return EAST
end

function Contador:GetDirOpposite()
	return dir_opposite
end

function Contador:GetDirOpposite()
	return dir_opposite
end

function Contador:GetX()
local x = 0
local y = 0
local z = 0

if self.count > 0 and self.count < 11 then
x = 1500 + self.count * 50
y = 0
z = 1500 + 50
end

if self.count > 10 and self.count < 21  then
x = 1500 + self.count * 50 - 500
y = 0
z = 1500 + 100
end

if self.count > 20 and self.count < 31  then
x = 1500 + self.count * 50 - 1000
y = 0
z = 1500 + 150
end

if self.count > 30 and self.count < 41  then
x = 1500 + self.count * 50 - 1500
y = 0
z = 1500 + 200
end

if self.count > 40 and self.count < 51  then
x = 1500 + self.count * 50 - 2000
y = 0
z = 1500 + 250
end

if self.count > 50 and self.count < 61  then
x = 1500 + self.count * 50 - 2500
y = 0
z = 1500 + 300
end

if self.count > 60 and self.count < 71  then
x = 1500 + self.count * 50 - 3000
y = 0
z = 1500 + 350
end

if self.count > 70 and self.count < 81  then
x = 1500 + self.count * 50 - 3500
y = 0
z = 1500 + 400
end

if self.count > 80 and self.count < 91  then
x = 1500 + self.count * 50 - 4000
y = 0
z = 1500 + 450
end

if self.count > 90 and self.count < 101  then
x = 1500 + self.count * 50 - 4500
y = 0
z = 1500 + 500
end

if self.count > 100 and self.count < 111 then
x = 1500 + self.count * 50 - 5000
y = 0
z = -1500 - 50
end

if self.count > 110 and self.count < 121  then
x = 1500 + self.count * 50 - 5500
y = 0
z = -1500 - 100
end

if self.count > 120 and self.count < 131  then
x = 1500 + self.count * 50 - 6000
y = 0
z = -1500 - 150
end

if self.count > 130 and self.count < 141  then
x = 1500 + self.count * 50 - 6500
y = 0
z = -1500 - 200
end

if self.count > 140 and self.count < 151  then
x = 1500 + self.count * 50 - 7000
y = 0
z = -1500 - 250
end

if self.count > 150 and self.count < 161  then
x = 1500 + self.count * 50 - 7500
y = 0
z = -1500 - 300
end

if self.count > 160 and self.count < 171  then
x = 1500 + self.count * 50 - 8000
y = 0
z = -1500 - 350
end

if self.count > 170 and self.count < 181  then
x = 1500 + self.count * 50 - 8500
y = 0
z = -1500 - 400
end

if self.count > 180 and self.count < 191  then
x = 1500 + self.count * 50 - 9000
y = 0
z = -1500 - 450
end

if self.count > 190 and self.count < 201  then
x = 1500 + self.count * 50 - 9500
y = 0
z = -1500 - 500
end	







if self.count > 200 and self.count < 211 then
x = 1500 + self.count * 50 - 10000
y = 0
z = 0 + 50
end

if self.count > 210 and self.count < 221  then
x = 1500 + self.count * 50 - 10500
y = 0
z = 0 + 100
end

if self.count > 220 and self.count < 231  then
x = 1500 + self.count * 50 - 11000
y = 0
z = 0 + 150
end

if self.count > 230 and self.count < 241  then
x = 1500 + self.count * 50 - 11500
y = 0
z = 0 + 200
end

if self.count > 240 and self.count < 251  then
x = 1500 + self.count * 50 - 12000
y = 0
z = 0 + 250
end

if self.count > 250 and self.count < 261  then
x = 1500 + self.count * 50 - 12500
y = 0
z = 0 + 300
end

if self.count > 260 and self.count < 271  then
x = 1500 + self.count * 50 - 13000
y = 0
z = 0 + 350
end

if self.count > 270 and self.count < 281  then
x = 1500 + self.count * 50 - 13500
y = 0
z = 0 + 400
end

if self.count > 280 and self.count < 291  then
x = 1500 + self.count * 50 - 14000
y = 0
z = 0 + 450
end

if self.count > 290 and self.count < 301  then
x = 1500 + self.count * 50 - 14500
y = 0
z = 0 + 500
end

if self.count > 300 and self.count < 311 then
x = 1500 + self.count * 50 - 15000
y = 0
z = 0 - 50
end

if self.count > 310 and self.count < 321  then
x = 1500 + self.count * 50 - 15500
y = 0
z = 0 - 100
end

if self.count > 320 and self.count < 331  then
x = 1500 + self.count * 50 - 16000
y = 0
z = 0 - 150
end

if self.count > 330 and self.count < 341  then
x = 1500 + self.count * 50 - 16500
y = 0
z = 0 - 200
end

if self.count > 340 and self.count < 351  then
x = 1500 + self.count * 50 - 17000
y = 0
z = 0 - 250
end

if self.count > 350 and self.count < 361  then
x = 1500 + self.count * 50 - 17500
y = 0
z = 0 - 300
end

if self.count > 360 and self.count < 371  then
x = 1500 + self.count * 50 - 18000
y = 0
z = 0 - 350
end

if self.count > 370 and self.count < 381  then
x = 1500 + self.count * 50 - 18500
y = 0
z = 0 - 400
end

if self.count > 380 and self.count < 391  then
x = 1500 + self.count * 50 - 19000
y = 0
z = 0 - 450
end

if self.count > 390 and self.count < 201  then
x = 1500 + self.count * 50 - 19500
y = 0
z = 0 - 500
end	


return x
end

function Contador:GetZ()
local x = 0
local y = 0
local z = 0

if self.count > 0 and self.count < 11 then
x = 1500 + self.count * 50
y = 0
z = 1500 + 50
end

if self.count > 10 and self.count < 21  then
x = 1500 + self.count * 50 - 500
y = 0
z = 1500 + 100
end

if self.count > 20 and self.count < 31  then
x = 1500 + self.count * 50 - 1000
y = 0
z = 1500 + 150
end

if self.count > 30 and self.count < 41  then
x = 1500 + self.count * 50 - 1500
y = 0
z = 1500 + 200
end

if self.count > 40 and self.count < 51  then
x = 1500 + self.count * 50 - 2000
y = 0
z = 1500 + 250
end

if self.count > 50 and self.count < 61  then
x = 1500 + self.count * 50 - 2500
y = 0
z = 1500 + 300
end

if self.count > 60 and self.count < 71  then
x = 1500 + self.count * 50 - 3000
y = 0
z = 1500 + 350
end

if self.count > 70 and self.count < 81  then
x = 1500 + self.count * 50 - 3500
y = 0
z = 1500 + 400
end

if self.count > 80 and self.count < 91  then
x = 1500 + self.count * 50 - 4000
y = 0
z = 1500 + 450
end

if self.count > 90 and self.count < 101  then
x = 1500 + self.count * 50 - 4500
y = 0
z = 1500 + 500
end	

if self.count > 100 and self.count < 111 then
x = 1500 + self.count * 50 - 5000
y = 0
z = -1500 - 50
end

if self.count > 110 and self.count < 121  then
x = 1500 + self.count * 50 - 5500
y = 0
z = -1500 - 100
end

if self.count > 120 and self.count < 131  then
x = 1500 + self.count * 50 - 6000
y = 0
z = -1500 - 150
end

if self.count > 130 and self.count < 141  then
x = 1500 + self.count * 50 - 6500
y = 0
z = -1500 - 200
end

if self.count > 140 and self.count < 151  then
x = 1500 + self.count * 50 - 7000
y = 0
z = -1500 - 250
end

if self.count > 150 and self.count < 161  then
x = 1500 + self.count * 50 - 7500
y = 0
z = -1500 - 300
end

if self.count > 160 and self.count < 171  then
x = 1500 + self.count * 50 - 8000
y = 0
z = -1500 - 350
end

if self.count > 170 and self.count < 181  then
x = 1500 + self.count * 50 - 8500
y = 0
z = -1500 - 400
end

if self.count > 180 and self.count < 191  then
x = 1500 + self.count * 50 - 9000
y = 0
z = -1500 - 450
end

if self.count > 190 and self.count < 201  then
x = 1500 + self.count * 50 - 9500
y = 0
z = -1500 - 500
end	









if self.count > 200 and self.count < 211 then
x = 1500 + self.count * 50 - 10000
y = 0
z = 0 + 50
end

if self.count > 210 and self.count < 221  then
x = 1500 + self.count * 50 - 10500
y = 0
z = 0 + 100
end

if self.count > 220 and self.count < 231  then
x = 1500 + self.count * 50 - 11000
y = 0
z = 0 + 150
end

if self.count > 230 and self.count < 241  then
x = 1500 + self.count * 50 - 11500
y = 0
z = 0 + 200
end

if self.count > 240 and self.count < 251  then
x = 1500 + self.count * 50 - 12000
y = 0
z = 0 + 250
end

if self.count > 250 and self.count < 261  then
x = 1500 + self.count * 50 - 12500
y = 0
z = 0 + 300
end

if self.count > 260 and self.count < 271  then
x = 1500 + self.count * 50 - 13000
y = 0
z = 0 + 350
end

if self.count > 270 and self.count < 281  then
x = 1500 + self.count * 50 - 13500
y = 0
z = 0 + 400
end

if self.count > 280 and self.count < 291  then
x = 1500 + self.count * 50 - 14000
y = 0
z = 0 + 450
end

if self.count > 290 and self.count < 301  then
x = 1500 + self.count * 50 - 14500
y = 0
z = 0 + 500
end

if self.count > 300 and self.count < 311 then
x = 1500 + self.count * 50 - 15000
y = 0
z = 0 - 50
end

if self.count > 310 and self.count < 321  then
x = 1500 + self.count * 50 - 15500
y = 0
z = 0 - 100
end

if self.count > 320 and self.count < 331  then
x = 1500 + self.count * 50 - 16000
y = 0
z = 0 - 150
end

if self.count > 330 and self.count < 341  then
x = 1500 + self.count * 50 - 16500
y = 0
z = 0 - 200
end

if self.count > 340 and self.count < 351  then
x = 1500 + self.count * 50 - 17000
y = 0
z = 0 - 250
end

if self.count > 350 and self.count < 361  then
x = 1500 + self.count * 50 - 17500
y = 0
z = 0 - 300
end

if self.count > 360 and self.count < 371  then
x = 1500 + self.count * 50 - 18000
y = 0
z = 0 - 350
end

if self.count > 370 and self.count < 381  then
x = 1500 + self.count * 50 - 18500
y = 0
z = 0 - 400
end

if self.count > 380 and self.count < 391  then
x = 1500 + self.count * 50 - 19000
y = 0
z = 0 - 450
end

if self.count > 390 and self.count < 201  then
x = 1500 + self.count * 50 - 19500
y = 0
z = 0 - 500
end	

return z
end




return Contador

