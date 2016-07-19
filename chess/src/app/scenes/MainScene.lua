
local MainScene = class("MainScene", function()
	return display.newScene("MainScene")
	end)

-- 棋盘类
local ChessBoard = require("app.scenes.ChessBoard")
-- 棋盘
local chessBoard = ChessBoard.chessBoard
-- 棋盘上的棋子初始状态
local chessPieces = {ChessBoard.img_rc1,ChessBoard.img_rc2,ChessBoard.img_rm1,ChessBoard.img_rm2,
                    ChessBoard.img_rp1,ChessBoard.img_rp2,ChessBoard.img_rz1,ChessBoard.img_rz2,
                    ChessBoard.img_rz3,ChessBoard.img_rz4,ChessBoard.img_rz5,ChessBoard.img_rx1,
                    ChessBoard.img_rx2,ChessBoard.img_rs1,ChessBoard.img_rs2,ChessBoard.img_rj,
                    ChessBoard.img_bc1,ChessBoard.img_bc2,ChessBoard.img_bm1,ChessBoard.img_bm2,
                    ChessBoard.img_bp1,ChessBoard.img_bp2,ChessBoard.img_bz1,ChessBoard.img_bz2,
                    ChessBoard.img_bz3,ChessBoard.img_bz4,ChessBoard.img_bz5,ChessBoard.img_bx1,
                    ChessBoard.img_bx2,ChessBoard.img_bs1,ChessBoard.img_bs2,ChessBoard.img_bj}
-- 棋盘上的棋子选中效果
local img_selected = ChessBoard.img_selected
-- 计时器
local scheduler = require("framework.scheduler")  
-- 当前棋子的最大顺序
local max_zorder = 1
-- 走棋方
local n_side = -1
-- 红棋走棋时间
local n_redTime = 0
-- 黑棋走棋时间
local n_blackTime = 0
-- 当前是否暂停 1 暂停 0 不暂停
local n_pause = 1
-- 是否开启背景音乐 1 开启 0 不开启
local n_voiceOpen = 1
-- 棋盘在屏幕中的放缩比例
local chessScale = 1
-- 走棋记录
local ChessRecord = require("app.scenes.ChessRecord")
local chessRecord = ChessRecord.new()

-- 控制棋盘的缩放比例，使得棋盘适配屏幕左边
if display.height<1111 then
    chessScale = display.height/1111
end

--刷新棋盘当前状态 isadd 表示是否添加棋子
function MainScene:refreshBoard(isadd)
    -- 棋子选中效果图展示逻辑为先添加后移动位置
	if isadd then
		img_selected:addTo(self.img_board)
	end
	img_selected:hide()

    -- 遍历棋盘上棋子的位置
	for i=1,9 do
		for j=1,10 do
            -- 获取对应位置
			local piece = chessPieces[math.abs(chessBoard[i][j])]
			if piece then
                -- 移动或展示棋子
                piece:align(display.CENTER, (i-1)*109+116, (j-1)*109+64)
				if isadd then
					piece:addTo(self.img_board)
				end
                piece:show()
                -- 如果选中棋子 则更新显示
				local lastX = chessBoard[10][1]
				local lastY = chessBoard[10][2]
				if lastX>0 and lastY>0 then
					if chessBoard[lastX][lastY]>0 then
						img_selected:align(display.CENTER, (lastX-1)*109+116, (lastY-1)*109+64)
						img_selected:show()
					end
				end
            -- else if math.abs(chessBoard[i][j])>0 then
            --     piece:align(display.CENTER, (i-1)*109+116, (j-1)*109+64)
            --     piece:addTo(self)               
			end
			
		end
	end
end

function MainScene:ctor()
    self:playMusic()
    self:initView()
    self:bindEvnt()
    -- 刷新面板
    self:refreshBoard(true)
end

function MainScene:playMusic()
    audio.preloadMusic("floor.wav")
    audio.playMusic("floor.wav",true)
end

