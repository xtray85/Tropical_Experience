local STRINGS = GLOBAL.STRINGS

GLOBAL.STRINGS.NAMES.MOD_CLEANER = "Magic Duct Tape"
GLOBAL.STRINGS.RECIPE_DESC.MOD_CLEANER = "Remove enchantment, and maybe item too!"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.MOD_CLEANER = "Может снять зачарование, но есть маленький шанс сломать предмет!"

GLOBAL.STRINGS.ACTIONS.MOD_CLEAN = "Disenchant"
GLOBAL.STRINGS.ACTIONS.MOD_DISASSEMBLE = "Disassemble"

STRINGS.MODIFIER_RARITIES = {
    WORST = "Наихудший",
    BAD = "Плохой",
    GOOD = "Хороший",
    RARE = "Редкий",
    EPIC = "Эпический",
    LEGENDARY = "Легендарный",
    MYTHIC = "Мифический",
    TEST = "???",
}

STRINGS.MODIFIERS = {}
STRINGS.MODIFIERS.GENERIC = {
    PREFIX = "Modified",
    DESC = "Unknown Modifier",
}

STRINGS.MODIFIERS.SANITYSONG = {
	PREFIX = "Song of Dapperness",
	DESC = "Когда услышите, что ближайшие игроки получат бафф восстановления рассудка на короткое время.",
}

STRINGS.MODIFIERS.REVIVALSONG = {
	PREFIX = "Song of Reanimation",
	DESC = "Когда услышите, что ближайшие призрачные игроки воскреснут из мертвых.",
}

STRINGS.MODIFIERS.REGENSONG = {
	PREFIX = "Song of Regeneration",
	DESC = "Когда услышите, игроки получат бафф восстановления здоровья на короткое время.",
}

STRINGS.MODIFIERS.TAUNTSONG = {
	PREFIX = "Song of Irritation",
	DESC = "Когда вас услышат, ближайшие враги станут раздраженными и агрессивными.",
}

STRINGS.MODIFIERS.TELESENSITIVE = {
	PREFIX = "Telepoofing",
	DESC = "Полученный урон имеет шанс случайным образом телепортировать носящего куда-нибудь поблизости.",
}

STRINGS.MODIFIERS.SOULBOUND = {
	PREFIX = "Loyal",
	DESC = "Предмет привязан к пользователю, при получении он будет автоматически экипирован, но не может быть экипирован. Хранится при смерти (если есть)",
}

STRINGS.MODIFIERS.TOUGHNESS_1 = {
	PREFIX = "Steady",
	DESC = "-25% Долговечность использования.",
}

STRINGS.MODIFIERS.RESISTANCE_X = {
	PREFIX = "Untouchable",
	DESC = "100% снижение урона.",
}

STRINGS.MODIFIERS.RESISTANCE_1 = {
	PREFIX = "Resistant",
	DESC = "+ 10% снижения урона.",
}

STRINGS.MODIFIERS.TOUGHNESS_2 = {
	PREFIX = "Sturdy",
	DESC = "-50% Долговечность использования.",
}

STRINGS.MODIFIERS.WEAKNESS_2 = {
	PREFIX = "Fragile",
	DESC = "+ 50% Прочность использования.",
}

STRINGS.MODIFIERS.ICEY_THORNS = {
	PREFIX = "Freezing",
	DESC = "Полученный урон имеет шанс охладить атакующего (в любом случае не влияет на носящего)",
}

STRINGS.MODIFIERS.FIERY_THORNS = {
	PREFIX = "Flaming",
	DESC = "Полученный урон может сжечь атакующего (в любом случае не действует на носящего)",
}

STRINGS.MODIFIERS.TOUGHNESS_X = {
	PREFIX = "Unbreakable",
	DESC = "Бесконечная долговечность",
}

STRINGS.MODIFIERS.WEAKNESS_1 = {
	PREFIX = "Weak",
	DESC = "+ 25% Прочность использования.",
}

STRINGS.MODIFIERS.RESISTANCE_2 = {
	PREFIX = "Protective",
	DESC = "+25% Damage reduction.",
}

STRINGS.MODIFIERS.THORNS = {
	PREFIX = "Thorny",
	DESC = "+ 25% снижения урона.",
}

STRINGS.MODIFIERS.STURDY_1 = {
	PREFIX = "Steady",
	DESC = "-25% Долговечность использования.",
}

STRINGS.MODIFIERS.FRAGILE_1 = {
	PREFIX = "Weak",
	DESC = "+ 25% Прочность использования.",
}

STRINGS.MODIFIERS.RESOURCELUST = {
	PREFIX = "Resource-hungry",
	DESC = "Разрушение имеет шанс немного отремонтировать инструмент в зависимости от серии разрушения.",
}

STRINGS.MODIFIERS.BLOODLUST = {
	PREFIX = "Vampiric",
	DESC = "Нанесенный урон может немного отремонтировать оружие в зависимости от серии убийств.",
}

STRINGS.MODIFIERS.STURDY_X = {
	PREFIX = "Unbreakable",
	DESC = "Бесконечная прочность.",
}

STRINGS.MODIFIERS.FRAGILE_2 = {
	PREFIX = "Fragile",
	DESC = "+ 50% Прочность использования.",
}

STRINGS.MODIFIERS.STURDY_2 = {
	PREFIX = "Sturdy",
	DESC = "- 50% Прочность использования.",
}

STRINGS.MODIFIERS.SHARPNESS_3 = {
	PREFIX = "Razor-sharp",
	DESC = "+75% Damage dealt.",
}

STRINGS.MODIFIERS.SHARPNESS_1 = {
	PREFIX = "Pointy",
	DESC = "+10% Damage dealt.",
}

