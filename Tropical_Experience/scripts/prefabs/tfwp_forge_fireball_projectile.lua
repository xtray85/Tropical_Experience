local a={Asset("ANIM","anim/fireball_2_fx.zip"),Asset("ANIM","anim/deer_fire_charge.zip")}local b={Asset("ANIM","anim/lavaarena_heal_projectile.zip")}local function c(d,e,f)local g=SpawnPrefab("forge_fireball_hit_fx").Transform:SetPosition(d.Transform:GetWorldPosition())d:Remove()g:ListenForEvent("animover",g.Remove)end;
local function h(d,e,f)local g=SpawnPrefab("fireball_cast_fx").Transform:SetPosition(d.Transform:GetWorldPosition())g:ListenForEvent("animover",g.Remove)end;
local function i(j,k,l,m,n)local d=CreateEntity()d:AddTag("FX")d:AddTag("NOCLICK")d.entity:SetCanSleep(false)d.persists=false;
d.entity:AddTransform()d.entity:AddAnimState()MakeInventoryPhysics(d)d.Physics:ClearCollisionMask()d.AnimState:SetBank(j)d.AnimState:SetBuild(k)d.AnimState:PlayAnimation("disappear")if m~=nil then d.AnimState:SetAddColour(unpack(m))end;
if n~=nil then d.AnimState:SetMultColour(unpack(n))end;
if l>0 then d.AnimState:SetLightOverride(l)end;
d.AnimState:SetFinalOffset(-1)d:ListenForEvent("animover",d.Remove)d.OnLoad=d.Remove;
return d end;
local function o(d,j,k,p,l,m,n,q,r)local s,t,u=d.Transform:GetWorldPosition()for v,w in pairs(r)do v:ForceFacePoint(s,t,u)end;
if d.entity:IsVisible()then local v=i(j,k,l,m,n)local x=d.Transform:GetRotation()v.Transform:SetRotation(x)x=x*DEGREES;
local y=math.random()*2*PI;
local z=math.random()*.2+.2;
local A=math.cos(y)*z;
local B=math.sin(y)*z;
v.Transform:SetPosition(s+math.sin(x)*A,t+B,u+math.cos(x)*A)v.Physics:SetMotorVel(p*(.2+math.random()*.3),0,0)r[v]=true;
d:ListenForEvent("onremove",function(v)r[v]=nil end,v)v:ListenForEvent("onremove",function(d)v.Transform:SetRotation(v.Transform:GetRotation()+math.random()*30-15)end,d)end end;
local function C(D,j,k,p,l,m,n,q)local E={Asset("ANIM","anim/"..k..".zip")}local F=q~=nil and{q}or nil;
local function G()local d=CreateEntity()d.entity:AddTransform()d.entity:AddAnimState()d.entity:AddNetwork()MakeInventoryPhysics(d)RemovePhysicsColliders(d)d.AnimState:SetBank(j)d.AnimState:SetBuild(k)d.AnimState:PlayAnimation("idle_loop",true)if m~=nil then d.AnimState:SetAddColour(unpack(m))end;
if n~=nil then d.AnimState:SetMultColour(unpack(n))end;
if l>0 then d.AnimState:SetLightOverride(l)end;
d.AnimState:SetFinalOffset(-1)d:AddTag("projectile")if not TheNet:IsDedicated()then d:DoPeriodicTask(0,o,nil,j,k,p,l,m,n,q,{})end;
d.entity:SetPristine()if not TheWorld.ismastersim then return d end;
d.persists=false;
d:AddComponent("projectile")d.components.projectile:SetSpeed(p)d.components.projectile:SetHoming(true)d.components.projectile:SetHitDist(0.5)d.components.projectile.onhit=function(d,e,f)SpawnPrefab(q).Transform:SetPosition(d.Transform:GetWorldPosition())d:Remove()end;
d.components.projectile:SetOnMissFn(d.Remove)d.components.projectile:SetStimuli("fire")d.OnLoad=d.Remove;
return d end;
return Prefab(D,G,E,F)end;
local function H()local d=CreateEntity()d.entity:AddTransform()d.entity:AddAnimState()d.entity:AddSoundEmitter()d.entity:AddNetwork()d.AnimState:SetBank("fireball_fx")d.AnimState:SetBuild("deer_fire_charge")d.AnimState:PlayAnimation("blast")d.AnimState:SetBloomEffectHandle("shaders/anim.ksh")d.AnimState:SetLightOverride(1)d.AnimState:SetFinalOffset(-1)d:AddTag("FX")d:AddTag("NOCLICK")d.entity:SetPristine()d.persists=false;
d:ListenForEvent("animover",d.Remove)d.OnLoad=d.Remove;
return d end;
local function I()local d=CreateEntity()d.entity:AddTransform()d.entity:AddAnimState()d.entity:AddSoundEmitter()d.entity:AddNetwork()d.AnimState:SetBank("lavaarena_heal_projectile")d.AnimState:SetBuild("lavaarena_heal_projectile")d.AnimState:PlayAnimation("hit")d.AnimState:SetAddColour(0,.1,.05,0)d.AnimState:SetFinalOffset(-1)d:AddTag("FX")d:AddTag("NOCLICK")d.entity:SetPristine()d.persists=false;
d:ListenForEvent("animover",d.Remove)d.OnLoad=d.Remove;
return d end;
return C("forge_fireball_projectile","fireball_fx","fireball_2_fx",15,1,nil,nil,"forge_fireball_hit_fx"),C("forge_blossom_projectile","lavaarena_heal_projectile","lavaarena_heal_projectile",15,0,{0,.2,.1,0},nil,"forge_blossom_hit_fx"),
Prefab("forge_fireball_hit_fx",H,a),
Prefab("forge_blossom_hit_fx",I,b),C("forge_fireball_projectile_fast","fireball_fx","fireball_2_fx",30,1,nil,nil,"forge_fireball_hit_fx")