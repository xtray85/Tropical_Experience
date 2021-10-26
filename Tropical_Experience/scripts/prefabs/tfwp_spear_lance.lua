local a={
Asset("ANIM","anim/spear_lance.zip"),
Asset("ANIM","anim/swap_spear_lance.zip")}
local b={"reticuleaoesmall","reticuleaoesmallping","reticuleaoesmallhostiletarget","weaponsparks_fx","weaponsparks_thrusting","forgespear_fx","superjump_fx"}
local function c(d,e)
e.AnimState:OverrideSymbol("swap_object","swap_spear_lance","swap_spear_lance")
e.AnimState:Show("ARM_carry")
e.AnimState:Hide("ARM_normal")end;local function f(d,e)
e.AnimState:Hide("ARM_carry")
e.AnimState:Show("ARM_normal")end;
local function g()local h=ThePlayer;
local i=TheWorld.Map;
local j=Vector3()for k=5,0,-.25 do j.x,j.y,j.z=h.entity:LocalToWorldSpace(k,0,0)if i:IsPassableAtPoint(j:Get())and not i:IsGroundTargetBlocked(j)then return j end end;
return j end;
local function l(d,m,j)m:PushEvent("combat_superjump",{targetpos=j,weapon=d})end;
local function n(d)SpawnPrefab("superjump_fx"):SetTarget(d)d.components.recarregavel:StartRecharge()end;
local function o(d,p,q)if not d.components.weapon.isaltattacking then SpawnPrefab("weaponsparks_fx"):SetPosition(p,q)else SpawnPrefab("forgespear_fx"):SetTarget(q)end end;
local function r()
local d=CreateEntity()
d.entity:AddTransform()
d.entity:AddAnimState()
d.entity:AddNetwork()
MakeInventoryPhysics(d)
d.nameoverride="spear_lance"
d.AnimState:SetBank("spear_lance")
d.AnimState:SetBuild("spear_lance")
d.AnimState:PlayAnimation("idle")
d:AddTag("aoeweapon_leap")
d:AddTag("pointy")
d:AddTag("rechargeable")
d:AddTag("sharp")
d:AddTag("superjump")
d:AddComponent("aoetargeting")
d.components.aoetargeting:SetRange(TUNING.FORGE_ITEM_PACK.TFWP_SPEAR_LANCE.ALT_RANGE)
d.components.aoetargeting.reticule.reticuleprefab="reticuleaoesmall"
d.components.aoetargeting.reticule.pingprefab="reticuleaoesmallping"
d.components.aoetargeting.reticule.targetfn=g;
d.components.aoetargeting.reticule.validcolour={1,.75,0,1}
d.components.aoetargeting.reticule.invalidcolour={.5,0,0,1}
d.components.aoetargeting.reticule.ease=true;
d.components.aoetargeting.reticule.mouseenabled=true;
d.entity:SetPristine()
if not TheWorld.ismastersim then return d end;
d.IsWorkableAllowed=function(self,s,t)return s==ACTIONS.CHOP or s==ACTIONS.DIG and t:HasTag("stump")or s==ACTIONS.MINE end;
d:AddComponent("aoespell")
d.components.aoespell:SetAOESpell(l)
d:AddComponent("aoeweapon_leap")
d.components.aoeweapon_leap:SetStimuli("explosive")
d.components.aoeweapon_leap:SetOnLeapFn(n)d:AddComponent("equippable")
d.components.equippable:SetOnEquip(c)
d.components.equippable:SetOnUnequip(f)
d:AddComponent("inspectable")
d:AddComponent("inventoryitem")
d.components.inventoryitem.imagename="spear_lance"
d:AddComponent("multithruster")
d.components.multithruster.weapon=d;
d:AddComponent("recarregavel")
d.components.recarregavel:SetRechargeTime(TUNING.FORGE_ITEM_PACK.TFWP_SPEAR_LANCE.COOLDOWN)
d:AddComponent("reticule_spawner")
d.components.reticule_spawner:Setup(unpack(TUNING.FORGE_ITEM_PACK.RET_DATA.tfwp_spear_lance))
d:AddComponent("weapon")
d.components.weapon:SetDamage(TUNING.FORGE_ITEM_PACK.TFWP_SPEAR_LANCE.DAMAGE)
d.components.weapon:SetOnAttack(o)
d.components.weapon:SetDamageType(DAMAGETYPES.PHYSICAL)
d.components.weapon:SetAltAttack(TUNING.FORGE_ITEM_PACK.TFWP_SPEAR_LANCE.ALT_DAMAGE,TUNING.FORGE_ITEM_PACK.TFWP_SPEAR_LANCE.ALT_RADIUS,nil,DAMAGETYPES.PHYSICAL)return d end;
return 
CustomPrefab("tfwp_spear_lance",r,a,b,nil,"images/inventoryimages.xml","spear_lance.tex",TUNING.FORGE_ITEM_PACK.TFWP_SPEAR_LANCE,"swap_spear_lance","common_hand")