local a={"lavaarena_fossilizing","reticuleaoe","reticuleaoeping","reticuleaoecctarget"}
local b={"golem","reticuleaoesummon","reticuleaoesummonping","reticuleaoesummontarget"}
local function c()
local d=ThePlayer;
local e=TheWorld.Map;
local f=Vector3()for g=7,0,-.25 do f.x,f.y,f.z=d.entity:LocalToWorldSpace(g,0,0)
if e:IsPassableAtPoint(f:Get())and not e:IsGroundTargetBlocked(f)then return f end end;
return f end;
local h={
fossil=function(i,j,f)if j.components.buffable then 
i.components.fossilizer:SetDuration(TUNING.FORGE_ITEM_PACK.TFWP_CONTROL_BOOK.DURATION*(j.components.buffable:GetBuffData("spell_duration_mult")+1))else 
i.components.fossilizer:SetDuration(TUNING.FORGE_ITEM_PACK.TFWP_CONTROL_BOOK.DURATION)end;
i.components.fossilizer:Fossilize(f,j)
i.components.recarregavel:StartRecharge()
i.components.aoespell:OnSpellCast(j)end,elemental=function(i,j,f)
local k=SpawnPrefab("golem")k.Transform:SetPosition(f:Get())
i.components.recarregavel:StartRecharge()
if j.components.buffable then 
k.components.combat.damagemultiplier=j.components.buffable:GetBuffData("spell_dmg_mult")+1;k.ischarged=k.components.combat.damagemultiplier>1 end;
i.components.aoespell:OnSpellCast(j)end}
local l={fossil="cc",elemental="pet"}
local function m(n,o,p)
local q="book_"..n;
local r={
Asset("ANIM","anim/"..q..".zip"),
Asset("ANIM","anim/swap_"..q..".zip")}

local function s(i,t)
t.AnimState:ClearOverrideSymbol("swap_object")
t.AnimState:OverrideSymbol("book_closed","swap_"..q,"book_closed")end;
local function u()
local i=CreateEntity()
i.entity:AddTransform()
i.entity:AddAnimState()
i.entity:AddSoundEmitter()
i.entity:AddNetwork()
MakeInventoryPhysics(i)
i.nameoverride=q;
i.AnimState:SetBank(q)
i.AnimState:SetBuild(q)
i.AnimState:PlayAnimation(q)
i:AddTag("book")
i:AddTag("rechargeable")
i:AddComponent("aoetargeting")
i.components.aoetargeting.reticule.reticuleprefab=o;
i.components.aoetargeting.reticule.pingprefab=o.."ping"
i.components.aoetargeting.reticule.targetfn=c;
i.components.aoetargeting.reticule.validcolour={1,.75,0,1}
i.components.aoetargeting.reticule.invalidcolour={.5,0,0,1}
i.components.aoetargeting.reticule.ease=true;
i.components.aoetargeting.reticule.mouseenabled=true;
i.entity:SetPristine()if not TheWorld.ismastersim then return i end;
i.castsound="dontstarve/common/lava_arena/spell/fossilized"
i:AddComponent("reticule_spawner")
i.components.reticule_spawner:Setup(unpack(TUNING.FORGE_ITEM_PACK.RET_DATA[n]))
i:AddComponent("aoespell")
i.components.aoespell:SetAOESpell(h[n])
i.components.aoespell:SetSpellType(l[n])
i:AddComponent("equippable")
i.components.equippable:SetOnEquip(s)if n=="fossil"then 
i:AddComponent("fossilizer")end;
i:AddComponent("inspectable")
i:AddComponent("inventoryitem")
i.components.inventoryitem.imagename=q;
i:AddComponent("recarregavel")
i.components.recarregavel:SetRechargeTime(18)
i:AddComponent("weapon")
i.components.weapon:SetDamage(TUNING.FORGE_ITEM_PACK[string.upper(n=="fossil"and"tfwp_control_book"or"tfwp_summon_book")].DAMAGE)
i.components.weapon:SetDamageType(DAMAGETYPES.PHYSICAL)return i end;
return 
CustomPrefab(n=="fossil"and"tfwp_control_book"or"tfwp_summon_book",u,r,p,nil,"images/inventoryimages.xml",q..".tex",TUNING.FORGE_ITEM_PACK[string.upper(n=="fossil"and"tfwp_control_book"or"tfwp_summon_book")])end;
return m("fossil","reticuleaoe",a),
m("elemental","reticuleaoesummon",b)