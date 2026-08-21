local _, classToken = UnitClass("player")
if classToken ~= "WARRIOR" then return end

MACROS_BY_CLASS_WARRIOR = {
    { "冲惩", 1, "#showtooltip\n/cast [nocombat]冲锋;[target=mouseover,combat,harm,exists]惩戒痛击;[combat,harm,exists]惩戒痛击", nil, true },
    { "命", 1, "#showtooltip 破釜沉舟\n/castsequence [combat] reset=600 破釜沉舟,盾墙", nil, true },
    { "嘲击", 1, "#showtooltip\n/cast [target=mouseover,combat,harm,exists]嘲讽;[combat,harm,exists]盾击;嘲讽", nil, true },
    { "英压", 1, "#showtooltip 英勇打击\n/startattack\n/cast 压制\n/cast 英勇打击", nil, true },
    { "英复", 1, "#showtooltip 英勇打击\n/startattack\n/cast 复仇\n/cast 英勇打击", nil, true },
    { "狂暴", 1, "#showtooltip 狂暴之怒\n/cast 狂暴之怒\n/cast [stance:3]防御姿态;狂暴姿态", nil, true },
}

MACRO_PLACEMENT_WARRIOR = {
    ["冲惩"]   = { 1, 7 },
    ["命"]     = { 7, 10 },
    ["嘲击"]   = { 7, 7 },
    ["英压"]   = { 1, 4 },
    ["英复"]   = { 7, 4 },
    ["狂暴"]   = { 7, 12 },
    ["压英"]   = { 1, 1 },
    ["冲惩L"]  = { 1, 8 },
}

SPELLS_BY_CLASS_WARRIOR = {
    { "拦截", 8, 7 },
    { "顺劈斩", 1, 1 },
    { "旋风斩", 1, 1 },
    { "撕裂", 1, 2 },
    { "剑刃乱舞", 1, 9 },
    { "盾牌猛击", 1, 8 },
    { "盾牌格挡", 7, 3 },
    { "破胆怒吼", 1, 1 },
    { "战斗怒吼", 1, 1 },
    { "挑战怒吼", 1, 1 },
    { "缴械", 7, 10 },
}
