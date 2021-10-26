----------------------------------------------------------------------------------------------------
--2017.03.24
--[Other] 简单的本地数据提供函数
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
--[FUNC] 用于ServerStore的相关变量
----------------------------------------------------------------------------------------------------
local ModStoreData = GLOBAL.require "ModStoreData"
local CoinsPrefab, GoodsPrefab = ModStoreData.CoinsPrefab, ModStoreData.GoodsPrefab

local GoodsDataClient = {}
local StoreStructures = {}-- 所有商店

----------------------------------------------------------------------------------------------------
--[FUNC] 用于ServerStore的相关函数
----------------------------------------------------------------------------------------------------
AddPrefabPostInitAny(function(inst)
    if inst and inst:HasTag("serverstore") then table.insert(StoreStructures, inst) end
end)

local function PrepareGoodsData()
    --NetVar限定Array成员不超过31个
local goods, count, spoil, ratio, stock, money, price, disct = {}, {}, {}, {}, {}, {}, {}, {}
local goods1, count1, spoil1, ratio1, stock1, money1, price1, disct1 = {}, {}, {}, {}, {}, {}, {}, {}
local goods2, count2, spoil2, ratio2, stock2, money2, price2, disct2 = {}, {}, {}, {}, {}, {}, {}, {}
local goods3, count3, spoil3, ratio3, stock3, money3, price3, disct3 = {}, {}, {}, {}, {}, {}, {}, {}
local goods4, count4, spoil4, ratio4, stock4, money4, price4, disct4 = {}, {}, {}, {}, {}, {}, {}, {}
local goods5, count5, spoil5, ratio5, stock5, money5, price5, disct5 = {}, {}, {}, {}, {}, {}, {}, {}
local goods6, count6, spoil6, ratio6, stock6, money6, price6, disct6 = {}, {}, {}, {}, {}, {}, {}, {}
local goods7, count7, spoil7, ratio7, stock7, money7, price7, disct7 = {}, {}, {}, {}, {}, {}, {}, {}
local goods8, count8, spoil8, ratio8, stock8, money8, price8, disct8 = {}, {}, {}, {}, {}, {}, {}, {}
local goods9, count9, spoil9, ratio9, stock9, money9, price9, disct9 = {}, {}, {}, {}, {}, {}, {}, {}
local goods10, count10, spoil10, ratio10, stock10, money10, price10, disct10 = {}, {}, {}, {}, {}, {}, {}, {}
local goods11, count11, spoil11, ratio11, stock11, money11, price11, disct11 = {}, {}, {}, {}, {}, {}, {}, {}
local goods12, count12, spoil12, ratio12, stock12, money12, price12, disct12 = {}, {}, {}, {}, {}, {}, {}, {}
local goods13, count13, spoil13, ratio13, stock13, money13, price13, disct13 = {}, {}, {}, {}, {}, {}, {}, {}
local goods14, count14, spoil14, ratio14, stock14, money14, price14, disct14 = {}, {}, {}, {}, {}, {}, {}, {}
local goods15, count15, spoil15, ratio15, stock15, money15, price15, disct15 = {}, {}, {}, {}, {}, {}, {}, {}
local goods16, count16, spoil16, ratio16, stock16, money16, price16, disct16 = {}, {}, {}, {}, {}, {}, {}, {}

--------------------------lavaarena_boarlord----------------------------------------------------	
table.insert(goods1, 1)
table.insert(count1, 1)
table.insert(spoil1, 255)
table.insert(ratio1, 255)
table.insert(stock1, 255)
table.insert(price1, 0)
table.insert(disct1, 100)
table.insert(money1, 1)
		
table.insert(goods1, 2)
table.insert(count1, 1)
table.insert(spoil1, 255)
table.insert(ratio1, 255)
table.insert(stock1, 255)
table.insert(price1, 4)
table.insert(disct1, 100)
table.insert(money1, 1)

table.insert(goods1, 3)
table.insert(count1, 1)
table.insert(spoil1, 255)
table.insert(ratio1, 255)
table.insert(stock1, 255)
table.insert(price1, 6)
table.insert(disct1, 100)
table.insert(money1, 1)		
		
table.insert(goods1, 4)
table.insert(count1, 1)
table.insert(spoil1, 255)
table.insert(ratio1, 255)
table.insert(stock1, 255)
table.insert(price1, 10)
table.insert(disct1, 100)
table.insert(money1, 1)		
		
table.insert(goods1, 5)
table.insert(count1, 1)
table.insert(spoil1, 255)
table.insert(ratio1, 255)
table.insert(stock1, 255)
table.insert(price1, 8)
table.insert(disct1, 100)
table.insert(money1, 1)		
		
table.insert(goods1, 6)
table.insert(count1, 1)
table.insert(spoil1, 255)
table.insert(ratio1, 255)
table.insert(stock1, 255)
table.insert(price1, 12)
table.insert(disct1, 100)
table.insert(money1, 1)

-----------------------------lavaarena_spectator2---------------------------------

table.insert(goods2, 7)
table.insert(count2, 1)
table.insert(spoil2, 255)
table.insert(ratio2, 255)
table.insert(stock2, 255)
table.insert(price2, math.random(3,8))
table.insert(disct2, 100)
table.insert(money2, 1)
	
table.insert(goods2, 8)
table.insert(count2, 1)
table.insert(spoil2, 255)
table.insert(ratio2, 255)
table.insert(stock2, 255)
table.insert(price2, math.random(3,8))
table.insert(disct2, 100)
table.insert(money2, 1)

table.insert(goods2, 9)
table.insert(count2, 1)
table.insert(spoil2, 255)
table.insert(ratio2, 255)
table.insert(stock2, 255)
table.insert(price2, math.random(4,6))
table.insert(disct2, 100)
table.insert(money2, 1)		
		
table.insert(goods2, 10)
table.insert(count2, 1)
table.insert(spoil2, 255)
table.insert(ratio2, 255)
table.insert(stock2, 255)
table.insert(price2, math.random(10,20))
table.insert(disct2, 100)
table.insert(money2, 2)		
	
table.insert(goods2, 11)
table.insert(count2, 5)
table.insert(spoil2, 255)
table.insert(ratio2, 255)
table.insert(stock2, 255)
table.insert(price2, 1)
table.insert(disct2, 100)
table.insert(money2, 2)		
	
table.insert(goods2, 12)
table.insert(count2, 1)
table.insert(spoil2, 255)
table.insert(ratio2, 255)
table.insert(stock2, 255)
table.insert(price2, 5)
table.insert(disct2, 100)
table.insert(money2, 1)

--------------------------lavaarena_spectator4---------------------------------------

table.insert(goods3, 13)
table.insert(count3, 1)
table.insert(spoil3, 255)
table.insert(ratio3, 255)
table.insert(stock3, 255)
table.insert(price3, math.random(1,3))
table.insert(disct3, 100)
table.insert(money3, 1)
		
