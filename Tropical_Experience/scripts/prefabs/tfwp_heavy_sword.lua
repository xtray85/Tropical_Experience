local a={Asset("ANIM","anim/sword_buster.zip"),
Asset("ANIM","anim/swap_sword_buster.zip")}
local b={
"weaponsparks_fx",
"sunderarmordebuff",
"superjump_fx",
"reticulearc",
"reticulearcping"}

local function c()return Vector3(ThePlayer.entity:LocalToWorldSpace(6.5,0,0))end;

local function d(e,f)if f~=nil then local g,h,i=e.Transform:GetWorldPosition()

local j=f.x-g;local k=f.z-i;

local l=j*j+k*k;if l<=0 then return e.components.reticule.targetpos end;

l=6.5/math.sqrt(l)return Vector3(g+j*l,0,i+k*l)end end;
local function m(e,n,o,p,q,r)local g,h,i=e.Transform:GetWorldPosition()o.Transform:SetPosition(g,0,i)
local s=-math.atan2(n.z-i,n.x-g)/DEGREES;if p and r~=nil then 
local t=o.Transform:GetRotation()
local u=s-t;s=Lerp(u>180 and t+360 or u<-180 and t-360 or t,s,r*q)end;o.Transform:SetRotation(s)end;
local function v(e,w)w.AnimState:OverrideSymbol("swap_object","swap_sword_buster","swap_sword_buster")w.AnimState:Show("ARM_carry")w.AnimState:Hide("ARM_normal")end;
local function x(e,w)w.AnimState:Hide("ARM_carry")w.AnimState:Show("ARM_normal")end;
local function y(e,z,A)SpawnPrefab("weaponsparks_fx"):SetPosition(z,A)if A and A.components.combat and z then A.components.combat:SetTarget(z)end end;
local function B(e,C,n)C:PushEvent("combat_parry",{direction=e:GetAngleToPoint(n),duration=e.components.parryweapon.duration,weapon=e})end;
local function D(e,C)e.components.recarregavel:StartRecharge()end;local function E(e)SpawnPrefab("superjump_fx"):SetTarget(e)end;
local function F()
local e=CreateEntity()
e.entity:AddTransform()
e.entity:AddAnimState()
e.entity:AddNetwork()
MakeInventoryPhysics(e)
e.nameoverride="lavaarena_heavyblade"
e.AnimState:SetBank("sword_buster")
e.AnimState:SetBuild("sword_buster")
e.AnimState:PlayAnimation("idle")
e:AddTag("parryweapon")
e:AddTag("rechargeable")
e:AddComponent("aoetargeting")
e.components.aoetargeting:SetAlwaysValid(true)
e.components.aoetargeting.reticule.reticuleprefab="reticulearc"
e.components.aoetargeting.reticule.pingprefab="reticulearcping"
e.components.aoetargeting.reticule.targetfn=c;
e.components.aoetargeting.reticule.mousetargetfn=d;
e.components.aoetargeting.reticule.updatepositionfn=m;
e.components.aoetargeting.reticule.validcolour={1,.75,0,1}
e.components.aoetargeting.reticule.invalidcolour={.5,0,0,1}
e.components.aoetargeting.reticule.ease=true;
e.components.aoetargeting.reticule.mouseenabled=true;
e.entity:SetPristine()

if not TheWorld.ismastersim then return e end;

e:AddComponent("aoespell")
e.components.aoespell:SetAOESpell(B)
e:AddComponent("equippable")
e.components.equippable:SetOnEquip(v)
e.components.equippable:SetOnUnequip(x)
e:AddComponent("helmsplitter")
e.components.helmsplitter:SetOnHelmSplitFn(E)
e.components.helmsplitter.damage=TUNING.FORGE_ITEM_PACK.TFWP_HEAVY_SWORD.HELMSPLIT_DAMAGE;
e:AddComponent("inspectable")
e:AddComponent("inventoryitem")
e.components.inventoryitem.imagename="lavaarena_heavyblade"
--e.components.inventoryitem.atlasname = "images/tfwp_inventoryimgs.xml"
e:AddComponent("parryweapon")
e.components.parryweapon.duration=TUNING.FORGE_ITEM_PACK.TFWP_HEAVY_SWORD.PARRY_DURATION;
e.components.parryweapon:SetOnParryStartFn(D)
e:AddComponent("recarregavel")
e.components.recarregavel:SetRechargeTime(TUNING.FORGE_ITEM_PACK.TFWP_HEAVY_SWORD.COOLDOWN/20)
e:AddComponent("reticule_spawner")
e.components.reticule_spawner:Setup(unpack(TUNING.FORGE_ITEM_PACK.RET_DATA.tfwp_heavy_sword))
e:AddComponent("weapon")
e.components.weapon:SetDamage(TUNING.FORGE_ITEM_PACK.TFWP_HEAVY_SWORD.DAMAGE)
e.components.weapon:SetDamageType(DAMAGETYPES.PHYSICAL)

--e:AddComponent("finiteuses")
--e.components.finiteuses:SetMaxUses(TUNING.TFWP_HEAVY_SWORD.USES)
--e.components.finiteuses:SetUses(TUNING.TFWP_HEAVY_SWORD.USES)
--e.components.finiteuses:SetOnFinished(e.Remove)
return e end;

return CustomPrefab("tfwp_heavy_sword",F,a,b,nil,"images/inventoryimages.xml","lavaarena_heavyblade.tex",TUNING.FORGE_ITEM_PACK.TFWP_HEAVY_SWORD,"swap_sword_buster","common_hand")