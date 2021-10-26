local a={
Asset("ANIM","anim/healingstaff.zip"),
Asset("ANIM","anim/swap_healingstaff.zip")}
local b={
"forge_blossom_projectile",
"forge_blossom_hit_fx",
"lavaarena_healblooms",
"reticuleaoe",
"reticuleaoeping",
"reticuleaoefriendlytarget"
}
local c=4*FRAMES;
local function d(e,f)
f.AnimState:OverrideSymbol("swap_object","swap_healingstaff","swap_healingstaff")
f.AnimState:Show("ARM_carry")
f.AnimState:Hide("ARM_normal")end;
local function g(e,f)
f.AnimState:Hide("ARM_carry")
f.AnimState:Show("ARM_normal")end;
local function h()local i=ThePlayer;
local j=TheWorld.Map;
local k=Vector3()for l=6,0,-.25 do k.x,k.y,k.z=i.entity:LocalToWorldSpace(l,0,0)if j:IsPassableAtPoint(k:Get())and not j:IsGroundTargetBlocked(k)then return k end end;
return k end;
local function m(e,n,k)e:DoTaskInTime(0.9,function()local o=e.heal_rate;
local p=false;
if n.components.buffable then o=(o+n.components.buffable:GetBuffData("spell_heal_rate"))*(n.components.buffable:GetBuffData("heal_dealt_mult")+1)p=o>e.heal_rate end;
local q=SpawnAt("healingcircle",k)local r=q.components.heal_aura;
r.heal_rate=o;
r.caster=n;
q.buffed=p;
e.components.recarregavel:StartRecharge()TheWorld:PushEvent("healingcircle_spawned")e.components.aoespell:OnSpellCast(n)end)end;
local function s(e,t,u)e.SoundEmitter:PlaySound("dontstarve/common/lava_arena/heal_staff")local v=(u:GetPosition()-t:GetPosition()):GetNormalized()*1.2;
local w=SpawnPrefab("forge_blossom_hit_fx")w.Transform:SetPosition((t:GetPosition()+v):Get())w.AnimState:SetScale(0.8,0.8)end;
local function x()
local e=CreateEntity()
e.entity:AddTransform()
e.entity:AddAnimState()
e.entity:AddSoundEmitter()
e.entity:AddNetwork()MakeInventoryPhysics(e)
e.nameoverride="healingstaff"
e.AnimState:SetBank("healingstaff")
e.AnimState:SetBuild("healingstaff")
e.AnimState:PlayAnimation("idle")
e:AddTag("magicweapon")
e:AddTag("rechargeable")
e:AddTag("rangedweapon")
e:AddComponent("aoetargeting")
e.components.aoetargeting.reticule.reticuleprefab="reticuleaoe"
e.components.aoetargeting.reticule.pingprefab="reticuleaoeping"
e.components.aoetargeting.reticule.targetfn=h;
e.components.aoetargeting.reticule.validcolour={0,1,.5,1}
e.components.aoetargeting.reticule.invalidcolour={0,.4,0,1}
e.components.aoetargeting.reticule.ease=true;
e.components.aoetargeting.reticule.mouseenabled=true;
e.projectiledelay=c;

e.entity:SetPristine()
if not TheWorld.ismastersim then return e 
end;

e.castsound="dontstarve/common/lava_arena/spell/heal"
e.heal_rate=TUNING.FORGE_ITEM_PACK.TFWP_HEALING_STAFF.HEAL_RATE;
e:AddComponent("reticule_spawner")
e.components.reticule_spawner:Setup(unpack(TUNING.FORGE_ITEM_PACK.RET_DATA.tfwp_healing_staff))
e:AddComponent("aoespell")
e.components.aoespell:SetAOESpell(m)
e.components.aoespell:SetSpellType("heal")
e:AddComponent("equippable")
e.components.equippable:SetOnEquip(d)
e.components.equippable:SetOnUnequip(g)
e:AddComponent("inspectable")
e:AddComponent("inventoryitem")
e.components.inventoryitem.imagename="healingstaff"
e:AddComponent("recarregavel")
e.components.recarregavel:SetRechargeTime(TUNING.FORGE_ITEM_PACK.TFWP_HEALING_STAFF.COOLDOWN)
e:AddComponent("weapon")
e.components.weapon:SetDamage(TUNING.FORGE_ITEM_PACK.TFWP_HEALING_STAFF.DAMAGE)
e.components.weapon:SetRange(10,20)
e.components.weapon:SetProjectile("forge_blossom_projectile")
e.components.weapon:SetDamageType(DAMAGETYPES.MAGIC)
e.components.weapon:SetOnProjectileLaunch(s)
return e end;

return CustomPrefab("tfwp_healing_staff",x,a,b,nil,"images/inventoryimages.xml","healingstaff.tex",TUNING.FORGE_ITEM_PACK.TFWP_HEALING_STAFF,"swap_healingstaff","common_hand")