table.insert(goods3, 14)
table.insert(count3, 1)
table.insert(spoil3, 255)
table.insert(ratio3, 255)
table.insert(stock3, 255)
table.insert(price3, math.random(4,6))
table.insert(disct3, 100)
table.insert(money3, 1)

table.insert(goods3, 15)
table.insert(count3, 1)
table.insert(spoil3, 255)
table.insert(ratio3, 255)
table.insert(stock3, 255)
table.insert(price3, math.random(6,8))
table.insert(disct3, 100)
table.insert(money3, 1)		
		
table.insert(goods3, 16)
table.insert(count3, 1)
table.insert(spoil3, 255)
table.insert(ratio3, 255)
table.insert(stock3, 255)
table.insert(price3, math.random(4,6))
table.insert(disct3, 100)
table.insert(money3, 1)		
		
table.insert(goods3, 17)
table.insert(count3, 1)
table.insert(spoil3, 255)
table.insert(ratio3, 255)
table.insert(stock3, 255)
table.insert(price3, math.random(8,10))
table.insert(disct3, 100)
table.insert(money3, 1)		
		
table.insert(goods3, 18)
table.insert(count3, 1)
table.insert(spoil3, 255)
table.insert(ratio3, 255)
table.insert(stock3, 255)
table.insert(price3, math.random(8,8))
table.insert(disct3, 100)
table.insert(money3, 1)

--------------------------lavaarena_spectator1---------------------------------------

table.insert(goods4, 19)
table.insert(count4, 1)
table.insert(spoil4, 255)
table.insert(ratio4, 255)
table.insert(stock4, 255)
table.insert(price4, math.random(8, 12))
table.insert(disct4, 100)
table.insert(money4, 2)	
		
table.insert(goods4, 20)
table.insert(count4, 1)
table.insert(spoil4, 255)
table.insert(ratio4, 255)
table.insert(stock4, 255)
table.insert(price4, math.random(8, 12))
table.insert(disct4, 100)
table.insert(money4, 2)	

table.insert(goods4, 21)
table.insert(count4, 1)
table.insert(spoil4, 255)
table.insert(ratio4, 255)
table.insert(stock4, 255)
table.insert(price4, math.random(15, 25))
table.insert(disct4, 100)
table.insert(money4, 2)		
		
table.insert(goods4, 22)
table.insert(count4, 1)
table.insert(spoil4, 255)
table.insert(ratio4, 255)
table.insert(stock4, 255)
table.insert(price4, math.random(15, 25))
table.insert(disct4, 100)
table.insert(money4, 2)		
		
table.insert(goods4, 23)
table.insert(count4, 1)
table.insert(spoil4, 255)
table.insert(ratio4, 255)
table.insert(stock4, 255)
table.insert(price4, math.random(20, 25))
table.insert(disct4, 100)
table.insert(money4, 2)		
		
table.insert(goods4, 24)
table.insert(count4, 1)
table.insert(spoil4, 255)
table.insert(ratio4, 255)
table.insert(stock4, 255)
table.insert(price4, math.random(25, 30))
table.insert(disct4, 100)
table.insert(money4, 2)		

---------------------------

table.insert(goods5, 25)
table.insert(count5, 1)
table.insert(spoil5, 255)
table.insert(ratio5, 255)
table.insert(stock5, 255)
table.insert(price5, math.random(8, 12))
table.insert(disct5, 100)
table.insert(money5, 2)	
		
table.insert(goods5, 26)
table.insert(count5, 1)
table.insert(spoil5, 255)
table.insert(ratio5, 255)
table.insert(stock5, 255)
table.insert(price5, math.random(8, 12))
table.insert(disct5, 100)
table.insert(money5, 2)	

table.insert(goods5, 27)
table.insert(count5, 1)
table.insert(spoil5, 255)
table.insert(ratio5, 255)
table.insert(stock5, 255)
table.insert(price5, math.random(15, 25))
table.insert(disct5, 100)
table.insert(money5, 2)		
		
table.insert(goods5, 28)
table.insert(count5, 1)
table.insert(spoil5, 255)
table.insert(ratio5, 255)
table.insert(stock5, 255)
table.insert(price5, math.random(15, 25))
table.insert(disct5, 100)
table.insert(money5, 2)		
		
table.insert(goods5, 29)
table.insert(count5, 1)
table.insert(spoil5, 255)
table.insert(ratio5, 255)
table.insert(stock5, 255)
table.insert(price5,math.random(20, 25))
table.insert(disct5, 100)
table.insert(money5, 2)

table.insert(goods5, 30)
table.insert(count5, 1)
table.insert(spoil5, 255)
table.insert(ratio5, 255)
table.insert(stock5, 255)
table.insert(price5, math.random(25, 30))
table.insert(disct5, 100)
table.insert(money5, 2)	
----------------------
table.insert(goods6, 31)
table.insert(count6, 1)
table.insert(spoil6, 255)
table.insert(ratio6, 255)
table.insert(stock6, 255)
table.insert(price6, math.random(8, 12))
table.insert(disct6, 100)
table.insert(money6, 2)	
		
table.insert(goods6, 32)
table.insert(count6, 1)
table.insert(spoil6, 255)
table.insert(ratio6, 255)
table.insert(stock6, 255)
table.insert(price6, math.random(8, 12))
table.insert(disct6, 100)
table.insert(money6, 2)	

table.insert(goods6, 33)
table.insert(count6, 1)
table.insert(spoil6, 255)
table.insert(ratio6, 255)
table.insert(stock6, 255)
table.insert(price6, math.random(15, 25))
table.insert(disct6, 100)
table.insert(money6, 2)		
		
table.insert(goods6, 34)
table.insert(count6, 1)
table.insert(spoil6, 255)
table.insert(ratio6, 255)
table.insert(stock6, 255)
table.insert(price6, math.random(15, 25))
table.insert(disct6, 100)
table.insert(money6, 2)		
		
table.insert(goods6, 35)
table.insert(count6, 1)
table.insert(spoil6, 255)
table.insert(ratio6, 255)
table.insert(stock6, 255)
table.insert(price6, math.random(20, 25))
table.insert(disct6, 100)
table.insert(money6, 2)		
		
table.insert(goods6, 36)
table.insert(count6, 1)
table.insert(spoil6, 255)
table.insert(ratio6, 255)
table.insert(stock6, 255)
table.insert(price6, math.random(25, 30))
table.insert(disct6, 100)
table.insert(money6, 2)	
----------------------------
table.insert(goods7, 37)
table.insert(count7, 1)
table.insert(spoil7, 255)
table.insert(ratio7, 255)
table.insert(stock7, 255)
table.insert(price7, math.random(8, 12))
table.insert(disct7, 100)
table.insert(money7, 2)	
		
