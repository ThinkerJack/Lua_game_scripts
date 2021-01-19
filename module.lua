require("TSLib")
require("color_source_450")
require("util")

    generalBattleJudgeList = {
        {color = battleIng["fightRollBackColor"], log = "战斗阶段 发生倒回", x = 166, y = 527},
        {color = netWorkError["noNetWorkColor"], log = "网络错误 网络失败弹框", x = 392, y = 540},
        {color = netWorkError["connectErrorColor"], log = "网络错误 链接超时", x = 280, y = 533},
        {color = netWorkError["netWorkOutTimeColor"], log = "网络错误 链接超时", x = 269, y = 522},
        {color = general["bottomSureColor"], log = "通用 底部确定", x = 274, y = 911},
        {color = general["bottomNextColor"], log = "通用 底部下一步", x = 274, y = 911},
        {color = general["battleAfterLevelUpColor"], log = "通用 战斗结束后升级", x = 275, y = 480},
        {color = general["bottomChat"], log = "通用 底部NPC聊天", x = 287, y = 901}
    }
function appInit()
    -- 初始化屏幕
    init(0)
    -- 启动APP
    if runApp("com.netease.ma84") == 0 then
        local flag = true
        local judgeList = {
            {color = gameRun["startGameColor"], log = "游戏启动 开始游戏界面按钮", x = 273, y = 597, sleep = 2000},
            {color = general["fullScreenPopBackColor"], log = "通用 全屏弹框左下角返回", x = 46, y = 923},
            {
                color = general["loginAfterMain"],
                log = "通用 登录后游戏主页面",
                func = function()
                    flag = false
                end
            }
        }
        while (flag) do
            loopJudge(judgeList)
        end
        nLog("启动成功")
    else
        nLog("启动失败")
        appInit()
    end
end

function doorPve()
    local judgeList = {
        {color = gameMainPop["loginPopSureColor"], log = "游戏主界面可能的弹窗 登录后弹出的广告确认按钮", x = 276, y = 714},
        {color = general["loginAfterMain"], log = "通用 登录后游戏主页面", x = 382, y = 418},
        {color = door["highLevelPopSureColor"], log = "决斗门 高等级怪物弹框", x = 388, y = 418},
        {color = door["bottomBeginBattleColor"], log = "决斗门 底部开始决斗", x = 287, y = 834},
        {color = door["keyNoStockColor"], log = "决斗门 钥匙数量不足", x = 523, y = 462}
    }
local advancedJudgeList = {
    {
        color = multiColor(door["tapBattleDoorColor"]),
        log = "决斗门 点击圆形决斗门",
        func = function()
            -- 自动点击等级10的门
            tap(89, 657)
            mSleep(2000)
            tap(280, 832)
            mSleep(1000)
        end
    }
}
while (true) do
    loopJudge(judgeList)
    loopJudge(generalBattleJudgeList)
    loopAdvancedJudge(advancedJudgeList)
end
end

