require("TSLib");
-- 开始游戏取色
startGame ={
    {  210,  599, 0x81ffff},
    {  238,  598, 0x81ffff},
    {  251,  597, 0x7ef9fc},
    {  250,  603, 0x81ffff},
    {  264,  605, 0x81ffff},
    {  274,  598, 0x051876},
    {  280,  602, 0x81ffff},
    {  278,  606, 0x3672ac},
    {  278,  606, 0x3672ac},
    {  292,  600, 0x81ffff},
    };
popSure ={
	{  164,  695, 0x16a9f0},
	{  260,  710, 0xffffff},
	{  270,  713, 0x041b47},
	{  276,  714, 0x233557},
	{  278,  720, 0x2b3b55},
	{  262,  720, 0xffffff},
	{  244,  720, 0x083689},
	{  256,  726, 0x203f76},
	{  269,  725, 0x062867},
	{  302,  726, 0x093991},
}
function appInit()
    -- 初始化屏幕
    init(0);
    -- 启动APP
    if  runApp("com.netease.ma84")== 0 then 
        nLog('启动成功'); 
        flag = true;
        -- 是否为开始游戏界面
        while(flag)do
            if multiColor(startGame) then
                nLog("当前为开始游戏画面");
                mSleep(1000);
                tap(273,597);
                flag =false;
            end
        end
        flag = true;
        while(flag)do
            if multiColor(startGame) then
                nLog("当前为开始游戏画面");
                mSleep(1000);
                tap(273,597);
                flag =false;
            end
        end
        nLog('进入主界面');
        
 
    else
        nLog('失败');    
        appInit();
    end
end

function pve()
end

appInit();