table.insert(goods7, 38)
table.insert(count7, 1)
table.insert(spoil7, 255)
table.insert(ratio7, 255)
table.insert(stock7, 255)
table.insert(price7, math.random(8, 12))
table.insert(disct7, 100)
table.insert(money7, 2)	

table.insert(goods7, 39)
table.insert(count7, 1)
table.insert(spoil7, 255)
table.insert(ratio7, 255)
table.insert(stock7, 255)
table.insert(price7, math.random(15, 25))
table.insert(disct7, 100)
table.insert(money7, 2)		
		
table.insert(goods7, 40)
table.insert(count7, 1)
table.insert(spoil7, 255)
table.insert(ratio7, 255)
table.insert(stock7, 255)
table.insert(price7, math.random(15, 25))
table.insert(disct7, 100)
table.insert(money7, 2)		
		
table.insert(goods7, 41)
table.insert(count7, 1)
table.insert(spoil7, 255)
table.insert(ratio7, 255)
table.insert(stock7, 255)
table.insert(price7, math.random(20, 25))
table.insert(disct7, 100)
table.insert(money7, 2)		
		
table.insert(goods7, 42)
table.insert(count7, 1)
table.insert(spoil7, 255)
table.insert(ratio7, 255)
table.insert(stock7, 255)
table.insert(price7, math.random(25, 30))
table.insert(disct7, 100)
table.insert(money7, 2)	
----------------------------
table.insert(goods8, 43)
table.insert(count8, 1)
table.insert(spoil8, 255)
table.insert(ratio8, 255)
table.insert(stock8, 255)
table.insert(price8, math.random(20, 30))
table.insert(disct8, 100)
table.insert(money8, 1)	
		
table.insert(goods8, 44)
table.insert(count8, 1)
table.insert(spoil8, 255)
table.insert(ratio8, 255)
table.insert(stock8, 255)
table.insert(price8, math.random(5, 10))
table.insert(disct8, 100)
table.insert(money8, 1)	

table.insert(goods8, 45)
table.insert(count8, 1)
table.insert(spoil8, 255)
table.insert(ratio8, 255)
table.insert(stock8, 255)
table.insert(price8, math.random(45, 55))
table.insert(disct8, 100)
table.insert(money8, 1)		
		
table.insert(goods8, 46)
table.insert(count8, 1)
table.insert(spoil8, 255)
table.insert(ratio8, 255)
table.insert(stock8, 255)
table.insert(price8, math.random(5, 10))
table.insert(disct8, 100)
table.insert(money8, 1)		
		
table.insert(goods8, 47)
table.insert(count8, 1)
table.insert(spoil8, 255)
table.insert(ratio8, 255)
table.insert(stock8, 255)
table.insert(price8, math.random(5, 10))
table.insert(disct8, 100)
table.insert(money8, 1)		
		
table.insert(goods8, 48)
table.insert(count8, 1)
table.insert(spoil8, 255)
table.insert(ratio8, 255)
table.insert(stock8, 255)
table.insert(price8, math.random(5, 10))
table.insert(disct8, 100)
table.insert(money8, 1)	
-----------------------------------
table.insert(goods9, 49)
table.insert(count9, 1)
table.insert(spoil9, 255)
table.insert(ratio9, 255)
table.insert(stock9, 255)
table.insert(price9, math.random(8, 12))
table.insert(disct9, 100)
table.insert(money9, 2)	
		
table.insert(goods9, 50)
table.insert(count9, 1)
table.insert(spoil9, 255)
table.insert(ratio9, 255)
table.insert(stock9, 255)
table.insert(price9, math.random(8, 12))
table.insert(disct9, 100)
table.insert(money9, 2)	

table.insert(goods9, 51)
table.insert(count9, 1)
table.insert(spoil9, 255)
table.insert(ratio9, 255)
table.insert(stock9, 255)
table.insert(price9, math.random(15, 25))
table.insert(disct9, 100)
table.insert(money9, 2)		
		
table.insert(goods9, 52)
table.insert(count9, 1)
table.insert(spoil9, 255)
table.insert(ratio9, 255)
table.insert(stock9, 255)
table.insert(price9, math.random(15, 25))
table.insert(disct9, 100)
table.insert(money9, 2)		
		
table.insert(goods9, 53)
table.insert(count9, 1)
table.insert(spoil9, 255)
table.insert(ratio9, 255)
table.insert(stock9, 255)
table.insert(price9, math.random(20, 25))
table.insert(disct9, 100)
table.insert(money9, 2)		
		
table.insert(goods9, 54)
table.insert(count9, 1)
table.insert(spoil9, 255)
table.insert(ratio9, 255)
table.insert(stock9, 255)
table.insert(price9, math.random(25, 30))
table.insert(disct9, 100)
table.insert(money9, 2)	

-----------------------------------
table.insert(goods10, 55)
table.insert(count10, 1)
table.insert(spoil10, 255)
table.insert(ratio10, 255)
table.insert(stock10, 255)
table.insert(price10, 0)
table.insert(disct10, 100)
table.insert(money10, 2)	
		
table.insert(goods10, 56)
table.insert(count10, 1)
table.insert(spoil10, 255)
table.insert(ratio10, 255)
table.insert(stock10, 255)
table.insert(price10, 0)
table.insert(disct10, 100)
table.insert(money10, 2)	

table.insert(goods10, 57)
table.insert(count10, 1)
table.insert(spoil10, 255)
table.insert(ratio10, 255)
table.insert(stock10, 255)
table.insert(price10, 0)
table.insert(disct10, 100)
table.insert(money10, 2)		
		
table.insert(goods10, 58)
table.insert(count10, 1)
table.insert(spoil10, 255)
table.insert(ratio10, 255)
table.insert(stock10, 255)
table.insert(price10, 0)
table.insert(disct10, 100)
table.insert(money10, 2)		
		
table.insert(goods10, 59)
table.insert(count10, 1)
table.insert(spoil10, 255)
table.insert(ratio10, 255)
table.insert(stock10, 255)
table.insert(price10, 0)
table.insert(disct10, 100)
table.insert(money10, 2)		
		
table.insert(goods10, 60)
table.insert(count10, 1)
table.insert(spoil10, 255)
table.insert(ratio10, 255)
table.insert(stock10, 255)
table.insert(price10, 0)
table.insert(disct10, 100)
table.insert(money10, 2)	
	
------------------mum --------------
table.insert(goods11, 61)
table.insert(count11, 1)
table.insert(spoil11, 255)
table.insert(ratio11, 255)
table.insert(stock11, 255)
table.insert(price11, 6)
table.insert(disct11, 100)
table.insert(money11, 1)	
		
