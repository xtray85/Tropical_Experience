local a={
Asset("ANIM","anim/lavaarena_firebomb.zip"),
Asset("ANIM","anim/swap_lavaarena_firebomb.zip")}
local b={
Asset("ANIM","anim/lavaarena_firebomb.zip")}
local c={
Asset("ANIM","anim/sparks_molotov.zip")}
local d={"hearthsfire_crystals_projectile","hearthsfire_crystals_proc_fx","hearthsfire_crystals_sparks","reticuleaoesmall","reticuleaoesmallping","reticuleaoesmallhostiletarget"}
local e={"hearthsfire_crystals_explosion","firehit"}
local function f(g,h)
h.AnimState:OverrideSymbol("swap_object","swap_lavaarena_firebomb","swap_lavaarena_firebomb")
h.AnimState:Show("ARM_carry")
h.AnimState:Hide("ARM_normal")end;
local function i(g,h)h.AnimState:Hide("ARM_carry")
h.AnimState:Show("ARM_normal")end;
local function j()local k=ThePlayer;local l=TheWorld.Map;local m=Vector3()for n=5,0,-.25 do m.x,m.y,m.z=k.entity:LocalToWorldSpace(n,0,0)
if l:IsPassableAtPoint(m:Get())and not l:IsGroundTargetBlocked(m)then return m end end;return m end;
local function o(g,h)
g:AddTag("NOCLICK")
g.persists=false;
g.SoundEmitter:PlaySound("dontstarve/common/blackpowder_fuse_LP","hiss")
g.Physics:SetMass(1)
g.Physics:SetCapsule(0.2,0.2)
g.Physics:SetFriction(0)
g.Physics:SetDamping(0)
g.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
g.Physics:ClearCollisionMask()
g.Physics:CollidesWith(COLLISION.WORLD)
g.Physics:CollidesWith(COLLISION.OBSTACLES)
g.Physics:CollidesWith(COLLISION.ITEMS)end;
local p=TUNING.FORGE_ITEM_PACK.TFWP_FIRE_BOMB.ALT_RANGE;
local function q(g,r,s)
g.SoundEmitter:KillSound("hiss")SpawnPrefab("hearthsfire_crystals_explosion").Transform:SetPosition(g.Transform:GetWorldPosition())
local t={}local u,v,w=g:GetPosition():Get()
local x=TheSim:FindEntities(u,v,w,p,nil,{"player","companion"})for y,z in ipairs(x)do 
if g.attacker~=nil and z~=g.attacker and z.entity:IsValid()and z.entity:IsVisible()and z.components.health and not z.components.health:IsDead()then 
table.insert(t,z)end end;if g.owner.components.weapon then g.owner.components.weapon:DoAltAttack(g.attacker,t,nil,"explosive")end;
g:Remove()end;
local function A(g)g.charge=0;if g.charge_fx then g.charge_fx:Remove()g.charge_fx=nil end;
if g.chargetask then g.chargetask:Cancel()g.chargetask=nil end;
g.SoundEmitter:KillSound("hiss")end;local function B(g,C,m)
local D=SpawnPrefab("hearthsfire_crystals_projectile")
D.Transform:SetPosition(g:GetPosition():Get())D.owner=C;
D.components.complexprojectile:Launch(m,C)D:AttackArea(C,g,m)A(g)g.components.recarregavel:StartRecharge()end;
local function E(g,F)if not g.charge_fx and g.components.inventoryitem.owner then 
g.charge_fx=SpawnPrefab("hearthsfire_crystals_sparks")
g.charge_fx.entity:AddFollower()
g.charge_fx.Follower:FollowSymbol(g.components.inventoryitem.owner.GUID,"swap_object",3,2,0)
g.SoundEmitter:PlaySound("dontstarve/common/blackpowder_fuse_LP","hiss")end;
g.charge_fx.SetSparkLevel(g.charge_fx,F)end;
local function G(g,C,H)local m=H:GetPosition()
local I=SpawnPrefab("hearthsfire_crystals_proc_fx")I.Transform:SetPosition(m:Get())I.owner=g;I.attacker=C;I.target=H;A(g)end;
local function J(g,C,H)if g.components.inventoryitem.owner then 
g.charge=(g.charge or 0)+1;if g.chargetask then 
g.chargetask:Cancel()g.chargetask=nil end;
g.chargetask=g:DoTaskInTime(TUNING.FORGE_ITEM_PACK.TFWP_FIRE_BOMB.CHARGE_DECAY_TIME,A)
if g.charge>=TUNING.FORGE_ITEM_PACK.TFWP_FIRE_BOMB.CHARGE_HITS_1 and g.charge<TUNING.FORGE_ITEM_PACK.TFWP_FIRE_BOMB.CHARGE_HITS_2 then 
E(g,1)elseif g.charge>=TUNING.FORGE_ITEM_PACK.TFWP_FIRE_BOMB.CHARGE_HITS_2 and g.charge<TUNING.FORGE_ITEM_PACK.TFWP_FIRE_BOMB.MAXIMUM_CHARGE_HITS then 
E(g,2)elseif g.charge>=TUNING.FORGE_ITEM_PACK.TFWP_FIRE_BOMB.MAXIMUM_CHARGE_HITS then 
G(g,C,H)end end end;

