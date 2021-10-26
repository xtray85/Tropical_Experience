local a=Class(function(self,b)
self.inst=b;
self.duration=TUNING.FORGE_ITEM_PACK.TFWP_CONTROL_BOOK.DURATION;
self.range=TUNING.FORGE_ITEM_PACK.TFWP_CONTROL_BOOK.ALT_RADIUS end)

function a:SetDuration(c)
self.duration=c end;

function a:SpawnFosilFx(d)
local e={}for f=1,20 do local g=f/5;local h=math.sqrt(g*512)
local i=math.sqrt(g)
local j=Vector3(math.sin(h)*i*1.2,0,math.cos(h)*i*1.2)
local k=TheWorld.Map:GetTileAtPoint((d+j):Get())if k~=1 and k~=255 then 
table.insert(e,j)end end;
local f=0;self.spawn_task=self.inst:DoPeriodicTask(.15,function()f=f+1;if f>=13 and self.spawn_task then 
self.spawn_task:Cancel()
self.spawn_task=nil;
return end;
SpawnAt("fossilizing_fx",d+e[math.random(#e)]).Transform:SetScale(.65,.65,.65)end)end;

function a:Fossilize(d,l)
self:SpawnFosilFx(d)
local f=0;
self.check_task=self.inst:DoPeriodicTask(.25,function()
local m=TheSim:FindEntities(d.x,0,d.z,self.range,nil,{"player"})

for n,o in ipairs(m)do

if o.components.freezable and not o.components.freezable:IsFrozen() and not o:HasTag("player") then
--if o.components.combat then
--o:PushEvent("attacked", {attacker = self.inst, damage = 0, weapon = self.inst})
--end
o.components.freezable:AddColdness(5)
o.components.freezable:SpawnShatterFX()
end
--o:PushEvent("fossilize",{duration=self.duration,doer=l})
end;
f=f+1;
if f>=11 and self.check_task then 
self.check_task:Cancel()self.check_task=nil end end)end;

function a:OnRemoveEntity()for n,p in ipairs({"spawn_task","check_task"})do 
if self[p]~=nil then self[p]:Cancel()self[p]=nil end end;if self.inst.components.reticule_spawner then 
self.inst.components.reticule_spawner:KillRet()end end;
a.OnRemoveFromEntity=a.OnRemoveEntity;function a:GetDebugString()return string.format("Duration: %2.2f",self.duration)end;
return a