table.insert(goods11, 62)
table.insert(count11, 1)
table.insert(spoil11, 255)
table.insert(ratio11, 255)
table.insert(stock11, 255)
table.insert(price11, 6)
table.insert(disct11, 100)
table.insert(money11, 1)	

table.insert(goods11, 63)
table.insert(count11, 1)
table.insert(spoil11, 255)
table.insert(ratio11, 255)
table.insert(stock11, 255)
table.insert(price11, 6)
table.insert(disct11, 100)
table.insert(money11, 1)		
		
table.insert(goods11, 64)
table.insert(count11, 1)
table.insert(spoil11, 255)
table.insert(ratio11, 255)
table.insert(stock11, 255)
table.insert(price11, 3)
table.insert(disct11, 100)
table.insert(money11, 2)		
		
table.insert(goods11, 65)
table.insert(count11, 1)
table.insert(spoil11, 255)
table.insert(ratio11, 255)
table.insert(stock11, 255)
table.insert(price11, 3)
table.insert(disct11, 100)
table.insert(money11, 2)		
		
table.insert(goods11, 66)
table.insert(count11, 1)
table.insert(spoil11, 255)
table.insert(ratio11, 255)
table.insert(stock11, 255)
table.insert(price11, 3)
table.insert(disct11, 100)
table.insert(money11, 2)
-----------------merm trade 1--------------
table.insert(goods12, 67)
table.insert(count12, 1)
table.insert(spoil12, 255)
table.insert(ratio12, 255)
table.insert(stock12, 255)
table.insert(price12, 1)
table.insert(disct12, 100)
table.insert(money12, 1)	
		
table.insert(goods12, 68)
table.insert(count12, 1)
table.insert(spoil12, 255)
table.insert(ratio12, 255)
table.insert(stock12, 255)
table.insert(price12, 1)
table.insert(disct12, 100)
table.insert(money12, 1)	

table.insert(goods12, 69)
table.insert(count12, 1)
table.insert(spoil12, 255)
table.insert(ratio12, 255)
table.insert(stock12, 255)
table.insert(price12, 1)
table.insert(disct12, 100)
table.insert(money12, 1)		
		
table.insert(goods12, 70)
table.insert(count12, 1)
table.insert(spoil12, 255)
table.insert(ratio12, 255)
table.insert(stock12, 255)
table.insert(price12, 1)
table.insert(disct12, 100)
table.insert(money12, 1)		
		
table.insert(goods12, 71)
table.insert(count12, 1)
table.insert(spoil12, 255)
table.insert(ratio12, 255)
table.insert(stock12, 255)
table.insert(price12, 1)
table.insert(disct12, 100)
table.insert(money12, 1)		
		
table.insert(goods12, 72)
table.insert(count12, 1)
table.insert(spoil12, 255)
table.insert(ratio12, 255)
table.insert(stock12, 255)
table.insert(price12, 1)
table.insert(disct12, 100)
table.insert(money12, 1)
--------------merm trade 2--------------
table.insert(goods13, 73)
table.insert(count13, 1)
table.insert(spoil13, 255)
table.insert(ratio13, 255)
table.insert(stock13, 255)
table.insert(price13, 1)
table.insert(disct13, 100)
table.insert(money13, 1)	
		
table.insert(goods13, 74)
table.insert(count13, 1)
table.insert(spoil13, 255)
table.insert(ratio13, 255)
table.insert(stock13, 255)
table.insert(price13, 3)
table.insert(disct13, 100)
table.insert(money13, 1)	

table.insert(goods13, 75)
table.insert(count13, 1)
table.insert(spoil13, 255)
table.insert(ratio13, 255)
table.insert(stock13, 255)
table.insert(price13, 4)
table.insert(disct13, 100)
table.insert(money13, 1)		
		
table.insert(goods13, 76)
table.insert(count13, 1)
table.insert(spoil13, 255)
table.insert(ratio13, 255)
table.insert(stock13, 255)
table.insert(price13, 4)
table.insert(disct13, 100)
table.insert(money13, 1)		
		
table.insert(goods13, 77)
table.insert(count13, 1)
table.insert(spoil13, 255)
table.insert(ratio13, 255)
table.insert(stock13, 255)
table.insert(price13, 4)
table.insert(disct13, 100)
table.insert(money13, 1)		
		
table.insert(goods13, 78)
table.insert(count13, 1)
table.insert(spoil13, 255)
table.insert(ratio13, 255)
table.insert(stock13, 255)
table.insert(price13, 8)
table.insert(disct13, 100)
table.insert(money13, 1)
-----------------------pig elder-------
table.insert(goods14, 79)
table.insert(count14, 1)
table.insert(spoil14, 255)
table.insert(ratio14, 255)
table.insert(stock14, 255)
table.insert(price14, 5)
table.insert(disct14, 100)
table.insert(money14, 1)	
		
table.insert(goods14, 80)
table.insert(count14, 1)
table.insert(spoil14, 255)
table.insert(ratio14, 255)
table.insert(stock14, 255)
table.insert(price14, 5)
table.insert(disct14, 100)
table.insert(money14, 1)	

table.insert(goods14, 81)
table.insert(count14, 1)
table.insert(spoil14, 255)
table.insert(ratio14, 255)
table.insert(stock14, 255)
table.insert(price14, 5)
table.insert(disct14, 100)
table.insert(money14, 1)		
		
table.insert(goods14, 82)
table.insert(count14, 1)
table.insert(spoil14, 255)
table.insert(ratio14, 255)
table.insert(stock14, 255)
table.insert(price14, 5)
table.insert(disct14, 100)
table.insert(money14, 1)		
		
table.insert(goods14, 83)
table.insert(count14, 1)
table.insert(spoil14, 255)
table.insert(ratio14, 255)
table.insert(stock14, 255)
table.insert(price14, 10)
table.insert(disct14, 100)
table.insert(money14, 1)		
		
table.insert(goods14, 84)
table.insert(count14, 1)
table.insert(spoil14, 255)
table.insert(ratio14, 255)
table.insert(stock14, 255)
table.insert(price14, 20)
table.insert(disct14, 100)
table.insert(money14, 1)
------------ goat kid 2 ----------------------------
table.insert(goods15, 85)
table.insert(count15, 1)
table.insert(spoil15, 255)
table.insert(ratio15, 255)
table.insert(stock15, 255)
table.insert(price15, 10)
table.insert(disct15, 100)
table.insert(money15, 1)	
		
table.insert(goods15, 86)
table.insert(count15, 1)
table.insert(spoil15, 255)
table.insert(ratio15, 255)
table.insert(stock15, 255)
table.insert(price15, 8)
table.insert(disct15, 100)
table.insert(money15, 1)	

table.insert(goods15, 87)
table.insert(count15, 1)
table.insert(spoil15, 255)
table.insert(ratio15, 255)
table.insert(stock15, 255)
table.insert(price15, 3)
table.insert(disct15, 100)
table.insert(money15, 1)		
		
