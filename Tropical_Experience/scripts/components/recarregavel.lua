local a=Class(function(self,b)
self.inst=b;
self.recharge=255;
self.rechargetime=-2;
self.maxrechargetime=30;
self.cooldownrate=1;
self.isready=true;
self.updatetask=nil;
self.onready=nil;
self.pickup=false;
self.onequip=function(b,c)
self:RecalculateRate()end;
self.inst:ListenForEvent("equipped",function(b,c)self.owner=c.owner;
self:RecalculateRate()
if self.updatetask==nil then 
self.pickup=true;
self:StartRecharge()end;
self.inst:ListenForEvent("equip",self.onequip,self.owner)
self.inst:ListenForEvent("unequip",self.onequip,self.owner)end)
self.inst:ListenForEvent("unequipped",function(b,c)
self.inst:RemoveEventCallback("equip",self.onequip,self.owner)self.inst:RemoveEventCallback("unequip",self.onequip,self.owner)
if self.pickup and self.updatetask~=nil then self.pickup=false;
self.updatetask:Cancel()self.updatetask=nil end;self.cooldownrate=1;
self.owner=nil end)end)

function a:SetRechargeTime(d)self.maxrechargetime=d end;
function a:SetOnReadyFn(e)self.onready=e end;
function a:RecalculateRate()if self.owner~=nil then 
self.cooldownrate=1+self.owner.components.buffable:GetBuffData("cooldown_mult")
if self.updatetask~=nil and self.inst.replica~=nil and self.inst.replica.inventoryitem~=nil then 
self.inst.replica.inventoryitem:SetChargeTime(self:GetRechargeTime())end end end;


function a:FinishRecharge()if self.updatetask~=nil then self.updatetask:Cancel()self.updatetask=nil end;
self.isready=true;if self.inst.components.aoetargeting then 
self.inst.components.aoetargeting:SetEnabled(true)end;
if self.onready then self.onready(self.inst)end;self.pickup=false;
self.recharge=255;self.inst:PushEvent("rechargechange",{percent=self.recharge and self.recharge/180,overtime=false})end;
function a:Update()self.recharge=self.recharge+180*FRAMES/(self.rechargetime*(self.pickup and 1 or self.cooldownrate))
if self.recharge>=180 then self:FinishRecharge()end end;


function a:StartRecharge()
self.isready=false;
if self.inst.components.aoetargeting then 
self.inst.components.aoetargeting:SetEnabled(false)end;
self.rechargetime=self.pickup and 1 or self.maxrechargetime;
self.recharge=0;
self:RecalculateRate()
self.inst:DoTaskInTime(0,function()if self.inst.replica~=nil and self.inst.replica.inventoryitem~=nil then 
self.inst.replica.inventoryitem:SetChargeTime(self:GetRechargeTime())end;
self.inst:PushEvent("rechargechange",{percent=self.recharge and self.recharge/180,overtime=false})
self.updatetask=self.inst:DoPeriodicTask(FRAMES,function()self:Update()end)end)end;


function a:GetPercent()return self.recharge and self.recharge/180,false end;function a:GetRechargeTime()return self.pickup and 1 or self.maxrechargetime*self.cooldownrate end;function a:GetDebugString()return string.format("recharge: %2.2f, rechargetime: %2.2f, cooldownrate: %2.2f",self.recharge,self:GetRechargeTime(),self.cooldownrate)end;
return a