local function K()
local g=CreateEntity()
g.entity:AddTransform()
g.entity:AddAnimState()
g.entity:AddSoundEmitter()
g.entity:AddNetwork()
MakeInventoryPhysics(g)
g.nameoverride="lavaarena_firebomb"
g.AnimState:SetBank("lavaarena_firebomb")
g.AnimState:SetBuild("lavaarena_firebomb")
g.AnimState:PlayAnimation("idle")
g:AddTag("rechargeable")
g:AddTag("throw_line")
g:AddComponent("aoetargeting")
g.components.aoetargeting:SetRange(TUNING.FORGE_ITEM_PACK.TFWP_FIRE_BOMB.ALT_RANGE)
g.components.aoetargeting.reticule.reticuleprefab="reticuleaoesmall"
g.components.aoetargeting.reticule.pingprefab="reticuleaoesmallping"
g.components.aoetargeting.reticule.targetfn=j;
g.components.aoetargeting.reticule.validcolour={1,.75,0,1}
g.components.aoetargeting.reticule.invalidcolour={.5,0,0,1}
g.components.aoetargeting.reticule.ease=true;g.components.aoetargeting.reticule.mouseenabled=true;
g.entity:SetPristine()
if not TheWorld.ismastersim then return g end;g.IsWorkableAllowed=function(self,L)return L==ACTIONS.MINE end;
g.charge=0;g.charge_level=0;
g:AddComponent("aoespell")
g.components.aoespell:SetAOESpell(B)
g.components.aoespell:SetSpellType("damage")
g:AddComponent("equippable")
g.components.equippable:SetOnEquip(f)
g.components.equippable:SetOnUnequip(i)
g:AddComponent("inspectable")
g:AddComponent("inventoryitem")
g.components.inventoryitem.imagename="lavaarena_firebomb"
g:AddComponent("recarregavel")
g.components.recarregavel:SetRechargeTime(TUNING.FORGE_ITEM_PACK.TFWP_FIRE_BOMB.COOLDOWN)
g:AddComponent("reticule_spawner")
g.components.reticule_spawner:Setup(unpack(TUNING.FORGE_ITEM_PACK.RET_DATA.tfwp_fire_bomb))
g:AddComponent("weapon")
g.components.weapon:SetDamage(TUNING.FORGE_ITEM_PACK.TFWP_FIRE_BOMB.DAMAGE)
g.components.weapon:SetDamageType(DAMAGETYPES.PHYSICAL)g.components.weapon.onattack=J;
g.components.weapon:SetStimuli("fire")g.components.weapon:SetAltAttack(TUNING.FORGE_ITEM_PACK.TFWP_FIRE_BOMB.ALT_DAMAGE,{10,20},nil,DAMAGETYPES.PHYSICAL)g.charge=0;
return g end;
local function M()
local g=CreateEntity()
g:AddTag("FX")g:AddTag("NOCLICK")
g.persists=false;
g.entity:AddTransform()
g.entity:AddAnimState()
g.Transform:SetSixFaced()
g.AnimState:SetBank("lavaarena_firebomb")
g.AnimState:SetBuild("lavaarena_firebomb")
g.AnimState:PlayAnimation("spin_loop",true)
g.AnimState:SetBloomEffectHandle("shaders/anim.ksh")g.OnLoad=g.Remove;
return g end;