table.insert(goods15, 88)
table.insert(count15, 1)
table.insert(spoil15, 255)
table.insert(ratio15, 255)
table.insert(stock15, 255)
table.insert(price15, 4)
table.insert(disct15, 100)
table.insert(money15, 1)		
		
table.insert(goods15, 89)
table.insert(count15, 1)
table.insert(spoil15, 255)
table.insert(ratio15, 255)
table.insert(stock15, 255)
table.insert(price15, 5)
table.insert(disct15, 100)
table.insert(money15, 1)		
		
table.insert(goods15, 90)
table.insert(count15, 1)
table.insert(spoil15, 255)
table.insert(ratio15, 255)
table.insert(stock15, 255)
table.insert(price15, 1)
table.insert(disct15, 100)
table.insert(money15, 2)	

------------ merm trade 3 ----------------------------
table.insert(goods16, 91)
table.insert(count16, 1)
table.insert(spoil16, 255)
table.insert(ratio16, 255)
table.insert(stock16, 255)
table.insert(price16, 1)
table.insert(disct16, 100)
table.insert(money16, 1)	
		
table.insert(goods16, 92)
table.insert(count16, 5)
table.insert(spoil16, 255)
table.insert(ratio16, 255)
table.insert(stock16, 255)
table.insert(price16, 1)
table.insert(disct16, 100)
table.insert(money16, 2)	

table.insert(goods16, 93)
table.insert(count16, 1)
table.insert(spoil16, 255)
table.insert(ratio16, 255)
table.insert(stock16, 255)
table.insert(price16, 5)
table.insert(disct16, 100)
table.insert(money16, 1)		
		
table.insert(goods16, 94)
table.insert(count16, 1)
table.insert(spoil16, 255)
table.insert(ratio16, 255)
table.insert(stock16, 255)
table.insert(price16, 5)
table.insert(disct16, 100)
table.insert(money16, 5)		
		
table.insert(goods16, 95)
table.insert(count16, 1)
table.insert(spoil16, 255)
table.insert(ratio16, 255)
table.insert(stock16, 255)
table.insert(price16, 2)
table.insert(disct16, 100)
table.insert(money16, 1)		
		
table.insert(goods16, 96)
table.insert(count16, 1)
table.insert(spoil16, 255)
table.insert(ratio16, 255)
table.insert(stock16, 255)
table.insert(price16, 2)
table.insert(disct16, 100)
table.insert(money16, 1)	
	
		GoodsDataClient =
        {
            ["goods1"] = goods1, ["count1"] = count1,
            ["spoil1"] = spoil1, ["ratio1"] = ratio1,
            ["stock1"] = stock1, ["money1"] = money1,
            ["price1"] = price1, ["disct1"] = disct1,
			
			["goods2"] = goods2, ["count2"] = count2,
            ["spoil2"] = spoil2, ["ratio2"] = ratio2,
            ["stock2"] = stock2, ["money2"] = money2,
            ["price2"] = price2, ["disct2"] = disct2,
			
			["goods3"] = goods3, ["count3"] = count3,
            ["spoil3"] = spoil3, ["ratio3"] = ratio3,
            ["stock3"] = stock3, ["money3"] = money3,
            ["price3"] = price3, ["disct3"] = disct3,
			
            ["goods4"] = goods4, ["count4"] = count4,
            ["spoil4"] = spoil4, ["ratio4"] = ratio4,
            ["stock4"] = stock4, ["money4"] = money4,
            ["price4"] = price4, ["disct4"] = disct4,

            ["goods5"] = goods5, ["count5"] = count5,
            ["spoil5"] = spoil5, ["ratio5"] = ratio5,
            ["stock5"] = stock5, ["money5"] = money5,
            ["price5"] = price5, ["disct5"] = disct5,

            ["goods6"] = goods6, ["count6"] = count6,
            ["spoil6"] = spoil6, ["ratio6"] = ratio6,
            ["stock6"] = stock6, ["money6"] = money6,
            ["price6"] = price6, ["disct6"] = disct6,

            ["goods7"] = goods7, ["count7"] = count7,
            ["spoil7"] = spoil7, ["ratio7"] = ratio7,
            ["stock7"] = stock7, ["money7"] = money7,
            ["price7"] = price7, ["disct7"] = disct7,
			
            ["goods8"] = goods8, ["count8"] = count8,
            ["spoil8"] = spoil8, ["ratio8"] = ratio8,
            ["stock8"] = stock8, ["money8"] = money8,
            ["price8"] = price8, ["disct8"] = disct8,	

            ["goods9"] = goods9, ["count9"] = count9,
            ["spoil9"] = spoil9, ["ratio9"] = ratio9,
            ["stock9"] = stock9, ["money9"] = money9,
            ["price9"] = price9, ["disct9"] = disct9,	

            ["goods10"] = goods10, ["count10"] = count10,
            ["spoil10"] = spoil10, ["ratio10"] = ratio10,
            ["stock10"] = stock10, ["money10"] = money10,
            ["price10"] = price10, ["disct10"] = disct10,	

            ["goods11"] = goods11, ["count11"] = count11,
            ["spoil11"] = spoil11, ["ratio11"] = ratio11,
            ["stock11"] = stock11, ["money11"] = money11,
            ["price11"] = price11, ["disct11"] = disct11,

            ["goods12"] = goods12, ["count12"] = count12,
            ["spoil12"] = spoil12, ["ratio12"] = ratio12,
            ["stock12"] = stock12, ["money12"] = money12,
            ["price12"] = price12, ["disct12"] = disct12,

            ["goods13"] = goods13, ["count13"] = count13,
            ["spoil13"] = spoil13, ["ratio13"] = ratio13,
            ["stock13"] = stock13, ["money13"] = money13,
            ["price13"] = price13, ["disct13"] = disct13,

            ["goods14"] = goods14, ["count14"] = count14,
            ["spoil14"] = spoil14, ["ratio14"] = ratio14,
            ["stock14"] = stock14, ["money14"] = money14,
            ["price14"] = price14, ["disct14"] = disct14,

            ["goods15"] = goods15, ["count15"] = count15,
            ["spoil15"] = spoil15, ["ratio15"] = ratio15,
            ["stock15"] = stock15, ["money15"] = money15,
            ["price15"] = price15, ["disct15"] = disct15,	

            ["goods16"] = goods16, ["count16"] = count16,
            ["spoil16"] = spoil16, ["ratio16"] = ratio16,
            ["stock16"] = stock16, ["money16"] = money16,
            ["price16"] = price16, ["disct16"] = disct16,				
			
			["goods"] = goods, ["count"] = count,
            ["spoil"] = spoil, ["ratio"] = ratio,
            ["stock"] = stock, ["money"] = money,
            ["price"] = price, ["disct"] = disct,
        }