STRINGS.MODIFIERS.DULNESS_1 = {
	PREFIX = "Dull",
	DESC = "-10% Damage dealt.",
}

STRINGS.MODIFIERS.TELECOWARD = {
	PREFIX = "Telepoofing",
	DESC = "Нанесенный урон имеет шанс случайным образом телепортировать носящего куда-нибудь поблизости.",
}

STRINGS.MODIFIERS.DULNESS_2 = {
	PREFIX = "Blunt",
	DESC = "-30% Damage dealt.",
}

STRINGS.MODIFIERS.SHARPNESS_2 = {
	PREFIX = "Sharp",
	DESC = "+25% Damage dealt.",
}

STRINGS.MODIFIERS.GHOSTSTRIKE = {
	PREFIX = "Ghost Strike",
	DESC = "Вместо этого при атаке на цель создается призрак, который атакует за вас (увеличивая ваш диапазон).",
}

STRINGS.MODIFIERS.LIFESTEAL = {
	PREFIX = "Lifestealing",
	DESC = "Нанесенный урон может немного вылечить игрока.",
}

STRINGS.MODIFIERS.ICEY = {
	PREFIX = "Icey",
	DESC = "Нанесенный урон может охладить цель.",
}

STRINGS.MODIFIERS.FIERY = {
	PREFIX = "Fiery",
	DESC = "Нанесенный урон может поджечь цель.",
}

STRINGS.MODIFIERS.EFFICIENCY_1 = {
	PREFIX = "Efficient",
	DESC = "-10% Fuel usage.",
}

STRINGS.MODIFIERS.INEFFICIENCY_1 = {
	PREFIX = "Inefficient",
	DESC = "+10% Fuel usage.",
}

STRINGS.MODIFIERS.SOLAR = {
	PREFIX = "Solar",
	DESC = "Естественный свет медленно заправляет предмет, если он выключен и не переносится",
}

STRINGS.MODIFIERS.INEFFICIENCY_2 = {
	PREFIX = "Impotent",
	DESC = "+25% Fuel usage.",
}

STRINGS.MODIFIERS.EFFICIENCY_2 = {
	PREFIX = "Economical",
	DESC = "-25% Fuel usage.",
}

STRINGS.MODIFIERS.FAST_PROJECTILE = {
	PREFIX = "Speedy",
	DESC = "+50% Projectile Speed."
}

STRINGS.MODIFIERS.SLOW_PROJECTILE = {
	PREFIX = "Sluggish",
	DESC = "-50% Projectile Speed."
}

STRINGS.MODIFIERS.COLLISION_PROJECTILE = {
	PREFIX = "Hurtful",
	DESC = "Во время путешествия к своей цели все, чего он касается, также поражается."
}

STRINGS.MODIFIERS.REPAIRER = {
	PREFIX = "Enchanted",
	DESC = "Все, что вы распыляете, также будет отремонтировано, при этом исключая возможность потери предмета."
}

STRINGS.MODIFIERS.INFINITE = {
	PREFIX = "Everlasting",
	DESC = "Infinite Durability."
}

STRINGS.MODIFIERS.FREEZER = {
	PREFIX = "Chilly",
	DESC = "Все, что находится внутри этого контейнера, погибает медленнее."
}

STRINGS.MODIFIERS.LIGHTWEIGHT = {
	PREFIX = "Lightweight",
	DESC = "С этим предметом ходить легче."
}

STRINGS.MODIFIERS.HEAVYWEIGHT = {
	PREFIX = "Heavyweight",
	DESC = "Ходить с этим предметом сложнее."
}

STRINGS.MODIFIERS.RUSHING = {
	PREFIX = "Rushing",
	DESC = "Нанесенный урон заставит атакующего на короткое время бежать быстрее."
}

STRINGS.MODIFIERS.SLOWING = {
	PREFIX = "Slowing",
	DESC = "При нанесении урона атакующий на короткое время будет медленнее бежать."
}

STRINGS.MODIFIERS.ELECTRIC_THORNS = {
	PREFIX = "Zapping",
	DESC = "При нанесении урона атакующий получит удар молнии и телепортируется прочь. (Только когда присутствует шар)"
}

STRINGS.MODIFIERS.MINDFIZZLER = {
	PREFIX = "Moonwalker's",
	DESC = "Органы управления движением перевернуты."
}

STRINGS.MODIFIERS.FIREPROOF = {
	PREFIX = "Fireproof",
	DESC = "Resistant to fire."
}

STRINGS.MODIFIERS.UNWITHERING = {
	PREFIX = "Unwithering",
	DESC = "Кожа этого рюкзака не гниет."
}

STRINGS.MODIFIERS.WITHERED = {
	PREFIX = "Withered",
	DESC = "Кожа этого рюкзака мгновенно засыхает."
}

STRINGS.MODIFIERS.PRESERVER = {
	PREFIX = "Reallocting",
	DESC = "Зачарования сохраняются на других предметах, если таковые имеются, или на рассеянном предмете. Плохие чары улучшаются."
}

STRINGS.MODIFIERS.MINDASCENDER = {
	PREFIX = "Tinkerer's",
	DESC = "Когда экипирован, владелец может разбирать созданные предметы, чтобы получить большую часть прочности этого предмета."
}

STRINGS.MODIFIERS.MINDTRANSCENDER = {
	PREFIX = "Master Tinkerer's",
	DESC = "Когда экипирован, владелец может разбирать созданные предметы, чтобы получить небольшую часть прочности этого предмета. Чары сохраняются на других предметах, если таковые имеются."
}

STRINGS.MODIFIERS.GODLIKE = {
	PREFIX = "Godlike",
	DESC = "Имеет большинство положительных модификаторов все в 1.",
}