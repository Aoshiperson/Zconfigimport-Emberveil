local _, classToken = UnitClass("player")
if classToken ~= "PRIEST" then return end

MACROS_BY_CLASS_PRIEST = {
    { "吐息", "INV_MISC_QUESTIONMARK", "#show\n/stopcasting\n/use [@targettarget] 真言术：盾", nil, true },
    { "安抚", "INV_MISC_QUESTIONMARK", "/cleartarget\n/targetenemy [noharm][dead][noexists]\n/script SetCVar(\"targetNearestDistance\",50)\n/cast [target=mouseover,exists]安抚心灵;安抚心灵", nil, true },
    { "射绝", "INV_MISC_QUESTIONMARK", "#showtooltip\n/cast [target=mouseover,harm,exists]射击;绝望祷言", nil, true },
    { "小耐", "INV_MISC_QUESTIONMARK", "#showtooltip\n/cast [target=mouseover,help,exists]真言术：韧;真言术：韧", nil, true },
    { "强效", "INV_MISC_QUESTIONMARK", "#show\n/cast [@mouseover,help,exists]强效治疗术;[@mouseover,harm,exists]暗言术：痛;[@target,help,exists]强效治疗术;[@target,harm,exists]暗言术：痛;强效治疗术", nil, true },
    { "快速", "INV_MISC_QUESTIONMARK", "#showtooltip\n/cast [target=mouseover,help,exists]快速治疗;快速治疗", nil, true },
    { "恢复", "INV_MISC_QUESTIONMARK", "#showtooltip\n/cast [target=mouseover,exists]恢复;恢复", nil, true },
    { "惩疗", "INV_MISC_QUESTIONMARK", "#showtooltip\n/cast [@mouseover,help,exists]治疗术;[@mouseover,harm,exists]惩击;[@target,help,exists]治疗术;[@target,harm,exists]惩击;治疗术", nil, true },
    { "次级", "INV_MISC_QUESTIONMARK", "#showtooltip\n/cast [target=mouseover,exists]次级治疗术;次级治疗术", nil, true },
    { "治疗", "INV_MISC_QUESTIONMARK", "#showtooltip\n/cast [target=mouseover,exists]治疗术;治疗术", nil, true },
    { "盾", "INV_MISC_QUESTIONMARK", "#showtooltip\n/cast [target=mouseover,help,exists]真言术：盾;真言术：盾", nil, true },
    { "祛病", "INV_MISC_QUESTIONMARK", "#showtooltip\n/cast [target=mouseover,exists]祛病术;祛病术", nil, true },
    { "祷啸", "INV_MISC_QUESTIONMARK", "#showtooltip\n/cast [mod,target=mouseover,exists]治疗祷言(等级 1);[target=mouseover,exists]治疗祷言;心灵尖啸", nil, true },
    { "防恐", 134400, "#showtooltip\n/cast [target=mouseover,exists]防护恐惧结界;防护恐惧结界", nil, true },
    { "鞭啸", 134400, "#showtooltip\n/cast [@mouseover,help,exists]治疗术;[@mouseover,harm,exists]精神鞭笞;[@target,help,exists]治疗术;[@target,harm,exists]精神鞭笞;治疗术", nil, true },
    { "驱散", "INV_MISC_QUESTIONMARK", "#showtooltip\n/cast [target=mouseover,exists]驱散魔法;驱散魔法", nil, true },
    { "驱病", "INV_MISC_QUESTIONMARK", "#showtooltip\n/cast [target=mouseover,exists]驱除疾病;驱除疾病", nil, true },
}

MACRO_PLACEMENT_PRIEST = {
    ["吐息"] = { 7, 8 },
    ["安抚"] = { 2, 8 },
    ["射绝"] = { 7, 1 },
    ["小耐"] = { 2, 4 },
    ["强效"] = { 1, 5 },
    ["快速"] = { 1, 3 },
    ["恢复"] = { 1, 4 },
    ["惩疗"] = { 1, 2 },
    ["次级"] = { 0, 0 },
    ["治疗"] = { 0, 0 },
    ["盾"]   = { 1, 8 },
    ["祛病"] = { 0, 0 },
    ["祷啸"] = { 1, 10 },
    ["防恐"] = { 1, 9 },
    ["鞭啸"] = { 0, 0 },
    ["驱散"] = { 1, 7 },
    ["驱病"] = { 7, 9 },
}

SPELLS_BY_CLASS_PRIEST = {
    { "心灵控制", 2, 3 },
    { "心灵震爆", 9, 9 },
    { "暗影形态", 9, 9 },
    { "沉默", 1, 7 },
    { "神圣新星", 7, 6 },
    { "复活术", 2, 5 },
    { "神圣之灵", 1, 9 },
    { "坚韧祷言", 1, 10 },
    { "精神祷言", 1, 11 },
}
