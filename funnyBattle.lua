require("TSLib")
require("general")
require("util")

-- 休闲决斗类

FunnyBattle = {}

FunnyBattle.warkCardFlag = flase

FunnyBattle.startFlag = true

FunnyBattle.time = os.time()

FunnyBattle.judgeList = {
    {color = pvpFieldMain["pvpFieldChoosedColor"], log = "竞技场主页 选中状态的底部竞技场", x = 235, y = 1227},
    {color = funnyPvp["listFunnyPvpColor"], log = "休闲决斗 决斗列表中的休闲决斗", x = 365, y = 828},
    {color = funnyPvp["funnyPvpStartColor"], log = "休闲决斗 开始决斗", x = 367, y = 521},
    {
        color = battleIng["operateCardColor"],
        log = "战斗中出现操作卡的选项",
        func = function()
            mSleep(1000)
            tap(137, 860)
            mSleep(2000)
            tap(355, 1091)
            mSleep(500)
        end
    }
}
FunnyBattle.advancedJudgeList = {
    {
        trueColorList = {battleIng["pvpYourRoundColor"], battleIng["yourInCardColor"]},
        log = "战斗中 你的回合 你的抽卡阶段",
        func = function()
            if (not multiColor(battleIng["fristRoundColor"])) or (not multiColor(battleIng["oneDigitRoundColor"])) then
                mSleep(500)
                nLog("战斗中 抽卡动作执行")
                Util.sliding(362, 620, 632, 720, false, true)
                mSleep(800)
                tap(367, 660)
                mSleep(500)
            end
        end
    },
    {
        trueColorList = {battleIng["pvpYourRoundColor"], battleIng["yourMainColor"]},
        falseColorList = {battleIng["mainWakeCardColor"]},
        flagList = {not FunnyBattle.warkCardFlag},
        log = "战斗中 你的回合  你的主要阶段",
        func = function()
            mSleep(500)
            nLog("战斗中 出卡动作执行")
            Util.sliding(325, 1250, 325, 1000, flase, flase)
            mSleep(500)
        end
    },
    {
        trueColorList = {battleIng["mainWakeCardColor"]},
        flagList = {not FunnyBattle.warkCardFlag},
        log = "战斗中 主要阶段 召唤卡片",
        func = function()
            mSleep(500)
            tap(268, 951)
            FunnyBattle.warkCardFlag = true
            mSleep(500)
            Util.hasLimitWhileLoop(
                {
                    trueColorList = {battleIng["yourMainColor"]},
                    falseColorList = {battleIng["pvpYourRoundColor"]},
                    log = "战斗中 战斗阶段 对手在做判断"
                }
            )
            mSleep(1500)
        end
    },
    {
        trueColorList = {battleIng["pvpYourRoundColor"], battleIng["changeRoundColor"], battleIng["yourMainColor"]},
        flagList = {FunnyBattle.warkCardFlag},
        log = "战斗中 主要阶段 你的回合 右侧切换阶段",
        func = function()
            FunnyBattle.warkCardFlag = flase
            tap(655, 815)
            mSleep(500)
            tap(544, 864)
            mSleep(1000)
        end
    },
    {
        trueColorList = {battleIng["yourFightColor"], battleIng["pvpYourRoundColor"]},
        falseColorList = {battleIng["withoutSecondCardColor"]},
        log = "战斗中 你的战斗阶段 你的回合  二号卡槽有卡",
        func = function()
            mSleep(1000)
            nLog("战斗中 二号卡槽出卡动作执行")
            moveTo(359, 716, 359, 618)
            mSleep(2000)
            Util.hasLimitWhileLoop(
                {
                    trueColorList = {battleIng["yourFightColor"]},
                    falseColorList = {battleIng["pvpYourRoundColor"]},
                    log = "战斗中 战斗阶段 对手在做判断"
                }
            )
            Util.judge(
                {
                    color = battleIng["withoutSecondCardColor"],
                    log = "战斗中 二号卡槽没卡 战斗阵亡了",
                    func = function()
                        mSleep(3000)
                    end
                }
            )
        end
    },
    {
        trueColorList = {battleIng["yourFightColor"], battleIng["pvpYourRoundColor"]},
        falseColorList = {battleIng["withoutThirdCardColor"]},
        log = "战斗中 你的战斗阶段 你的回合  三号卡槽有卡",
        func = function()
            mSleep(1000)
            nLog("战斗中 三号卡槽出卡动作执行")
            moveTo(506, 711, 506, 618)
            mSleep(2000)
            Util.hasLimitWhileLoop(
                {
                    trueColorList = {battleIng["yourFightColor"]},
                    falseColorList = {battleIng["pvpYourRoundColor"]},
                    log = "战斗中 战斗阶段 对手在做判断"
                }
            )
            Util.judge(
                {
                    color = battleIng["withoutThirdCardColor"],
                    log = "战斗中 三号卡槽没卡 战斗阵亡了",
                    func = function()
                        mSleep(2000)
                    end
                }
            )
        end
    },
    {
        trueColorList = {battleIng["yourFightColor"], battleIng["pvpYourRoundColor"]},
        falseColorList = {battleIng["withoutFirstCardColor"]},
        log = "战斗中 你的战斗阶段 你的回合  一号卡槽有卡",
        func = function()
            mSleep(1000)
            nLog("战斗中 一号卡槽出卡动作执行")
            moveTo(209, 711, 209, 600)
            mSleep(2000)
            Util.hasLimitWhileLoop(
                {
                    trueColorList = {battleIng["yourFightColor"]},
                    falseColorList = {battleIng["pvpYourRoundColor"]},
                    log = "战斗中 战斗阶段 对手在做判断"
                }
            )
        end
    },
    {
        trueColorList = {battleIng["pvpYourRoundColor"], battleIng["yourFightColor"], battleIng["changeRoundColor"]},
        log = "战斗中 你的回合 你的战斗阶段 右侧切换阶段 结束战斗回合",
        func = function()
            mSleep(1000)
            tap(655, 815)
            mSleep(500)
            tap(544, 864)
            mSleep(1000)
        end
    }
}
FunnyBattle.customJudge = function()
    if Util.timeJudge(FunnyBattle.time, 1200) then
        x, y = findImage("retry.png", 0, 0, 703, 1260)
        if x ~= -1 and y ~= -1 then
            nLog("找到图片重试")
            tap(x, y)
        end
    end
    if Util.timeJudge(FunnyBattle.time, 40) then
        x, y = findImage("sure.png", 0, 0, 703, 1260)
        if x ~= -1 and y ~= -1 then
            nLog("找到图片确定")
            tap(x, y)
        end
    end
end

FunnyBattle.run = function()
    nLog("休闲决斗开始")
    while (FunnyBattle.startFlag) do
        FunnyBattle.customJudge()
        Util.loopJudge(General.judgeList)
        Util.loopJudge(FunnyBattle.judgeList)
        Util.loopAdvancedJudge(FunnyBattle.advancedJudgeList)
    end
end