function MainScene:initView()
    -- 背景图片
    self.floor = display.newScale9Sprite("floor.jpg",0,0,CCSize(display.width, display.height))
            :align(display.CENTER, display.width/2, display.height/2)
            :addTo(self)

    -- 棋盘背景图
    self.img_board = cc.ui.UIImage.new("background.png")
            :align(display.CENTER, 551*chessScale, 556*chessScale)
            :setLayoutSize(1101*chessScale-20, 1111*chessScale-20)
            :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
            :addTo(self)

    -- 声音图
    self.img_voice = cc.ui.UIPushButton.new("openVolice.png")
                        :align(display.CENTER, display.width-50, display.height-50)
                        :addTo(self.floor)

    -- 红方时间
    self.lbl_red = cc.ui.UILabel.new({text = "00:00",size = 42, color = cc.c3b(50, 50, 50)})
                        :align(display.CENTER, display.width/2+551*chessScale, 150)
                        :addTo(self.floor)
    -- 红方昵称
    self.lbl_redName = cc.ui.UILabel.new({text = "Xlook",size = 30, color = cc.c3b(255, 0, 0)})
                        :align(display.CENTER, display.width/2+551*chessScale, 90)
                        :addTo(self.floor) 
    -- 黑方时间
    self.lbl_black = cc.ui.UILabel.new({text = "00:00",size = 42, color = cc.c3b(50, 50, 50)})
                        :align(display.CENTER, display.width/2+551*chessScale, display.height - 150)
                        :addTo(self.floor)
    -- 黑方昵称
    self.lbl_redName = cc.ui.UILabel.new({text = "电脑",size = 30, color = cc.c3b(0, 0, 0)})
                        :align(display.CENTER, display.width/2+551*chessScale, display.height - 90)
                        :addTo(self.floor) 
    -- 新局
    self.btn_start = cc.ui.UIPushButton.new("new.jpg")
                        :align(display.CENTER, display.width/2+551*chessScale, display.height/2+100)
                        :addTo(self.floor)
    -- 暂停/开始
    self.btn_pause = cc.ui.UIPushButton.new("pause.jpg")
                        :align(display.CENTER, display.width/2+551*chessScale, display.height/2)
                        :addTo(self.floor)
    -- 悔棋
    self.btn_regret = cc.ui.UIPushButton.new("regret.jpg")
                        :align(display.CENTER, display.width/2+551*chessScale, display.height/2-100)
                        :addTo(self.floor)
end

function MainScene:bindEvnt()
    self.btn_start:onButtonClicked(function()
                            self:scheduleStart()
                        end)
    self.btn_pause:onButtonClicked(function()
                            self:schedulePause()
                        end)
    self.btn_regret:onButtonClicked(function()
                            self:regretMove()
        end)
    self.img_voice:onButtonClicked(function()
                            self:changeVoiceState()
                        end)
    self.img_board:setTouchEnabled(true)
    -- 走棋逻辑
    self.img_board:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
                    -- 如果暂停状态 直接return
                    if n_pause == 1 then
                        return false
                    end
                    -- 获取点击时对应坐标
                    local m = math.floor((event.x/chessScale-62)/109)+1
                    local n = math.floor((event.y/chessScale-21)/109)+1
                    -- 获取上一个点的坐标
                    local preM = chessBoard[10][1]
                    local preN = chessBoard[10][2]

                    --如果没有选中，那么选中对应棋子
                    if preM == 0 and preN == 0 then
                        if m > 0 and n > 0 and chessBoard[m][n] > 0 then
                            --不到你走棋
                            if (n_side == 1 and chessBoard[m][n] <= 16)  or (n_side == -1 and chessBoard[m][n] > 16)  then
                                return
                            end
                            chessBoard[10][1] = m
                            chessBoard[10][2] = n
                        end
                        self:refreshBoard(false)
                    end
                    --如果已经选中一个棋子，那么就可以对当前棋子进行操作
                    if preM > 0 and preN > 0 then
                        --敌人
                        local isEnimy = (chessBoard[preM][preN]>0 and chessBoard[m][n]>16 and chessBoard[preM][preN]<=16) or (chessBoard[preM][preN]>16 and chessBoard[m][n]>0 and chessBoard[m][n]<=16)
                        --友军
                        local isPartener = (chessBoard[preM][preN]>0 and chessBoard[m][n]>0 and chessBoard[preM][preN]<=16 and chessBoard[m][n]<=16) or (chessBoard[preM][preN]>16 and chessBoard[m][n]>16 )
                         --消除选中效果
                        chessBoard[10][1] = 0
                        chessBoard[10][2] = 0

                        --不是友军则可以走子
                        if not isPartener then
                            self:moveChess(chessBoard[preM][preN],preM,preN,chessBoard[m][n],m,n)

                            --走棋结束需要变换阵营
                            n_side = n_side * -1

                        else --如果是友军，那么更换选中并且刷新
                            chessBoard[10][1] = m
                            chessBoard[10][2] = n
                            self:refreshBoard(false)
                        end
                    end
                return false
    end)
