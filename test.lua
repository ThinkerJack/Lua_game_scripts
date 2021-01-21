require("TSLib")
require("util")
require("general")

-- 基类
Test = {}

Test.startFlag = true

Test.judgeList = {
    {color = pvpFieldMain["pvpFieldChoosedColor"], log = "竞技场主页 选中状态的底部竞技场", x = 235, y = 1227}
}

Test.advancedJudgeList = {
    {
        trueColorList = {battleIng["pvpYourRoundColor"], battleIng["yourMainColor"]},
        falseColorList = {battleIng["mainWakeCardColor"]},
        flagList = {true},
        log = "战斗中 你的回合  你的主要阶段",
        func = function()
        end
    }
}
Test.customJudge = function()
end

Test.run = function()
    print("方法开始执行")
    while (Test.startFlag) do
        Test.customJudge()
        Util.loopJudge(Test.judgeList)
        Util.loopAdvancedJudge(Test.advancedJudgeList)
    end
    print("执行结束")
end
