local a={
Asset("ANIM","anim/blowdart_lava2.zip"),
Asset("ANIM","anim/swap_blowdart_lava2.zip")}
local b={Asset("ANIM","anim/lavaarena_blowdart_attacks.zip")}
local c={"moltendarts_projectile","moltendarts_projectile_explosive","reticulelong","reticulelongping"}
local d={"weaponsparks_piercing"}
local e={"explosivehit"}
local f=4*FRAMES;
local function g(h,i)
i.AnimState:OverrideSymbol("swap_object","swap_blowdart_lava2","swap_blowdart_lava2")
i.AnimState:Show("ARM_carry")
i.AnimState:Hide("ARM_normal")end;local function j(h,i)
i.AnimState:Hide("ARM_carry")
i.AnimState:Show("ARM_normal")end;
local function k()return Vector3(ThePlayer.entity:LocalToWorldSpace(6.5,0,0))end;
local function l(h,m)if m~=nil then local n,o,p=h.Transform:GetWorldPosition()
local q=m.x-n;local r=m.z-p;local s=q*q+r*r;if s<=0 then return h.components.reticule.targetpos end;s=6.5/math.sqrt(s)return Vector3(n+q*s,0,p+r*s)end end;
local function t(h,u,v,w,x,y)
local n,o,p=h.Transform:GetWorldPosition()v.Transform:SetPosition(n,0,p)
local z=-math.atan2(u.z-p,u.x-n)/DEGREES;if w and y~=nil then 
local A=v.Transform:GetRotation()
local B=z-A;z=Lerp(B>180 and A+360 or B<-180 and A-360 or A,z,y*x)end;
v.Transform:SetRotation(z)end;
local function C(h,D,u)
local E=SpawnPrefab("moltendarts_projectile_explosive")
E.Transform:SetPosition(h:GetPosition():Get())
E.components.aimedprojectile:Throw(h,D,u)
E.components.aimedprojectile:DelayVisibility(h.projectiledelay)
D.SoundEmitter:PlaySound("dontstarve/common/lava_arena/blow_dart")
h.components.recarregavel:StartRecharge()end;
local function F()
local h=CreateEntity()
h.entity:AddTransform()
h.entity:AddSoundEmitter()
h.entity:AddAnimState()
h.entity:AddNetwork()
MakeInventoryPhysics(h)
h.nameoverride="blowdart_lava2"
h.AnimState:SetBank("blowdart_lava2")
h.AnimState:SetBuild("blowdart_lava2")
h.AnimState:PlayAnimation("idle")
h:AddTag("blowdart")
h:AddTag("rechargeable")
h:AddTag("sharp")
h:AddComponent("aoetargeting")
h.components.aoetargeting:SetAlwaysValid(true)
h.components.aoetargeting.reticule.reticuleprefab="reticulelong"
h.components.aoetargeting.reticule.pingprefab="reticulelongping"
h.components.aoetargeting.reticule.targetfn=k;
h.components.aoetargeting.reticule.mousetargetfn=l;
h.components.aoetargeting.reticule.updatepositionfn=t;
h.components.aoetargeting.reticule.validcolour={1,.75,0,1}
h.components.aoetargeting.reticule.invalidcolour={.5,0,0,1}
h.components.aoetargeting.reticule.ease=true;h.components.aoetargeting.reticule.mouseenabled=true;
h.projectiledelay=f;h.entity:SetPristine()if not TheWorld.ismastersim then return h end;
h:AddComponent("aoespell")
h.components.aoespell:SetAOESpell(C)
h:AddComponent("equippable")
h.components.equippable:SetOnEquip(g)
h.components.equippable:SetOnUnequip(j)
h:AddComponent("inspectable")
h:AddComponent("inventoryitem")
h.components.inventoryitem.imagename="blowdart_lava2"
h:AddComponent("recarregavel")
h.components.recarregavel:SetRechargeTime(TUNING.FORGE_ITEM_PACK.TFWP_DRAGON_DART.COOLDOWN)
h:AddComponent("weapon")
h.components.weapon:SetDamage(TUNING.FORGE_ITEM_PACK.TFWP_DRAGON_DART.DAMAGE)
h.components.weapon:SetRange(10,15)
h.components.weapon:SetProjectile("moltendarts_projectile")
h.components.weapon:SetDamageType(DAMAGETYPES.PHYSICAL)
h.components.weapon:SetAltAttack(TUNING.FORGE_ITEM_PACK.TFWP_DRAGON_DART.ALT_DAMAGE,{10,15},nil,DAMAGETYPES.PHYSICAL)return h end;
local G=5;
local H={["tail_5_2"]=.15,["tail_5_3"]=.15,["tail_5_4"]=.2,["tail_5_5"]=.8,["tail_5_6"]=1,["tail_5_7"]=1}
local I={["tail_5_8"]=1,["tail_5_9"]=.5}
local function J(K,L)
local h=CreateEntity()h:AddTag("FX")h:AddTag("NOCLICK")
h.entity:SetCanSleep(false)
h.persists=false;
h.entity:AddTransform()
h.entity:AddAnimState()
h.AnimState:SetBank("lavaarena_blowdart_attacks")
h.AnimState:SetBuild("lavaarena_blowdart_attacks")
h.AnimState:PlayAnimation(weighted_random_choice(K and I or H)..L)
h.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)if not K then 
h.AnimState:SetAddColour(1,1,0,0)end;h:ListenForEvent("animover",h.Remove)
h.OnLoad=h.Remove;return h end;local function M(h,L)local N=not h.entity:IsVisible()and 0 or h._fade~=nil and(G-h._fade:value()+1)/G or 1;
if N>0 then local O=J(h.thintailcount>0,L)O.Transform:SetPosition(h.Transform:GetWorldPosition())O.Transform:SetRotation(h.Transform:GetRotation())
if N<1 then O.AnimState:SetTime(N*O.AnimState:GetCurrentAnimationLength())end;
if h.thintailcount>0 then h.thintailcount=h.thintailcount-1 end end end;local function P(h,i,Q,R)
if not R then SpawnPrefab("weaponsparks_fx"):SetPiercing(h,Q)else SpawnPrefab("explosivehit").Transform:SetPosition(h:GetPosition():Get())end;
h:Remove()end;local function S(h,i)
h:Remove()end;local function T(U,L,R)
local h=CreateEntity()
h.entity:AddTransform()
h.entity:AddAnimState()
h.entity:AddSoundEmitter()
h.entity:AddNetwork()
MakeInventoryPhysics(h)
RemovePhysicsColliders(h)
h.AnimState:SetBank("lavaarena_blowdart_attacks")
h.AnimState:SetBuild("lavaarena_blowdart_attacks")
h.AnimState:PlayAnimation(U,true)
h.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
h.AnimState:SetAddColour(1,1,0,0)
h.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
h:AddTag("projectile")if not TheNet:IsDedicated()then 
h.thintailcount=R and math.random(3,5)or math.random(2,4)
h:DoPeriodicTask(0,M,nil,L)end;if R then h._fade=net_tinybyte(h.GUID,"blowdart_lava2_projectile_explosive._fade")end;
h.entity:SetPristine()if not TheWorld.ismastersim then return h end;
if not R then h:AddComponent("projectile")
h.components.projectile:SetSpeed(30)
h.components.projectile:SetRange(20)
h.components.projectile:SetOnHitFn(function(h,V,Q)P(h,h.components.projectile.owner,Q,R)end)
h.components.projectile:SetOnMissFn(h.Remove)h.components.projectile:SetLaunchOffset(Vector3(-2,1,0))else 
h:AddComponent("aimedprojectile")
h.components.aimedprojectile:SetSpeed(30)
h.components.aimedprojectile:SetRange(30)
h.components.aimedprojectile:SetStimuli("explosive")
h.components.aimedprojectile:SetOnHitFn(P)
h.components.aimedprojectile:SetOnMissFn(S)
h:DoTaskInTime(0,function(h)
h.SoundEmitter:PlaySound("dontstarve/common/lava_arena/blow_dart")end)end;
h.OnLoad=h.Remove;return h end;local function W()return T("attack_4","",false)end;
local function X()return T("attack_4_large","_large",true)end;
return 
CustomPrefab("tfwp_dragon_dart",F,a,c,nil,"images/inventoryimages.xml","blowdart_lava2.tex",TUNING.FORGE_ITEM_PACK.TFWP_DRAGON_DART,"swap_blowdart_lava2","common_hand"),
Prefab("moltendarts_projectile",W,b,d),Prefab("moltendarts_projectile_explosive",X,b,e)