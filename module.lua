require("TSLib")
require("color_source_750")
require("util")
require("judge_list")

function appInit()
    -- 初始化屏幕
    init(0)
    -- 启动APP
    if runApp("com.netease.ma84") == 0 then
        simpleData = {type ="simple",endFlag = true}
        getAppInitJudgeList(simpleData)
        while (data.endFlag) do
            loopJudge(appInitJudgeList)
        end
        nLog("启动成功")
    else
        nLog("启动失败")
        appInit()
    end
end

function doorPve()
    getGeneralJudgeList("simple")
    getDoorPveJudgeList("simple")
    while (true) do
        getDoorPveJudgeList("advanced")
        loopJudge(doorPveJudgeList)
        loopJudge(generalJudgeList)
        loopAdvancedJudge(doorPveAdvancedJudgeList)
    end
end

function funnyPvpRun()
    simpleData = {type ="simple"}
    getGeneralJudgeList(simpleData)
    local advancedData = {type ="advanced",warkCardFlag = flase,time = os.time()}
    getFunnyPvpRunJudgeList(simpleData)
    while (true) do
     
      --  getFunnyPvpRunJudgeList(advancedData)
        funnyPvpRunAdvancedJudgeList = {
            {
                flag = timeJudge(advancedData.time, 30),
                log = "判断是否有确定图片",
                func = function()
                    x, y = findImage("sure.png", 0, 0, 703, 1260)
                    if x ~= -1 and y ~= -1 then
                        nLog("找到图片确定")
                        tap(x, y)
                    end
                end
            },
            {
                flag = timeJudge(advancedData.time, 1200),
                log = "判断是否有重试图片",
                func = function()
                    x, y = findImage("retry.png", 0, 0, 703, 1260)
                    if x ~= -1 and y ~= -1 then
                        nLog("找到图片重试")
                        tap(x, y)
                    end
                end
            },
            {
                flag = multiColor(battleIng["pvpYourRoundColor"]) and multiColor(battleIng["yourInCardColor"]) and
                    ((not multiColor(battleIng["fristRoundColor"])) or (not multiColor(battleIng["oneDigitRoundColor"]))),
                log = "战斗中 你的回合 你的抽卡阶段",
                func = function()
                    mSleep(500)
                    nLog("战斗中 抽卡动作执行")
                    sliding(362, 620, 632, 720, false, true)
                    mSleep(800)
                    tap(367, 660)
                    mSleep(500)
                end
            },
            {
                flag = (multiColor(battleIng["pvpYourRoundColor"]) and multiColor(battleIng["yourMainColor"])) and
                    (not multiColor(battleIng["mainWakeCardColor"])) and
                    (not advancedData.warkCardFlag),
                log = "战斗中 你的回合  你的主要阶段",
                func = function()
                    mSleep(500)
                    nLog("战斗中 出卡动作执行")
                    sliding(325, 1250, 325, 1000, flase, flase)
                    mSleep(500)
                end
            },
            {
                flag = multiColor(battleIng["mainWakeCardColor"]) and (not advancedData.warkCardFlag),
                log = "战斗中 主要阶段 召唤卡片",
                func = function()
                    mSleep(500)
                    tap(268, 951)
                    advancedData.warkCardFlag = true
                    mSleep(200)
                end
            },
            {
                flag = multiColor(battleIng["pvpYourRoundColor"]) and multiColor(battleIng["changeRoundColor"]) and
                    multiColor(battleIng["yourMainColor"]) and
                    advancedData.warkCardFlag,
                log = "战斗中 主要阶段 你的回合 右侧切换阶段",
                func = function()
                    advancedData.warkCardFlag = flase
                    tap(655, 815)
                    mSleep(500)
                    tap(544, 864)
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
                    moveTo(359, 716, 359, 618)
                    mSleep(3000)
                    hasLimitWhileLoop(
                        {
                            flag = (not multiColor(battleIng["pvpYourRoundColor"])) and
                                multiColor(battleIng["yourFightColor"]),
                            log = "战斗中 战斗阶段 对手在做判断"
                        }
                    )
                    advancedJudge(
                        {
                            flag = multiColor(battleIng["withoutSecondCardColor"]),
                            nLog = "战斗中 二号卡槽没卡 战斗阵亡了",
                            func = function()
                                mSleep(3000)
                            end
                        }
                    )
                end
            },
            {
                flag = multiColor(battleIng["yourFightColor"]) and (multiColor(battleIng["pvpYourRoundColor"])) and
                    (not multiColor(battleIng["withoutThirdCardColor"])),
                log = "战斗中 你的战斗阶段 你的回合  三号卡槽有卡",
                func = function()
                    mSleep(1000)
                    nLog("战斗中 三号卡槽出卡动作执行")
                    moveTo(506, 711, 506, 618)
                    mSleep(3000)
                    hasLimitWhileLoop(
                        {
                            flag = (not multiColor(battleIng["pvpYourRoundColor"])) and
                                multiColor(battleIng["yourFightColor"]),
                            log = "战斗中 战斗阶段 对手在做判断"
                        }
                    )
                    advancedJudge(
                        {
                            flag = multiColor(battleIng["withoutThirdCardColor"]),
                            nLog = "战斗中 三号卡槽没卡 战斗阵亡了",
                            func = function()
                                mSleep(3000)
                            end
                        }
                    )
                end
            },
            {
                flag = multiColor(battleIng["yourFightColor"]) and (multiColor(battleIng["pvpYourRoundColor"])) and
                    (not multiColor(battleIng["withoutFirstCardColor"])),
                log = "战斗中 你的战斗阶段 你的回合  一号卡槽有卡",
                func = function()
                    mSleep(1000)
                    nLog("战斗中 一号卡槽出卡动作执行")
                    moveTo(209, 711, 209, 600)
                    mSleep(3000)
                    hasLimitWhileLoop(
                        {
                            flag = (not multiColor(battleIng["pvpYourRoundColor"])) and
                                multiColor(battleIng["yourFightColor"]),
                            log = "战斗中 战斗阶段 对手在做判断"
                        }
                    )
                end
            },
            {
                flag = multiColor(battleIng["pvpYourRoundColor"]) and multiColor(battleIng["yourFightColor"]) and
                    multiColor(battleIng["changeRoundColor"]),
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
        loopAdvancedJudge(funnyPvpRunAdvancedJudgeList)
        loopJudge(generalJudgeList)
        loopJudge(funnyPvpRunJudgeList)
    end
end
