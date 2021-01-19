require("TSLib")
require("color_source")
require("util")


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
        nLog("测试结束")
    else
        nLog("启动失败")
        appInit()
    end
end

function funntPvpRun()
    local judgeList = {
        {color = gameMainPop["loginPopSureColor"], log = "游戏主界面可能的弹窗 登录后弹出的广告确认按钮", x = 276, y = 714},
        {color = pvpFieldMain["pvpFieldChoosedColor"], log = "竞技场主页 选中状态的底部竞技场", x = 174, y = 920},
        {color = funnyPvp["listFunnyPvpColor"], log = "休闲决斗 决斗列表中的休闲决斗", x = 258, y = 623},
        {color = general["bottomSureColor"], log = "通用 底部确定", x = 274, y = 911},
        {color = general["bottomNextColor"], log = "通用 底部下一步", x = 274, y = 911},
        {color = funnyPvp["funnyPvpStartColor"], log = "休闲决斗 开始决斗", x = 271, y = 406},
        {color = general["battleAfterLevelUpColor"], log = "通用 战斗结束后升级", x = 275, y = 480}
    }
    beatJudgeList = {
        {color = battleIng["fightRollBackColor"], log = "战斗阶段 发生倒回", x = 166, y = 527},
        {color = netWorkError["noNetWorkColor"], log = "网络错误 网络失败弹框", x = 392, y = 540},
        {color = netWorkError["connectErrorColor"], log = "网络错误 链接超时", x = 280, y = 533},
        {color = netWorkError["netWorkOutTimeColor"], log = "网络错误 链接超时", x = 269, y = 522}
    }
    while (true) do
        loopJudge(judgeList)
        loopJudge(beatJudgeList)
        beat()
    end
end

function doorPve()
    local judgeList = {
        {color = gameMainPop["loginPopSureColor"], log = "游戏主界面可能的弹窗 登录后弹出的广告确认按钮", x = 276, y = 714},
        {color = general["bottomSureColor"], log = "通用 底部确定", x = 274, y = 911},
        {color = general["bottomNextColor"], log = "通用 底部下一步", x = 274, y = 911},
        {color = general["battleAfterLevelUpColor"], log = "通用 战斗结束后升级", x = 275, y = 480},
        {color = general["bottomChat"], log = "通用 底部NPC聊天", x = 287, y = 901},
        {color = general["loginAfterMain"], log = "通用 登录后游戏主页面", x = 382, y = 418},
        {color = door["highLevelPopSureColor"], log = "决斗门 高等级怪物弹框", x = 388, y = 418},
        {color = door["bottomBeginBattleColor"], log = "决斗门 底部开始决斗", x = 287, y = 834},
        {color = door["keyNoStockColor"], log = "决斗门 钥匙数量不足", x = 523, y = 462}
    }
    local advancedJudgeList = {
        {
            data = multiColor(door["tapBattleDoorColor"]),
            log = "决斗门 点击圆形决斗门",
            func = function()
                -- 自动点击等级10
                tap(89, 657)
                mSleep(2000)
                tap(280, 832)
                mSleep(1000)
            end
        }
    }
    while (true) do
        loopJudge(judgeList)
        loopJudge(beatJudgeList)
        loopAdvancedJudge(advancedJudgeList)
        beat()
    end
end

function beat()
    -- 抽卡阶段
    if
        multiColor(battleIng["pvpYourRoundColor"]) and multiColor(battleIng["yourInCardColor"]) and
            ((not multiColor(battleIng["fristRoundColor"])) or (not multiColor(battleIng["oneDigitRoundColor"])))
     then
        mSleep(500)
        nLog("抽卡阶段")
        sliding(260, 450, 260, 700, false, true)
        mSleep(1000)
        tap(272, 479)
        mSleep(500)
    end
    -- 主要阶段
    if multiColor(battleIng["pvpYourRoundColor"]) and multiColor(battleIng["yourMainColor"]) then
        nLog("你的主要阶段")
        nLog("出卡阶段")
        mSleep(1000)
        sliding(230, 890, 230, 690, flase, flase)
        mSleep(1000)
        if (multiColor(battleIng["mainWakeCardColor"])) then
            nLog("召唤卡阶段")
            tap(204, 706)
            mSleep(1000)
            while ((not multiColor(battleIng["pvpYourRoundColor"])) and multiColor(battleIng["yourMainColor"])) do
            end
            mSleep(1000)
        end
        if (multiColor(battleIng["pvpYourRoundColor"]) and multiColor(battleIng["changeRoundColor"])) then
            nLog("结束回合or切换回合")
            tap(495, 606)
            mSleep(500)
            tap(419, 638)
            mSleep(1000)
        end
    end
    -- 战斗阶段
    if multiColor(battleIng["yourFightColor"]) then
        nLog("战斗阶段")
        flag = true
        while (flag and multiColor(battleIng["yourFightColor"])) do
            -- 有卡加上没有绿光
            if
                (multiColor(battleIng["pvpYourRoundColor"]) and (not multiColor(battleIng["withoutSecondCardColor"])) and
                    (not multiColor(battleIng["secondCardUsedColor"])) and
                    multiColor(battleIng["yourFightColor"]))
             then
                mSleep(1000)
                nLog("二号槽位有卡")
                sliding(268, 550, 268, 350, flase, flase)
                mSleep(1000)
                local i = 1000
                while ((not multiColor(battleIng["pvpYourRoundColor"])) and multiColor(battleIng["yourFightColor"])) do
                    loopJudge(beatJudgeList)
                end
                mSleep(1500)
            end
            if
                (multiColor(battleIng["pvpYourRoundColor"]) and (not multiColor(battleIng["withoutThirdCardColor"])) and
                    (not multiColor(battleIng["thirdCardUsedColor"])) and
                    multiColor(battleIng["yourFightColor"]))
             then
                nLog("三号槽位有卡")
                sliding(380, 550, 380, 350, flase, flase)
                mSleep(1000)
                while ((not multiColor(battleIng["pvpYourRoundColor"])) and multiColor(battleIng["yourFightColor"])) do
                    loopJudge(beatJudgeList)
                end
                mSleep(1500)
            end
            if
                (multiColor(battleIng["pvpYourRoundColor"]) and (not multiColor(battleIng["withoutFirstCardColor"])) and
                    (not multiColor(battleIng["firstCardUsedColor"])) and
                    multiColor(battleIng["yourFightColor"]))
             then
                nLog("一号槽位有卡")
                sliding(150, 550, 150, 350, flase, flase)
                mSleep(1000)
                while ((not multiColor(battleIng["pvpYourRoundColor"])) and multiColor(battleIng["yourFightColor"])) do
                    loopJudge(beatJudgeList)
                end
                mSleep(1500)
            end
            loopJudge(beatJudgeList)

            -- if
            -- (multiColor(battleIng["pvpYourRoundColor"]) and
            --     (multiColor(battleIng["firstCardUsedColor"]) and multiColor(battleIng["secondCardUsedColor"]) and
            --         multiColor(battleIng["thirdCardUsedColor"])) and
            --     multiColor(battleIng["yourFightColor"]))
            -- then
            if (multiColor(battleIng["pvpYourRoundColor"])) then
                mSleep(1000)
                nLog("结束回合")
                tap(495, 606)
                mSleep(500)
                tap(419, 638)
                flag = false
            end
        end
    end
end
