local _, classToken = UnitClass("player")
if classToken ~= "MAGE" then return end

MACROS_BY_CLASS_MAGE = {
    { "智力", 134400, "#showtooltip\n/cast [target=mouseover,exists]奥术智慧;奥术智慧", nil, true },
    { "盾", 134400, "#showtooltip\n/castsequence reset=30 寒冰护体,法力护盾", nil, true },
    { "AA", 134400, "#showtooltip\n/cast [mod:ctrl]烈焰风暴;暴风雪", nil, true },
    { "冰锥", 134400, "#showtooltip 冰锥术\n/stopattack\n/cast 冰锥术\n/run MouselookStart() MouselookStop()", nil, true },
}

MACRO_PLACEMENT_MAGE = {
    ["智力"] = { 2, 4 },
    ["盾"]   = { 1, 10 },
    ["AA"]   = { 1, 5 },
    ["冰锥"] = { 1, 8 },
}

SPELLS_BY_CLASS_MAGE = {
    { "奥术飞弹", 1, 1 },
    { "奥术爆炸", 1, 1 },
    { "变形术", 1, 1 },
    { "法术反制", 1, 8 },
    { "闪现术", 1, 7 },
    { "缓落术", 1, 1 },
    { "魔法抑制", 1, 1 },
    { "魔法增效", 1, 1 },
    { "奥术光辉", 1, 1 },
    { "造水术", 2, 12 },
    { "造食术", 2, 11 },
    { "制造法力宝石", 1, 1 },
    { "法师护甲", 1, 1 },
    { "唤醒", 1, 1 },
    { "火球术", 1, 1 },
    { "火焰冲击", 1, 4 },
    { "炎爆术", 1, 1 },
    { "灼烧", 1, 1 },
    { "冲击波", 1, 1 },
    { "燃烧", 1, 1 },
    { "寒冰箭", 1, 2 },
    { "冰霜新星", 1, 3 },
    { "冰甲术", 0, 10 },
    { "霜甲术", 1, 9 },
    { "寒冰屏障", 1, 12 },
}
