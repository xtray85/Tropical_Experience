local a={
Asset("ANIM","anim/blowdart_lava.zip"),
Asset("ANIM","anim/swap_blowdart_lava.zip")}

local b={Asset("ANIM","anim/lavaarena_blowdart_attacks.zip")}

local c={"forgedarts_projectile","forgedarts_projectile_alt","reticulelongmulti","reticulelongmultiping"}

local d={"weaponsparks_piercing"}

local e=4*FRAMES;
local function f(g,h)

h.AnimState:OverrideSymbol("swap_object","swap_blowdart_lava","swap_blowdart_lava")
h.AnimState:Show("ARM_carry")
h.AnimState:Hide("ARM_normal")end;local function i(g,h)
h.AnimState:Hide("ARM_carry")h.AnimState:Show("ARM_normal")end;

local function j()return Vector3(ThePlayer.entity:LocalToWorldSpace(6.5,0,0))end;

local function k(g,l)if l~=nil then local m,n,o=g.Transform:GetWorldPosition()
local p=l.x-m;local q=l.z-o;
local r=p*p+q*q;if r<=0 then return g.components.reticule.targetpos end;
r=6.5/math.sqrt(r)return Vector3(m+p*r,0,o+q*r)end end;
local function s(g,t,u,v,w,x)local m,n,o=g.Transform:GetWorldPosition()u.Transform:SetPosition(m,0,o)
local y=-math.atan2(t.z-o,t.x-m)/DEGREES;if v and x~=nil then local z=u.Transform:GetRotation()
local A=y-z;y=Lerp(A>180 and z+360 or A<-180 and z-360 or z,y,x*w)end;u.Transform:SetRotation(y)end;
local function B(g,C,t)for D=1,6 do g:DoTaskInTime(0.08*D,function()
local E=math.random()*2.5-1.25;
local F=Vector3(math.random(),0,math.random()):Normalize()*E;
local G=SpawnPrefab("forgedarts_projectile_alt")
if D==1 then G.components.aimedprojectile:SetStimuli("strong")end;
G.Transform:SetPosition((g:GetPosition()+F):Get())
G.components.aimedprojectile:Throw(g,C,t+F)
G.components.aimedprojectile:DelayVisibility(g.projectiledelay)end)end;
C.SoundEmitter:PlaySound("dontstarve/common/lava_arena/blow_dart_spread")
g.components.recarregavel:StartRecharge()end;
local function H()
local g=CreateEntity()
g.entity:AddTransform()
g.entity:AddAnimState()
g.entity:AddSoundEmitter()
g.entity:AddNetwork()
MakeInventoryPhysics(g)
g.nameoverride="blowdart_lava"
g.AnimState:SetBank("blowdart_lava")
g.AnimState:SetBuild("blowdart_lava")
g.AnimState:PlayAnimation("idle")
g:AddTag("aoeblowdart_long")
g:AddTag("blowdart")
g:AddTag("rechargeable")
g:AddTag("sharp")
g:AddComponent("aoetargeting")
g.components.aoetargeting:SetAlwaysValid(true)
g.components.aoetargeting.reticule.reticuleprefab="reticulelongmulti"
g.components.aoetargeting.reticule.pingprefab="reticulelongmultiping"
g.components.aoetargeting.reticule.targetfn=j;
g.components.aoetargeting.reticule.mousetargetfn=k;
g.components.aoetargeting.reticule.updatepositionfn=s;
g.components.aoetargeting.reticule.validcolour={1,.75,0,1}
g.components.aoetargeting.reticule.invalidcolour={.5,0,0,1}
g.components.aoetargeting.reticule.ease=true;
g.components.aoetargeting.reticule.mouseenabled=true;
g.projectiledelay=e;

g.entity:SetPristine()if not TheWorld.ismastersim then return g end;