end

-- function MainScene:

-- 移动棋子
function MainScene:moveChess(custom,fromM,fromN,target,toM,toN)
    local chesspiece = chessPieces[custom]  
    -- 将即将移动的棋子优先级提升
    max_zorder = max_zorder+1
    chesspiece:zorder(max_zorder)

    -- 棋子当前的放缩比例
    local piecescale = 109/56

    -- 吃子的时候有放缩动画
    if target>0 then
        chessPieces[target]:hide()
        transition.scaleTo(chesspiece, {time = 0.3, scale = piecescale*2})
        transition.scaleTo(chesspiece, {time = 0.1, delay = 0.3, scale = piecescale})
    end
    
    transition.moveTo(chesspiece,{time = 0.4, x = (toM-1)*109+116, y = (toN-1)*109+64})

    chessBoard[toM][toN] = custom
    chessBoard[fromM][fromN] = 0
    -- 移除选中效果
    img_selected:hide()

    chessRecord:pushRecord(custom, fromM, fromN, target, toM, toN)
end

function MainScene:regretMove()
    record = chessRecord:top()
    if not record then
        return
    end
    n_side = n_side*-1
    chessRecord:popRecord()
    chessBoard[record.fromX][record.fromY] = record.start
    chessBoard[record.toX][record.toY] = record.target
    chessBoard[10][1] = 0
    chessBoard[10][2] = 0
    self:refreshBoard(false)
end

function MainScene:scheduleStart()
    n_pause = 0
    schedule_useTime = scheduler.scheduleGlobal(function()
        self:scheduleUpdateScene()
    end, 1)
end

function MainScene:schedulePause()
    if n_pause == 0 then
        scheduler.unscheduleGlobal(schedule_useTime)
        n_pause = 1
    else
        schedule_useTime = scheduler.scheduleGlobal(function()
        self:scheduleUpdateScene()
    end, 1)
        n_pause = 0
    end
    
end

function MainScene:scheduleUpdateScene()
    if n_side<0 then
        n_redTime = n_redTime+1
        self.lbl_red:setString(timeToString(n_redTime))
    else
        n_blackTime = n_blackTime+1
        self.lbl_black:setString(timeToString(n_blackTime))
    end
end

function timeToString(dt)
    local s = dt%60
    local h = dt/60

    return string.format("%02d:%02d", h,s)
end

function MainScene:changeVoiceState()
    if n_voiceOpen >0 then
        audio.pauseMusic()
        self.img_voice:setButtonImage(cc.ui.UIPushButton.NORMAL,"closeVolice.png")
    else
        audio.resumeMusic()
        self.img_voice:setButtonImage(cc.ui.UIPushButton.NORMAL,"openVolice.png")
    end

    n_voiceOpen = n_voiceOpen * -1
end


function MainScene:onEnter()
end

function MainScene:onExit()
end



return MainScene
