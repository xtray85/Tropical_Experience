local a={
Asset("ANIM","anim/spear_gungnir.zip"),
Asset("ANIM","anim/swap_spear_gungnir.zip")}
local b={Asset("ANIM","anim/lavaarena_staff_smoke_fx.zip")}
local c={"reticuleline","reticulelineping","spear_gungnir_lungefx","weaponsparks_fx","firehit"}
local function d(e,f)
f.AnimState:OverrideSymbol("swap_object","swap_spear_gungnir","swap_spear_gungnir")
f.AnimState:Show("ARM_carry")
f.AnimState:Hide("ARM_normal")end;
local function g(e,f)f.AnimState:Hide("ARM_carry")f.AnimState:Show("ARM_normal")end;
local function h()return Vector3(ThePlayer.entity:LocalToWorldSpace(TUNING.FORGE_ITEM_PACK.TFWP_SPEAR_GUNG.ALT_DIST,0,0))end;
local function i(e,j)if j~=nil then local k,l,m=e.Transform:GetWorldPosition()
local n=j.x-k;local o=j.z-m;local p=n*n+o*o;if p<=0 then 
return e.components.reticule.targetpos end;
p=6.5/math.sqrt(p)return Vector3(k+n*p,0,m+o*p)end end;
local function q(e,r,s,t,u,v)local k,l,m=e.Transform:GetWorldPosition()s.Transform:SetPosition(k,0,m)
local w=-math.atan2(r.z-m,r.x-k)/DEGREES;if t and v~=nil then 
local x=s.Transform:GetRotation()local y=w-x;w=Lerp(y>180 and x+360 or y<-180 and x-360 or x,w,v*u)end;
s.Transform:SetRotation(w)end;
local function z(e,A,r)A:PushEvent("combat_lunge",{targetpos=r,weapon=e})end;
local function B(e,C,D)
if not e.components.weapon.isaltattacking then 
SpawnPrefab("weaponsparks_fx"):SetPosition(C,D)else 
SpawnPrefab("forgespear_fx"):SetTarget(D)
if D and D:HasTag("flippable")then D:PushEvent("flipped",{flipper=C})end end end;

local function E(e)e.components.recarregavel:StartRecharge()end;
local function F()
local e=CreateEntity()
e.entity:AddTransform()
e.entity:AddAnimState()
e.entity:AddNetwork()
MakeInventoryPhysics(e)
e.nameoverride="spear_gungnir"
e.AnimState:SetBank("spear_gungnir")
e.AnimState:SetBuild("spear_gungnir")
e.AnimState:PlayAnimation("idle")
e:AddTag("aoeweapon_lunge")
e:AddTag("rechargeable")
e:AddTag("sharp")
e:AddTag("pointy")
e:AddComponent("aoetargeting")
e.components.aoetargeting.reticule.reticuleprefab="reticuleline"
e.components.aoetargeting.reticule.pingprefab="reticulelineping"
e.components.aoetargeting.reticule.targetfn=h;
e.components.aoetargeting.reticule.mousetargetfn=i;
e.components.aoetargeting.reticule.updatepositionfn=q;
e.components.aoetargeting.reticule.validcolour={1,.75,0,1}
e.components.aoetargeting.reticule.invalidcolour={.5,0,0,1}
e.components.aoetargeting.reticule.ease=true;
e.components.aoetargeting.reticule.mouseenabled=true;
e.entity:SetPristine()if not TheWorld.ismastersim then return e end;
e.AllowWorkable=function(self,G,H)return G==ACTIONS.MINE end;
e:AddComponent("aoespell")
e.components.aoespell:SetAOESpell(z)
e:AddComponent("aoeweapon_lunge")
e.components.aoeweapon_lunge:SetWidth(TUNING.FORGE_ITEM_PACK.TFWP_SPEAR_GUNG.ALT_WIDTH)
e.components.aoeweapon_lunge:SetStimuli("explosive")
e.components.aoeweapon_lunge:SetOnLungeFn(E)
e:AddComponent("equippable")
e.components.equippable:SetOnEquip(d)
e.components.equippable:SetOnUnequip(g)
e:AddComponent("inspectable")
e:AddComponent("inventoryitem")
e.components.inventoryitem.imagename="spear_gungnir"
e:AddComponent("recarregavel")
e.components.recarregavel:SetRechargeTime(TUNING.FORGE_ITEM_PACK.TFWP_SPEAR_GUNG.COOLDOWN)
e:AddComponent("weapon")
e.components.weapon:SetDamage(TUNING.FORGE_ITEM_PACK.TFWP_SPEAR_GUNG.DAMAGE)
e.components.weapon:SetOnAttack(B)e.components.weapon:SetDamageType(DAMAGETYPES.PHYSICAL)
e.components.weapon:SetAltAttack(TUNING.FORGE_ITEM_PACK.TFWP_SPEAR_GUNG.ALT_DAMAGE,TUNING.FORGE_ITEM_PACK.TFWP_SPEAR_GUNG.ALT_DIST+TUNING.FORGE_ITEM_PACK.TFWP_SPEAR_GUNG.ALT_WIDTH,nil,DAMAGETYPES.PHYSICAL)return e end;

return 
CustomPrefab("tfwp_spear_gung",F,a,c,nil,"images/inventoryimages.xml","spear_gungnir.tex",TUNING.FORGE_ITEM_PACK.TFWP_SPEAR_GUNG,"swap_spear_gungnir","common_hand")