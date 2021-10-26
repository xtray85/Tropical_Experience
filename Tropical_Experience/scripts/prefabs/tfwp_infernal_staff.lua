local a={
Asset("ANIM","anim/fireballstaff.zip"),
Asset("ANIM","anim/swap_fireballstaff.zip")}
local b={"forge_fireball_projectile","forge_fireball_hit_fx","infernalstaff_meteor","reticuleaoe","reticuleaoeping","reticuleaoehostiletarget"}
local c=4*FRAMES;
local function d(e,f)
f.AnimState:OverrideSymbol("swap_object","swap_fireballstaff","swap_fireballstaff")
f.AnimState:Show("ARM_carry")
f.AnimState:Hide("ARM_normal")end;
local function g(e,f)f.AnimState:Hide("ARM_carry")
f.AnimState:Show("ARM_normal")end;
local function h()
local i=ThePlayer;
local j=TheWorld.Map;local k=Vector3()for l=7,0,-.25 do k.x,k.y,k.z=i.entity:LocalToWorldSpace(l,0,0)
if j:IsPassableAtPoint(k:Get())and not j:IsGroundTargetBlocked(k)then return k end end;
return k end;

local function m(e,n,k)
SpawnPrefab("infernalstaff_meteor"):AttackArea(n,e,k)
e.components.recarregavel:StartRecharge()end;
local function o(e,p,q)
local r=(q:GetPosition()-p:GetPosition()):GetNormalized()*1.2;
local s=SpawnPrefab("forge_fireball_hit_fx")
s.Transform:SetPosition((p:GetPosition()+r):Get())
s.AnimState:SetScale(0.8,0.8)end;
local function t(e,p,q)local u=e.meteor:GetPosition()
local v=TUNING.FORGE_ITEM_PACK.TFWP_INFERNAL_STAFF.ALT_DAMAGE.base;
local w=TUNING.FORGE_ITEM_PACK.TFWP_INFERNAL_STAFF.ALT_DAMAGE.center_mult;
local x=16;local y=distsq(u,q:GetPosition())local z=math.max(0,1-y/x)
local A=v*(1+Lerp(0,w,z))return A end;
local function B(e,p,q)
if e.components.weapon.isaltattacking then SpawnPrefab("infernalstaff_meteor_splashhit"):SetTarget(q)end end;
local function C()
local e=CreateEntity()
e.entity:AddTransform()
e.entity:AddAnimState()
e.entity:AddSoundEmitter()
e.entity:AddNetwork()
MakeInventoryPhysics(e)
e.nameoverride="fireballstaff"
e.AnimState:SetBank("fireballstaff")
e.AnimState:SetBuild("fireballstaff")
e.AnimState:PlayAnimation("idle")
e:AddTag("firestaff")
e:AddTag("magicweapon")
e:AddTag("pyroweapon")
e:AddTag("rangedweapon")
e:AddTag("rechargeable")
e:AddComponent("aoetargeting")
e.components.aoetargeting.reticule.reticuleprefab="reticuleaoe"
e.components.aoetargeting.reticule.pingprefab="reticuleaoeping"
e.components.aoetargeting.reticule.targetfn=h;
e.components.aoetargeting.reticule.validcolour={1,.75,0,1}
e.components.aoetargeting.reticule.invalidcolour={.5,0,0,1}
e.components.aoetargeting.reticule.ease=true;
e.components.aoetargeting.reticule.mouseenabled=true;
e.projectiledelay=c;e.entity:SetPristine()
if not TheWorld.ismastersim then return e end;
e.IsWorkableAllowed=function(self,D,E)return D==ACTIONS.CHOP or D==ACTIONS.DIG and E:HasTag("stump")or D==ACTIONS.MINE end;
e.castsound="dontstarve/common/lava_arena/spell/meteor"
e:AddComponent("aoespell")
e.components.aoespell:SetAOESpell(m)
e.components.aoespell:SetSpellType("damage")
e:AddComponent("equippable")
e.components.equippable:SetOnEquip(d)
e.components.equippable:SetOnUnequip(g)
e:AddComponent("inspectable")
e:AddComponent("inventoryitem")
e.components.inventoryitem.imagename="fireballstaff"
e:AddComponent("recarregavel")
e.components.recarregavel:SetRechargeTime(TUNING.FORGE_ITEM_PACK.TFWP_INFERNAL_STAFF.COOLDOWN)
e:AddComponent("reticule_spawner")
e.components.reticule_spawner:Setup(unpack(TUNING.FORGE_ITEM_PACK.RET_DATA.tfwp_infernal_staff))
e:AddComponent("weapon")
e.components.weapon:SetDamage(TUNING.FORGE_ITEM_PACK.TFWP_INFERNAL_STAFF.DAMAGE)
e.components.weapon:SetOnAttack(B)
e.components.weapon:SetRange(10,20)
e.components.weapon:SetProjectile("forge_fireball_projectile")
e.components.weapon:SetOnProjectileLaunch(o)
e.components.weapon:SetDamageType(DAMAGETYPES.MAGIC)
e.components.weapon:SetStimuli("fire")
e.components.weapon:SetAltAttack(TUNING.FORGE_ITEM_PACK.TFWP_INFERNAL_STAFF.ALT_DAMAGE.minimum,{10,20},nil,DAMAGETYPES.MAGIC,t)
return e end;
return 
CustomPrefab("tfwp_infernal_staff",C,a,b,nil,"images/inventoryimages.xml","fireballstaff.tex",TUNING.FORGE_ITEM_PACK.TFWP_INFERNAL_STAFF,"swap_fireballstaff","common_hand")