function funnyPvpRun()
     warkCardFlag = flase
    local judgeList = {
        {color = gameMainPop["loginPopSureColor"], log = "游戏主界面可能的弹窗 登录后弹出的广告确认按钮", x = 276, y = 714},
        {color = pvpFieldMain["pvpFieldChoosedColor"], log = "竞技场主页 选中状态的底部竞技场", x = 174, y = 920},
        {color = funnyPvp["listFunnyPvpColor"], log = "休闲决斗 决斗列表中的休闲决斗", x = 258, y = 623},
        {color = funnyPvp["funnyPvpStartColor"], log = "休闲决斗 开始决斗", x = 271, y = 406}
    }
    local funnyPvpBattleAdvancedJudgeList = {
    {
        flag = multiColor(battleIng["pvpYourRoundColor"]) and multiColor(battleIng["yourInCardColor"]) and
        ((not multiColor(battleIng["fristRoundColor"])) or (not multiColor(battleIng["oneDigitRoundColor"]))),
        log = "战斗中 你的回合 你的抽卡阶段",
        func = function()
            mSleep(500)
            nLog("战斗中 抽卡动作执行")
            sliding(260, 450, 260, 700, false, true)
            mSleep(800)
            tap(272, 479)
            mSleep(500)
        end
    },
    {
        flag = multiColor(battleIng["pvpYourRoundColor"]) and multiColor(battleIng["yourMainColor"]),
        log = "战斗中 你的回合  你的主要阶段",
        func = function()
            mSleep(1000)
            nLog("战斗中 出卡动作执行")
            sliding(230, 860, 230, 710, flase, flase)
            mSleep(800)
        end
    },
    {
        flag = multiColor(battleIng["mainWakeCardColor"]),
        log = "战斗中 主要阶段 召唤卡片",
        func = function()
            mSleep(200)
            tap(204, 706)
            mSleep(1000)
            hasLimitWhileLoop(
                {
                    flag = (not multiColor(battleIng["pvpYourRoundColor"])) and
                    multiColor(battleIng["yourMainColor"]),
                    log = "战斗中 主要阶段 对手在做判断"
                }
                );
            warkCardFlag = true
            mSleep(800)
        end
    },
    {
        flag = multiColor(battleIng["pvpYourRoundColor"]) and multiColor(battleIng["changeRoundColor"]) and
        multiColor(battleIng["yourMainColor"]) and
        warkCardFlag,
        log = "战斗中 主要阶段 你的回合 右侧切换阶段",
        func = function()
            warkCardFlag = flase
            tap(495, 606)
            mSleep(500)
            tap(419, 638)
            mSleep(1000)
        end
    },
    {
        flag = multiColor(battleIng["yourFightColor"]) and (multiColor(battleIng["pvpYourRoundColor"])) and
        (not multiColor(battleIng["withoutSecondCardColor"])),
        log = "战斗中 你的战斗阶段 你的回合  二号卡槽有卡",
        func = function()
            mSleep(1000)
            nLog("战斗中 二号卡槽出卡动作执行")
            sliding(268, 550, 268, 350, flase, flase)
            mSleep(3000)
            hasLimitWhileLoop(
                {
                    flag = (not multiColor(battleIng["pvpYourRoundColor"])) and
                    multiColor(battleIng["yourFightColor"]),
                    log = "战斗中 战斗阶段 对手在做判断"
                }
                );
            advancedJudge(
                {
                    flag = multiColor(battleIng["withoutSecondCardColor"]),
                    nLog = "战斗中 二号卡槽没卡 战斗阵亡了",
                    func = function()
                        mSleep(3000)
                    end
                }
                );
        end
    },
    {
        flag = multiColor(battleIng["yourFightColor"]) and (multiColor(battleIng["pvpYourRoundColor"])) and
        (not multiColor(battleIng["withoutThirdCardColor"])),
        log = "战斗中 你的战斗阶段 你的回合  三号卡槽有卡",
        func = function()
            mSleep(1000)
            nLog("战斗中 三号卡槽出卡动作执行")
            sliding(380, 550, 380, 350, flase, flase)
            mSleep(3000)
            hasLimitWhileLoop(
                {
                    flag = (not multiColor(battleIng["pvpYourRoundColor"])) and
                    multiColor(battleIng["yourFightColor"]),
                    log = "战斗中 战斗阶段 对手在做判断"
                }
                );
            advancedJudge(
                {
                    flag = multiColor(battleIng["withoutThirdCardColor"]),
                    nLog = "战斗中 三号卡槽没卡 战斗阵亡了",
                    func = function()
                        mSleep(3000)
                    end
                }
                );
        end
    },
    {
        flag = multiColor(battleIng["yourFightColor"]) and (multiColor(battleIng["pvpYourRoundColor"])) and
        (not multiColor(battleIng["withoutFirstCardColor"])),
        log = "战斗中 你的战斗阶段 你的回合  一号卡槽有卡",
        func = function()
            mSleep(1000)
            nLog("战斗中 一号卡槽出卡动作执行")
            sliding(150, 550, 150, 350, flase, flase)
            mSleep(3000)
            hasLimitWhileLoop(
                {
                    flag = (not multiColor(battleIng["pvpYourRoundColor"])) and
                    multiColor(battleIng["yourFightColor"]),
                    log = "战斗中 战斗阶段 对手在做判断"
                }
                );
            advancedJudge(
                {
                    flag = multiColor(battleIng["withoutFirstCardColor"]),
                    nLog = "战斗中 一号卡槽没卡 战斗阵亡了",
                    func = function()
                        mSleep(1000)
                    end
                }
                );
        end
    },
    {
        flag = multiColor(battleIng["pvpYourRoundColor"]) and multiColor(battleIng["yourFightColor"]) and
        multiColor(battleIng["changeRoundColor"]),
        func = function()
            mSleep(1000)
            tap(495, 606)
            mSleep(500)
            tap(419, 638)
        end,
        log = "战斗中 你的回合 你的战斗阶段 右侧切换阶段 结束战斗回合"
    }
}
while (true) do
    loopJudge(judgeList)
    loopAdvancedJudge(funnyPvpBattleAdvancedJudgeList)
    loopJudge(generalBattleJudgeList)
end
end


