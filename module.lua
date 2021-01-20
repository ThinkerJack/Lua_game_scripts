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
     
        getFunnyPvpRunJudgeList(advancedData)
        loopAdvancedJudge(funnyPvpRunAdvancedJudgeList)
        loopJudge(generalJudgeList)
        loopJudge(funnyPvpRunJudgeList)
    end
end