end

----------------------------------------------------------------------------------------------------
--[FUNC] 用于 ServerStore 的相关回调函数
----------------------------------------------------------------------------------------------------
--==============================--
--desc:处理客户端数据请求
--@player:RPC发送对象
--@inst:商店实例
--==============================--
local function ClientRequested(player, inst)

if inst.prefab == "lavaarena_boarlord" then 
    inst._goodslist:set(GoodsDataClient.goods1)
    inst._countlist:set(GoodsDataClient.count1)
    inst._spoillist:set(GoodsDataClient.spoil1)
    inst._ratiolist:set(GoodsDataClient.ratio1)
    inst._stocklist:set(GoodsDataClient.stock1)
    inst._moneylist:set(GoodsDataClient.money1)
    inst._pricelist:set(GoodsDataClient.price1)
    inst._disctlist:set(GoodsDataClient.disct1)
	
	GoodsDataClient.goods = GoodsDataClient.goods1
    GoodsDataClient.count = GoodsDataClient.count1
    GoodsDataClient.spoil = GoodsDataClient.spoil1
    GoodsDataClient.ratio = GoodsDataClient.ratio1
    GoodsDataClient.stock = GoodsDataClient.stock1
    GoodsDataClient.money = GoodsDataClient.money1
    GoodsDataClient.price = GoodsDataClient.price1
    GoodsDataClient.disct = GoodsDataClient.disct1
	
elseif inst.prefab == "lavaarena_spectator2" then    
    inst._goodslist:set(GoodsDataClient.goods2)
    inst._countlist:set(GoodsDataClient.count2)
    inst._spoillist:set(GoodsDataClient.spoil2)
    inst._ratiolist:set(GoodsDataClient.ratio2)
    inst._stocklist:set(GoodsDataClient.stock2)
    inst._moneylist:set(GoodsDataClient.money2)
    inst._pricelist:set(GoodsDataClient.price2)
    inst._disctlist:set(GoodsDataClient.disct2)
	
	GoodsDataClient.goods = GoodsDataClient.goods2
    GoodsDataClient.count = GoodsDataClient.count2
    GoodsDataClient.spoil = GoodsDataClient.spoil2
    GoodsDataClient.ratio = GoodsDataClient.ratio2
    GoodsDataClient.stock = GoodsDataClient.stock2
    GoodsDataClient.money = GoodsDataClient.money2
    GoodsDataClient.price = GoodsDataClient.price2
    GoodsDataClient.disct = GoodsDataClient.disct2
	
elseif inst.prefab == "lavaarena_spectator4" then 
    inst._goodslist:set(GoodsDataClient.goods3)
    inst._countlist:set(GoodsDataClient.count3)
    inst._spoillist:set(GoodsDataClient.spoil3)
    inst._ratiolist:set(GoodsDataClient.ratio3)
    inst._stocklist:set(GoodsDataClient.stock3)
    inst._moneylist:set(GoodsDataClient.money3)
    inst._pricelist:set(GoodsDataClient.price3)
    inst._disctlist:set(GoodsDataClient.disct3)
	
	GoodsDataClient.goods = GoodsDataClient.goods3
    GoodsDataClient.count = GoodsDataClient.count3
    GoodsDataClient.spoil = GoodsDataClient.spoil3
    GoodsDataClient.ratio = GoodsDataClient.ratio3
    GoodsDataClient.stock = GoodsDataClient.stock3
    GoodsDataClient.money = GoodsDataClient.money3
    GoodsDataClient.price = GoodsDataClient.price3
    GoodsDataClient.disct = GoodsDataClient.disct3
	
elseif inst.prefab == "lavaarena_spectator3" then 
    inst._goodslist:set(GoodsDataClient.goods8)
    inst._countlist:set(GoodsDataClient.count8)
    inst._spoillist:set(GoodsDataClient.spoil8)
    inst._ratiolist:set(GoodsDataClient.ratio8)
    inst._stocklist:set(GoodsDataClient.stock8)
    inst._moneylist:set(GoodsDataClient.money8)
    inst._pricelist:set(GoodsDataClient.price8)
    inst._disctlist:set(GoodsDataClient.disct8)

    GoodsDataClient.goods = GoodsDataClient.goods8
    GoodsDataClient.count = GoodsDataClient.count8
    GoodsDataClient.spoil = GoodsDataClient.spoil8
    GoodsDataClient.ratio = GoodsDataClient.ratio8
    GoodsDataClient.stock = GoodsDataClient.stock8
    GoodsDataClient.money = GoodsDataClient.money8
    GoodsDataClient.price = GoodsDataClient.price8
    GoodsDataClient.disct = GoodsDataClient.disct8	

elseif inst.prefab == "quagmire_goatkid" then 
    inst._goodslist:set(GoodsDataClient.goods10)
    inst._countlist:set(GoodsDataClient.count10)
    inst._spoillist:set(GoodsDataClient.spoil10)
    inst._ratiolist:set(GoodsDataClient.ratio10)
    inst._stocklist:set(GoodsDataClient.stock10)
    inst._moneylist:set(GoodsDataClient.money10)
    inst._pricelist:set(GoodsDataClient.price10)
    inst._disctlist:set(GoodsDataClient.disct10)

    GoodsDataClient.goods = GoodsDataClient.goods10
    GoodsDataClient.count = GoodsDataClient.count10
    GoodsDataClient.spoil = GoodsDataClient.spoil10
    GoodsDataClient.ratio = GoodsDataClient.ratio10
    GoodsDataClient.stock = GoodsDataClient.stock10
    GoodsDataClient.money = GoodsDataClient.money10
    GoodsDataClient.price = GoodsDataClient.price10
    GoodsDataClient.disct = GoodsDataClient.disct10	

elseif inst.prefab == "quagmire_goatmum" then 
    inst._goodslist:set(GoodsDataClient.goods11)
    inst._countlist:set(GoodsDataClient.count11)
    inst._spoillist:set(GoodsDataClient.spoil11)
    inst._ratiolist:set(GoodsDataClient.ratio11)
    inst._stocklist:set(GoodsDataClient.stock11)
    inst._moneylist:set(GoodsDataClient.money11)
    inst._pricelist:set(GoodsDataClient.price11)
    inst._disctlist:set(GoodsDataClient.disct11)

    GoodsDataClient.goods = GoodsDataClient.goods11
    GoodsDataClient.count = GoodsDataClient.count11
    GoodsDataClient.spoil = GoodsDataClient.spoil11
    GoodsDataClient.ratio = GoodsDataClient.ratio11
    GoodsDataClient.stock = GoodsDataClient.stock11
    GoodsDataClient.money = GoodsDataClient.money11
    GoodsDataClient.price = GoodsDataClient.price11
    GoodsDataClient.disct = GoodsDataClient.disct11	