g:AddComponent("aoespell")
g.components.aoespell:SetAOESpell(B)
g:AddComponent("equippable")
g.components.equippable:SetOnEquip(f)
g.components.equippable:SetOnUnequip(i)
g:AddComponent("inspectable")
g:AddComponent("inventoryitem")
g.components.inventoryitem.imagename="blowdart_lava"
g:AddComponent("recarregavel")
g.components.recarregavel:SetRechargeTime(TUNING.FORGE_ITEM_PACK.TFWP_LAVA_DART.COOLDOWN)
g:AddComponent("weapon")g.components.weapon:SetDamage(TUNING.FORGE_ITEM_PACK.TFWP_LAVA_DART.DAMAGE)
g.components.weapon:SetRange(10,20)
g.components.weapon:SetProjectile("forgedarts_projectile")
g.components.weapon:SetDamageType(DAMAGETYPES.PHYSICAL)
g.components.weapon:SetAltAttack(TUNING.FORGE_ITEM_PACK.TFWP_LAVA_DART.FORGE_ITEM_PACKDARTS,{10,20},nil,DAMAGETYPES.PHYSICAL)return g end;
local I=5;
local function J()
local g=CreateEntity()
g:AddTag("FX")
g:AddTag("NOCLICK")
g.entity:SetCanSleep(false)
g.persists=false;
g.entity:AddTransform()
g.entity:AddAnimState()
g.AnimState:SetBank("lavaarena_blowdart_attacks")
g.AnimState:SetBuild("lavaarena_blowdart_attacks")
g.AnimState:PlayAnimation("tail_1")
g.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
g:ListenForEvent("animover",g.Remove)
g.OnLoad=g.Remove;return g end;
local function K(g)
local L=not 
g.entity:IsVisible()and 0 or g._fade~=nil and(I-g._fade:value()+1)/I or 1;if L>0 then 
local M=J()M.Transform:SetPosition(g.Transform:GetWorldPosition())M.Transform:SetRotation(g.Transform:GetRotation())if L<1 then 
M.AnimState:SetTime(L*M.AnimState:GetCurrentAnimationLength())end end end;

local function N(g,O,h)
SpawnPrefab("weaponsparks_fx"):SetPiercing(g,O)
g:Remove()end;local function P(g,h)
g:Remove()end;local function Q(R)local 
g=CreateEntity()g.entity:AddTransform()
g.entity:AddAnimState()g.entity:AddSoundEmitter()
g.entity:AddNetwork()
MakeInventoryPhysics(g)
RemovePhysicsColliders(g)
g.AnimState:SetBank("lavaarena_blowdart_attacks")
g.AnimState:SetBuild("lavaarena_blowdart_attacks")
g.AnimState:PlayAnimation("attack_3",true)
g.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
g.AnimState:SetAddColour(1,1,0,0)
g.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
g:AddTag("projectile")if not TheNet:IsDedicated()then 
g:DoPeriodicTask(0,K)end;if R then 
g._fade=net_tinybyte(g.GUID,"blowdart_lava_projectile_alt._fade")end;
g.entity:SetPristine()if not TheWorld.ismastersim then return g end;
if not R then 
g:AddComponent("projectile")
g.components.projectile:SetSpeed(35)
g.components.projectile:SetRange(20)
g.components.projectile:SetHitDist(0.5)
g.components.projectile:SetOnHitFn(function(g,S,O)N(g,O)end)
g.components.projectile:SetOnMissFn(g.Remove)
g.components.projectile:SetLaunchOffset(Vector3(-2,1,0))
else 
g:AddComponent("aimedprojectile")
g.components.aimedprojectile:SetSpeed(35)
g.components.aimedprojectile:SetRange(30)
g.components.aimedprojectile:SetHitDistance(0.5)
g.components.aimedprojectile:SetOnHitFn(function(g,h,S,O)N(g,O,h)end)
g.components.aimedprojectile:SetOnMissFn(P)
g:DoTaskInTime(0,function(g)g.SoundEmitter:PlaySound("dontstarve/common/lava_arena/blow_dart")end)end;
g.OnLoad=g.Remove;return g end;
local function T()return Q(false)end;
local function U()return Q(true)end;
return 
CustomPrefab("tfwp_lava_dart",H,a,c,nil,"images/inventoryimages.xml","blowdart_lava.tex",TUNING.FORGE_ITEM_PACK.TFWP_LAVA_DART,"swap_blowdart_lava","common_hand"),
Prefab("forgedarts_projectile",T,b,d),
Prefab("forgedarts_projectile_alt",U,b,d)