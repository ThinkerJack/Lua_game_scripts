require("color_source_750")

function getGeneralJudgeList(flag)
    if flag == "simple" then
        generalJudgeList = {
            {color = general["bottomSureColor"], log = "通用 底部确定", x = 358, y = 1198},
            {color = general["bottomNextColor"], log = "通用 底部下一步", x = 372, y = 1204},
            {color = general["battleAfterLevelUpColor"], log = "通用 战斗结束后升级", x = 376, y = 606},
            {color = general["bottomChat"], log = "通用 底部NPC聊天", x = 353, y = 1198},
            {color = general["getNewSkillColor"], log = "通用 获得新技能", x = 372, y = 793}
        }
    end
    if flag == "advanced" then
    end
end

function getAppInitJudgeList(flag)
    if flag == "simple" then
        appInitJudgeList = {
            {color = gameRun["startGameColor"], log = "游戏启动 开始游戏界面按钮", x = 342, y = 795, sleep = 2000},
            {color = general["fullScreenPopBackColor"], log = "通用 全屏弹框左下角返回", x = 63, y = 1229},
            {
                color = general["loginAfterMain"],
                log = "通用 登录后游戏主页面",
                func = function()
                    flag = false
                end
            }
        }
    end
    if flag == "advanced" then
    end

 

end

function getDoorPveJudgeList(flag)
    if flag == "simple" then
        doorPveJudgeList = {
            {color = general["loginAfterMain"], log = "通用 登录后游戏主页面", x = 382, y = 418},
            {color = door["highLevelPopSureColor"], log = "决斗门 高等级怪物弹框", x = 388, y = 418},
            {color = door["bottomBeginBattleColor"], log = "决斗门 底部开始决斗", x = 287, y = 834},
            {color = door["keyNoStockColor"], log = "决斗门 钥匙数量不足", x = 523, y = 462}
        }
    end
    if flag == "advanced" then
        doorPveAdvancedJudgeList = {
            {
                flag = multiColor(door["tapBattleDoorColor"]),
                log = "决斗门 点击圆形决斗门",
                func = function()
                    -- 自动点击等级10的门
                    tap(89, 657)
                    wait(2000)
                    tap(280, 832)
                    wait(1000)
                end
            }
        }

    end

end

function getFunnyPvpRunJudgeList(flag)
    if flag == "simple" then
        funnyPvpRunJudgeList = {
            {color = pvpFieldMain["pvpFieldChoosedColor"], log = "竞技场主页 选中状态的底部竞技场", x = 235, y = 1227},
            {color = funnyPvp["listFunnyPvpColor"], log = "休闲决斗 决斗列表中的休闲决斗", x = 365, y = 828},
            {color = funnyPvp["funnyPvpStartColor"], log = "休闲决斗 开始决斗", x = 367, y = 521},
            {color = funnyPvp["operateCardColor"], log = "战斗中出现操作卡的选项", x = 142, y = 873}
        }
    end
    if flag == "advanced" then
        funnyPvpRunAdvancedJudgeList = {
            {
                flag = timeJudge(time, 30),
                log = "找到图片确定",
                func = function()
                    x, y = findImage("sure.png", 0, 0, 703, 1260)
                    if x ~= -1 and y ~= -1 then
                        nLog("找到图片确定")
                        tap(x, y)
                    end
                end
            },
            {
                flag = timeJudge(time, 1200),
                log = "找到图片重试",
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
                    wait(500)
                    nLog("战斗中 抽卡动作执行")
                    moveTo(362, 620, 632, 720)
                    wait(800)
                    tap(367, 660)
                    wait(500)
                end
            },
            {
                flag = (multiColor(battleIng["pvpYourRoundColor"]) and multiColor(battleIng["yourMainColor"])) and
                    (not multiColor(battleIng["mainWakeCardColor"])) and
                    (not warkCardFlag),
                log = "战斗中 你的回合  你的主要阶段",
                func = function()
                    wait(500)
                    nLog("战斗中 出卡动作执行")
                    moveTo(325, 1250, 325, 1000)
                    wait(500)
                end
            },
            {
                flag = multiColor(battleIng["mainWakeCardColor"]) and (not warkCardFlag),
                log = "战斗中 主要阶段 召唤卡片",
                func = function()
                    wait(500)
                    tap(268, 951)
                    warkCardFlag = true
                    wait(200)
                end
            },
            {
                flag = multiColor(battleIng["pvpYourRoundColor"]) and multiColor(battleIng["changeRoundColor"]) and
                    multiColor(battleIng["yourMainColor"]) and
                    warkCardFlag,
                log = "战斗中 主要阶段 你的回合 右侧切换阶段",
                func = function()
                    warkCardFlag = flase
                    tap(655, 815)
                    wait(500)
                    tap(544, 864)
                    wait(1000)
                end
            },
            {
                flag = multiColor(battleIng["yourFightColor"]) and (multiColor(battleIng["pvpYourRoundColor"])) and
                    (not multiColor(battleIng["withoutSecondCardColor"])),
                log = "战斗中 你的战斗阶段 你的回合  二号卡槽有卡",
                func = function()
                    wait(1000)
                    nLog("战斗中 二号卡槽出卡动作执行")
                    moveTo(359, 716, 359, 618)
                    wait(3000)
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
                                wait(3000)
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
                    wait(1000)
                    nLog("战斗中 三号卡槽出卡动作执行")
                    moveTo(506, 711, 506, 618)
                    wait(3000)
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
                                wait(3000)
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
                    wait(1000)
                    nLog("战斗中 一号卡槽出卡动作执行")
                    moveTo(209, 711, 209, 600)
                    wait(3000)
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
                    wait(1000)
                    tap(655, 815)
                    wait(500)
                    tap(544, 864)
                    wait(1000)
                end
            }
        }
    end

end