elseif inst.prefab == "quagmire_trader_merm" then 
    inst._goodslist:set(GoodsDataClient.goods12)
    inst._countlist:set(GoodsDataClient.count12)
    inst._spoillist:set(GoodsDataClient.spoil12)
    inst._ratiolist:set(GoodsDataClient.ratio12)
    inst._stocklist:set(GoodsDataClient.stock12)
    inst._moneylist:set(GoodsDataClient.money12)
    inst._pricelist:set(GoodsDataClient.price12)
    inst._disctlist:set(GoodsDataClient.disct12)

    GoodsDataClient.goods = GoodsDataClient.goods12
    GoodsDataClient.count = GoodsDataClient.count12
    GoodsDataClient.spoil = GoodsDataClient.spoil12
    GoodsDataClient.ratio = GoodsDataClient.ratio12
    GoodsDataClient.stock = GoodsDataClient.stock12
    GoodsDataClient.money = GoodsDataClient.money12
    GoodsDataClient.price = GoodsDataClient.price12
    GoodsDataClient.disct = GoodsDataClient.disct12	

elseif inst.prefab == "quagmire_trader_merm2" then 
    inst._goodslist:set(GoodsDataClient.goods13)
    inst._countlist:set(GoodsDataClient.count13)
    inst._spoillist:set(GoodsDataClient.spoil13)
    inst._ratiolist:set(GoodsDataClient.ratio13)
    inst._stocklist:set(GoodsDataClient.stock13)
    inst._moneylist:set(GoodsDataClient.money13)
    inst._pricelist:set(GoodsDataClient.price13)
    inst._disctlist:set(GoodsDataClient.disct13)

    GoodsDataClient.goods = GoodsDataClient.goods13
    GoodsDataClient.count = GoodsDataClient.count13
    GoodsDataClient.spoil = GoodsDataClient.spoil13
    GoodsDataClient.ratio = GoodsDataClient.ratio13
    GoodsDataClient.stock = GoodsDataClient.stock13
    GoodsDataClient.money = GoodsDataClient.money13
    GoodsDataClient.price = GoodsDataClient.price13
    GoodsDataClient.disct = GoodsDataClient.disct13	

elseif inst.prefab == "quagmire_swampigelder" then 
    inst._goodslist:set(GoodsDataClient.goods14)
    inst._countlist:set(GoodsDataClient.count14)
    inst._spoillist:set(GoodsDataClient.spoil14)
    inst._ratiolist:set(GoodsDataClient.ratio14)
    inst._stocklist:set(GoodsDataClient.stock14)
    inst._moneylist:set(GoodsDataClient.money14)
    inst._pricelist:set(GoodsDataClient.price14)
    inst._disctlist:set(GoodsDataClient.disct14)

    GoodsDataClient.goods = GoodsDataClient.goods14
    GoodsDataClient.count = GoodsDataClient.count14
    GoodsDataClient.spoil = GoodsDataClient.spoil14
    GoodsDataClient.ratio = GoodsDataClient.ratio14
    GoodsDataClient.stock = GoodsDataClient.stock14
    GoodsDataClient.money = GoodsDataClient.money14
    GoodsDataClient.price = GoodsDataClient.price14
    GoodsDataClient.disct = GoodsDataClient.disct14	

elseif inst.prefab == "quagmire_goatkid2" then 
    inst._goodslist:set(GoodsDataClient.goods15)
    inst._countlist:set(GoodsDataClient.count15)
    inst._spoillist:set(GoodsDataClient.spoil15)
    inst._ratiolist:set(GoodsDataClient.ratio15)
    inst._stocklist:set(GoodsDataClient.stock15)
    inst._moneylist:set(GoodsDataClient.money15)
    inst._pricelist:set(GoodsDataClient.price15)
    inst._disctlist:set(GoodsDataClient.disct15)

    GoodsDataClient.goods = GoodsDataClient.goods15
    GoodsDataClient.count = GoodsDataClient.count15
    GoodsDataClient.spoil = GoodsDataClient.spoil15
    GoodsDataClient.ratio = GoodsDataClient.ratio15
    GoodsDataClient.stock = GoodsDataClient.stock15
    GoodsDataClient.money = GoodsDataClient.money15
    GoodsDataClient.price = GoodsDataClient.price15
    GoodsDataClient.disct = GoodsDataClient.disct15	

elseif inst.prefab == "quagmire_trader_merm3" then 
    inst._goodslist:set(GoodsDataClient.goods16)
    inst._countlist:set(GoodsDataClient.count16)
    inst._spoillist:set(GoodsDataClient.spoil16)
    inst._ratiolist:set(GoodsDataClient.ratio16)
    inst._stocklist:set(GoodsDataClient.stock16)
    inst._moneylist:set(GoodsDataClient.money16)
    inst._pricelist:set(GoodsDataClient.price16)
    inst._disctlist:set(GoodsDataClient.disct16)

    GoodsDataClient.goods = GoodsDataClient.goods16
    GoodsDataClient.count = GoodsDataClient.count16
    GoodsDataClient.spoil = GoodsDataClient.spoil16
    GoodsDataClient.ratio = GoodsDataClient.ratio16
    GoodsDataClient.stock = GoodsDataClient.stock16
    GoodsDataClient.money = GoodsDataClient.money16
    GoodsDataClient.price = GoodsDataClient.price16
    GoodsDataClient.disct = GoodsDataClient.disct16		
	
elseif inst.prefab == "lavaarena_spectator1" then
local variador = math.random (1,5)
if variador == 1 then
--if math.fmod (GLOBAL.TheWorld.state.cycles, 5) == 0 then
    inst._goodslist:set(GoodsDataClient.goods4)
    inst._countlist:set(GoodsDataClient.count4)
    inst._spoillist:set(GoodsDataClient.spoil4)
    inst._ratiolist:set(GoodsDataClient.ratio4)
    inst._stocklist:set(GoodsDataClient.stock4)
    inst._moneylist:set(GoodsDataClient.money4)
    inst._pricelist:set(GoodsDataClient.price4)
    inst._disctlist:set(GoodsDataClient.disct4)

    GoodsDataClient.goods = GoodsDataClient.goods4
    GoodsDataClient.count = GoodsDataClient.count4
    GoodsDataClient.spoil = GoodsDataClient.spoil4
    GoodsDataClient.ratio = GoodsDataClient.ratio4
    GoodsDataClient.stock = GoodsDataClient.stock4
    GoodsDataClient.money = GoodsDataClient.money4
    GoodsDataClient.price = GoodsDataClient.price4
    GoodsDataClient.disct = GoodsDataClient.disct4