local function N(g)g.animent.Transform:SetRotation(g.direction:value())end;
local function O()
local g=CreateEntity()
g.entity:AddTransform()
g.entity:AddPhysics()
g.entity:AddSoundEmitter()
g.entity:AddNetwork()
g.Physics:SetMass(1)
g.Physics:SetFriction(0)
g.Physics:SetDamping(0)
g.Physics:SetRestitution(.5)
g.Physics:SetCollisionGroup(COLLISION.ITEMS)
g.Physics:ClearCollisionMask()
g.Physics:CollidesWith(COLLISION.GROUND)
g.Physics:SetCapsule(.2,.2)
g:AddTag("NOCLICK")
g:AddTag("projectile")
g:AddTag("nopunch")
g.direction=net_float(g.GUID,"lavaarena_firebomb_projectile.direction","directiondirty")
if not TheNet:IsDedicated()then g.animent=M()g.animent.entity:SetParent(g.entity)
if not TheWorld.ismastersim then g:ListenForEvent("directiondirty",N)end end;
g.entity:SetPristine()
if not TheWorld.ismastersim then return g end;
g.AttackArea=function(g,r,P,m)P.firebomb=g;
g.attacker=r;g.owner=P end;
g:AddComponent("complexprojectile")
g.components.complexprojectile:SetHorizontalSpeed(TUNING.FORGE_ITEM_PACK.TFWP_FIRE_BOMB.HORIZONTAL_SPEED)
g.components.complexprojectile:SetGravity(TUNING.FORGE_ITEM_PACK.TFWP_FIRE_BOMB.GRAVITY)
g.components.complexprojectile:SetLaunchOffset(Vector3(.25,1,0))
g.components.complexprojectile:SetOnLaunch(o)
g.components.complexprojectile:SetOnHit(q)return g end;
local function Q(g)g.SoundEmitter:PlaySound("dontstarve/common/blackpowder_explo")
local t={}
local u,v,w=g:GetPosition():Get()
local x=TheSim:FindEntities(u,v,w,0.5,nil,{"player","companion"})
for y,z in ipairs(x)do if g.attacker~=nil and z~=g.attacker and z.entity:IsValid()and z.entity:IsVisible()and z.components.health and not z.components.health:IsDead()then 
table.insert(t,z)end end;
if g.owner.components.weapon then 
g.owner.components.weapon:DoAltAttack(g.attacker,t,nil,"explosive")end end;
local function R()
local g=CreateEntity()
g.entity:AddTransform()
g.entity:AddAnimState()
g.entity:AddSoundEmitter()
g.entity:AddNetwork()
g.AnimState:SetBank("lavaarena_firebomb")
g.AnimState:SetBuild("lavaarena_firebomb")
g.AnimState:PlayAnimation("used")
g.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
g.AnimState:SetLightOverride(1)
g.AnimState:SetFinalOffset(-1)
g:AddTag("FX")g:AddTag("NOCLICK")
g.entity:SetPristine()
if not TheWorld.ismastersim then return g end;

g.persists=false;
g:ListenForEvent("animover",g.Remove)
g.AttackArea=function(g,r,P,m)P.meteor=g;
g.attacker=r;
g.owner=P;
g.Transform:SetPosition(m:Get())end;
g.SoundEmitter:PlaySound("dontstarve/common/blackpowder_explo")return g end;

local function S()
local g=CreateEntity()
g.entity:AddTransform()
g.entity:AddAnimState()
g.entity:AddSoundEmitter()
g.entity:AddNetwork()
g.AnimState:SetBank("lavaarena_firebomb")
g.AnimState:SetBuild("lavaarena_firebomb")
g.AnimState:PlayAnimation("hitfx")
g.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
g.AnimState:SetLightOverride(1)
g.AnimState:SetFinalOffset(-1)
g:AddTag("FX")g:AddTag("NOCLICK")
g.entity:SetPristine()

if not TheWorld.ismastersim then return g end;

g.persists=false;g.AttackOther=function(P,C,s)g.target=s;g.attacker=C end;
g:DoTaskInTime(0,Q)return g end;
local function T(g,F)g.AnimState:PlayAnimation(tostring(math.clamp(F,1,3)),true)end;
local function U()
local g=CreateEntity()
g.entity:AddTransform()
g.entity:AddAnimState()
g.entity:AddNetwork()
g.AnimState:SetBank("sparks_molotov")
g.AnimState:SetBuild("sparks_molotov")
g.AnimState:PlayAnimation("1",true)
g.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
g.AnimState:SetLightOverride(1)
g.AnimState:SetFinalOffset(1)
g:AddTag("FX")
g:AddTag("NOCLICK")

g.entity:SetPristine()
if not TheWorld.ismastersim then return g end;

g.persists=false;
g:ListenForEvent("animover",g.Remove)g.SetSparkLevel=T;return g end;

return 
CustomPrefab("tfwp_fire_bomb",K,a,d,nil,"images/inventoryimages.xml","lavaarena_firebomb.tex",TUNING.FORGE_ITEM_PACK.TFWP_FIRE_BOMB,"swap_lavaarena_firebomb","common_hand"),
Prefab("hearthsfire_crystals_projectile",O,b,e),
Prefab("hearthsfire_crystals_explosion",R,b),
Prefab("hearthsfire_crystals_proc_fx",S,b),
Prefab("hearthsfire_crystals_sparks",U,c)