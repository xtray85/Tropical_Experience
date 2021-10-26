local a={
Asset("ANIM","anim/hammer_mjolnir.zip"),
Asset("ANIM","anim/swap_hammer_mjolnir.zip")}
local b={
Asset("ANIM","anim/lavaarena_hammer_attack_fx.zip")}
local c={"forginghammer_crackle_fx","forgeelectricute_fx","reticuleaoe","reticuleaoeping","reticuleaoehostiletarget","weaponsparks_fx"}
local d={"forginghammer_cracklebase_fx"}
local function e(f,g)
g.AnimState:OverrideSymbol("swap_object","swap_hammer_mjolnir","swap_hammer_mjolnir")
g.AnimState:Show("ARM_carry")
g.AnimState:Hide("ARM_normal")end;local function h(f,g)
g.AnimState:Hide("ARM_carry")
g.AnimState:Show("ARM_normal")end;
local function i()local j=ThePlayer;
local k=TheWorld.Map;
local l=Vector3()for m=7,0,-.25 do l.x,l.y,l.z=j.entity:LocalToWorldSpace(m,0,0)if k:IsPassableAtPoint(l:Get())and not k:IsGroundTargetBlocked(l)then 
return l end 
end;
return l end;
local function n(f,o,l)o:PushEvent("combat_leap",{targetpos=l,weapon=f})end;
local function p(f)SpawnPrefab("forginghammer_crackle_fx"):SetTarget(f)
f.components.recarregavel:StartRecharge()end;
local function q(f,r,s)if not f.components.weapon.isaltattacking then 
SpawnPrefab("weaponsparks_fx"):SetPosition(r,s)
if s and s.components.armorbreak_debuff then 
s.components.armorbreak_debuff:ApplyDebuff()end else 
SpawnPrefab("forgeelectricute_fx"):SetTarget(s,true)end end;

local function t()
local f=CreateEntity()
f.entity:AddTransform()
f.entity:AddAnimState()
f.entity:AddSoundEmitter()
f.entity:AddNetwork()
MakeInventoryPhysics(f)
f.nameoverride="hammer_mjolnir"
f.AnimState:SetBank("hammer_mjolnir")
f.AnimState:SetBuild("hammer_mjolnir")
f.AnimState:PlayAnimation("idle")
f:AddTag("aoeweapon_leap")
f:AddTag("hammer")
f:AddTag("rechargeable")
f:AddComponent("aoetargeting")
f.components.aoetargeting.reticule.reticuleprefab="reticuleaoe"
f.components.aoetargeting.reticule.pingprefab="reticuleaoeping"
f.components.aoetargeting.reticule.targetfn=i;
f.components.aoetargeting.reticule.validcolour={1,.75,0,1}
f.components.aoetargeting.reticule.invalidcolour={.5,0,0,1}
f.components.aoetargeting.reticule.ease=true;
f.components.aoetargeting.reticule.mouseenabled=true;
f.entity:SetPristine()if not TheWorld.ismastersim then return f end;
f.IsWorkableAllowed=function(self,u,v)return u==ACTIONS.CHOP or u==ACTIONS.DIG and v:HasTag("stump")or u==ACTIONS.MINE end;
f:AddComponent("aoespell")
f.components.aoespell:SetAOESpell(n)
f:AddComponent("aoeweapon_leap")
f.components.aoeweapon_leap:SetStimuli("electric")
f.components.aoeweapon_leap:SetOnLeapFn(p)
f:AddComponent("reticule_spawner")
f.components.reticule_spawner:Setup(unpack(TUNING.FORGE_ITEM_PACK.RET_DATA.hammer))
f:AddComponent("equippable")
f.components.equippable:SetOnEquip(e)
f.components.equippable:SetOnUnequip(h)
f:AddComponent("inspectable")
f:AddComponent("inventoryitem")
f.components.inventoryitem.imagename="hammer_mjolnir"
f:AddComponent("recarregavel")
f.components.recarregavel:SetRechargeTime(TUNING.FORGE_ITEM_PACK.TFWP_LAVA_HAMMER.COOLDOWN)
f:AddComponent("weapon")
f.components.weapon:SetDamage(TUNING.FORGE_ITEM_PACK.TFWP_LAVA_HAMMER.DAMAGE)
f.components.weapon:SetOnAttack(q)f.components.weapon:SetDamageType(DAMAGETYPES.PHYSICAL)
f.components.weapon:SetAltAttack(TUNING.FORGE_ITEM_PACK.TFWP_LAVA_HAMMER.ALT_DAMAGE,TUNING.FORGE_ITEM_PACK.TFWP_LAVA_HAMMER.ALT_RADIUS,nil,DAMAGETYPES.PHYSICAL)return f end;