elseif variador == 2 then
--elseif math.fmod (GLOBAL.TheWorld.state.cycles, 4) == 0 then
    inst._goodslist:set(GoodsDataClient.goods5)
    inst._countlist:set(GoodsDataClient.count5)
    inst._spoillist:set(GoodsDataClient.spoil5)
    inst._ratiolist:set(GoodsDataClient.ratio5)
    inst._stocklist:set(GoodsDataClient.stock5)
    inst._moneylist:set(GoodsDataClient.money5)
    inst._pricelist:set(GoodsDataClient.price5)
    inst._disctlist:set(GoodsDataClient.disct5)

    GoodsDataClient.goods = GoodsDataClient.goods5
    GoodsDataClient.count = GoodsDataClient.count5
    GoodsDataClient.spoil = GoodsDataClient.spoil5
    GoodsDataClient.ratio = GoodsDataClient.ratio5
    GoodsDataClient.stock = GoodsDataClient.stock5
    GoodsDataClient.money = GoodsDataClient.money5
    GoodsDataClient.price = GoodsDataClient.price5
    GoodsDataClient.disct = GoodsDataClient.disct5
elseif variador == 3 then	
--elseif math.fmod (GLOBAL.TheWorld.state.cycles, 3) == 0 then
    inst._goodslist:set(GoodsDataClient.goods6)
    inst._countlist:set(GoodsDataClient.count6)
    inst._spoillist:set(GoodsDataClient.spoil6)
    inst._ratiolist:set(GoodsDataClient.ratio6)
    inst._stocklist:set(GoodsDataClient.stock6)
    inst._moneylist:set(GoodsDataClient.money6)
    inst._pricelist:set(GoodsDataClient.price6)
    inst._disctlist:set(GoodsDataClient.disct6)

    GoodsDataClient.goods = GoodsDataClient.goods6
    GoodsDataClient.count = GoodsDataClient.count6
    GoodsDataClient.spoil = GoodsDataClient.spoil6
    GoodsDataClient.ratio = GoodsDataClient.ratio6
    GoodsDataClient.stock = GoodsDataClient.stock6
    GoodsDataClient.money = GoodsDataClient.money6
    GoodsDataClient.price = GoodsDataClient.price6
    GoodsDataClient.disct = GoodsDataClient.disct6
elseif variador == 4 then	
--elseif math.fmod (GLOBAL.TheWorld.state.cycles, 2) == 0 then	

    inst._goodslist:set(GoodsDataClient.goods7)
    inst._countlist:set(GoodsDataClient.count7)
    inst._spoillist:set(GoodsDataClient.spoil7)
    inst._ratiolist:set(GoodsDataClient.ratio7)
    inst._stocklist:set(GoodsDataClient.stock7)
    inst._moneylist:set(GoodsDataClient.money7)
    inst._pricelist:set(GoodsDataClient.price7)
    inst._disctlist:set(GoodsDataClient.disct7)

    GoodsDataClient.goods = GoodsDataClient.goods7
    GoodsDataClient.count = GoodsDataClient.count7
    GoodsDataClient.spoil = GoodsDataClient.spoil7
    GoodsDataClient.ratio = GoodsDataClient.ratio7
    GoodsDataClient.stock = GoodsDataClient.stock7
    GoodsDataClient.money = GoodsDataClient.money7
    GoodsDataClient.price = GoodsDataClient.price7
    GoodsDataClient.disct = GoodsDataClient.disct7	
	
else

    inst._goodslist:set(GoodsDataClient.goods9)
    inst._countlist:set(GoodsDataClient.count9)
    inst._spoillist:set(GoodsDataClient.spoil9)
    inst._ratiolist:set(GoodsDataClient.ratio9)
    inst._stocklist:set(GoodsDataClient.stock9)
    inst._moneylist:set(GoodsDataClient.money9)
    inst._pricelist:set(GoodsDataClient.price9)
    inst._disctlist:set(GoodsDataClient.disct9)

    GoodsDataClient.goods = GoodsDataClient.goods9
    GoodsDataClient.count = GoodsDataClient.count9
    GoodsDataClient.spoil = GoodsDataClient.spoil9
    GoodsDataClient.ratio = GoodsDataClient.ratio9
    GoodsDataClient.stock = GoodsDataClient.stock9
    GoodsDataClient.money = GoodsDataClient.money9
    GoodsDataClient.price = GoodsDataClient.price9
    GoodsDataClient.disct = GoodsDataClient.disct9
	
end
 
end	
end

--==============================--
--desc:处理客户端购买请求
--@player:RPC发送对象
--@index:货物编号
--@locat:货架编号
--==============================--
local function ClientPurchased(player, index, locat)
    if not player.components then return false end
    if not player.components.inventory then return false end
    
    local price = GoodsDataClient.price[locat]
    local count = GoodsDataClient.count[locat]
    local spoil = GoodsDataClient.spoil[locat]
    local ratio = GoodsDataClient.ratio[locat]
    local money = GoodsDataClient.money[locat]
    local stock = GoodsDataClient.stock[locat]
    local disct = GoodsDataClient.disct[locat]
    
    if stock == 0 then return false end
    
    local moneyPrefab = CoinsPrefab[money]
    if not player.components.inventory:Has(moneyPrefab, math.ceil(price * disct / 100)) then return false end
    player.components.inventory:ConsumeByName(moneyPrefab, math.ceil(price * disct / 100))
    
    for var = 1, count, 1 do
        local inst = GLOBAL.SpawnPrefab(GoodsPrefab[index])
        if not inst.components.inventoryitem then return false end
        if spoil ~= 255 and inst.components.perishable then inst.components.perishable:SetPercent(spoil / 100) end
        if ratio ~= 255 and inst.components.finiteUses then inst.components.finiteUses:SetPercent(ratio / 100) end
        player.components.inventory:GiveItem(inst)
    end
    GoodsDataClient.stock[locat] = GoodsDataClient.stock[locat] - 1
    
    for k, store in pairs(StoreStructures) do
        store._stocklist:set(GoodsDataClient.stock)
        store.NetEvt_Purchased:push()
    end
end

local function ClientOpenStore(player)

end

local function ClientShutStore(player, inst)
    player._isopening:set(false)
    inst.NetEvt_ShutStore:push()
end
----------------------------------------------------------------------------------------------------
--[API]AddModRPCHandler(namespace, name, fn)
---在找不到其他回调函数的时候 使用本地的回调函数
----------------------------------------------------------------------------------------------------
if not GLOBAL.TheNet:GetIsClient() and not GLOBAL.MOD_RPC_HANDLERS["ServerStore"] then
    AddModRPCHandler("ServerStore", "Requested", ClientRequested)
    AddModRPCHandler("ServerStore", "OpenStore", ClientOpenStore)
    AddModRPCHandler("ServerStore", "Purchased", ClientPurchased)
    AddModRPCHandler("ServerStore", "ShutStore", ClientShutStore)
    PrepareGoodsData()
end