local function w()
local f=CreateEntity()
f.entity:AddTransform()
f.entity:AddAnimState()
f.entity:AddSoundEmitter()
f.entity:AddNetwork()
f.AnimState:SetBank("lavaarena_hammer_attack_fx")
f.AnimState:SetBuild("lavaarena_hammer_attack_fx")
f.AnimState:PlayAnimation("crackle_hit")
f.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
f.AnimState:SetFinalOffset(1)f:AddTag("FX")f:AddTag("NOCLICK")
f.entity:SetPristine()if not TheWorld.ismastersim then return f end;
f.SetTarget=function(f,s)
f.Transform:SetPosition(s:GetPosition():Get())
f.SoundEmitter:PlaySound("dontstarve/impacts/lava_arena/hammer")
SpawnPrefab("forginghammer_cracklebase_fx"):SetTarget(f)end;
f:ListenForEvent("animover",f.Remove)return f end;

local function x()
local f=CreateEntity()
f.entity:AddTransform()
f.entity:AddAnimState()
f.entity:AddNetwork()
f.AnimState:SetBank("lavaarena_hammer_attack_fx")
f.AnimState:SetBuild("lavaarena_hammer_attack_fx")
f.AnimState:PlayAnimation("crackle_projection")
f.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
f.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
f.AnimState:SetLayer(LAYER_BACKGROUND)
f.AnimState:SetSortOrder(3)
f.AnimState:SetScale(1.5,1.5)
f:AddTag("FX")
f:AddTag("NOCLICK")

f.entity:SetPristine()if not TheWorld.ismastersim then return f end;

f.SetTarget=function(f,s)
f.Transform:SetPosition(s:GetPosition():Get())end;
f:ListenForEvent("animover",f.Remove)return f end;

local function y()
local f=CreateEntity()
f.entity:AddTransform()
f.entity:AddAnimState()
f.entity:AddSoundEmitter()
f.entity:AddNetwork()
f.AnimState:SetBank("lavaarena_hammer_attack_fx")
f.AnimState:SetBuild("lavaarena_hammer_attack_fx")
f.AnimState:PlayAnimation("crackle_loop")
f.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
f.AnimState:SetFinalOffset(1)
f.AnimState:SetScale(1.5,1.5)
f:AddTag("FX")f:AddTag("NOCLICK")

f.entity:SetPristine()if not TheWorld.ismastersim then return f end;

f.SetTarget=function(f,s,z)
f.Transform:SetPosition(s:GetPosition():Get())
if z then f.SoundEmitter:PlaySound("dontstarve/impacts/lava_arena/electric")end;
if s:HasTag("largecreature")or s:HasTag("epic")then f.AnimState:SetScale(2,2)end end;
f:ListenForEvent("animover",f.Remove)return f end;
return 
CustomPrefab("tfwp_lava_hammer",t,a,c,nil,"images/inventoryimages.xml","hammer_mjolnir.tex",TUNING.FORGE_ITEM_PACK.TFWP_LAVA_HAMMER,"swap_hammer_mjolnir","common_hand"),
Prefab("forginghammer_crackle_fx",w,b,d),
Prefab("forginghammer_cracklebase_fx",x,b),
Prefab("forgeelectricute_fx",y,b)