
local MainScene = class("MainScene", function()
	return display.newScene("MainScene")
	end)

local ChessBoard = require("app.scenes.ChessBoard")
local chessBoard = ChessBoard.chessBoard
local chesspieces = ChessBoard.chesspieces

for k,v in pairs(chesspieces) do
    print(k,v)
end

local img_selected = ChessBoard.img_selected

max_zorder = 1

n_stack_top = 0




function MainScene:refreshBoard(isadd)

	if isadd then
		img_selected:addTo(img)
	end

	img_selected:hide()

	for i=1,9 do
		for j=1,10 do
			
			local piece = chessPieces[math.abs(chessBoard[i][j])]
			if piece then
                piece:align(display.CENTER, (i-1)*109+116, (j-1)*109+64)
				if isadd then
					piece:addTo(img)
				end
				local lastX = chessBoard[10][1]
				local lastY = chessBoard[10][2]
				if lastX>0 and lastY>0 then
					if chessBoard[lastX][lastY]>0 then
						img_selected:align(display.CENTER, (lastX-1)*109+116, (lastY-1)*109+64)
						img_selected:show()
					end
					
				end
			end
			
		end
	end

	-- img_selected:addTo(img_rz5)
end

function MainScene:ctor()



    n_side = -1
    self.voiceOpen = 1
    n_redTime = 0
    n_blackTime = 0
    scheduler = require("framework.scheduler")  
    n_pause = 1

	local chessScale = 1
	if display.height<1111 then
		chessScale = display.height/1111
	end


    self.floor = display.newScale9Sprite("floor.jpg",0,0,CCSize(display.width, display.height))
            :align(display.CENTER, display.width/2, display.height/2)
            :addTo(self)

	img = cc.ui.UIImage.new("background.png")
			:align(display.CENTER, 551*chessScale, 556*chessScale)
			:setLayoutSize(1101*chessScale-20, 1111*chessScale-20)
			:setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
			:addTo(self)

    self.img_voice = cc.ui.UIPushButton.new("openVolice.png")
                        :align(display.CENTER, display.width-50, display.height-50)
                        :onButtonClicked(function()
                            self:changeVoiceState()
                        end)
                        :addTo(self.floor)
    -- self.img_voice:setRotation(90)
    self.lbl_red = cc.ui.UILabel.new({text = "00:00",size = 30, color = cc.c3b(120, 120, 120)})
                        :align(display.CENTER, display.width/2+551*chessScale, 150)
                        :addTo(self.floor)
    self.lbl_redName = cc.ui.UILabel.new({text = "Xlook",size = 42, color = cc.c3b(255, 0, 0)})
                        :align(display.CENTER, display.width/2+551*chessScale, 90)
                        :addTo(self.floor) 
    self.lbl_black = cc.ui.UILabel.new({text = "00:00",size = 30, color = cc.c3b(120, 120, 120)})
                        :align(display.CENTER, display.width/2+551*chessScale, display.height - 150)
                        :addTo(self.floor)
    self.lbl_redName = cc.ui.UILabel.new({text = "电脑",size = 42, color = cc.c3b(0, 0, 0)})
                        :align(display.CENTER, display.width/2+551*chessScale, display.height - 90)
                        :addTo(self.floor) 

    self.btn_start = cc.ui.UIPushButton.new("new.jpg")
                        :align(display.CENTER, display.width/2+551*chessScale, display.height/2+100)
                        :onButtonClicked(function()
                            self:scheduleStart()
                        end)
                        :addTo(self.floor)

    self.btn_pause = cc.ui.UIPushButton.new("pause.jpg")
                        :align(display.CENTER, display.width/2+551*chessScale, display.height/2)
                        :onButtonClicked(function()
                            self:schedulePause()
                        end)
                        :addTo(self.floor)


    self.btn_regret = cc.ui.UIPushButton.new("regret.jpg")
                        :align(display.CENTER, display.width/2+551*chessScale, display.height/2-100)
                        :addTo(self.floor)

	self:refreshBoard(true)
 	img:setTouchEnabled(true)
	img:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)

                    if n_pause == 1 then
                        return false
                    end

        			local m = math.floor((event.x/chessScale-62)/109)+1
        			local n = math.floor((event.y/chessScale-21)/109)+1

                    -- print("display:"..tostring(display.width).."   "..tostring(display.height))
                    -- print("event:"..tostring(event.x).."   "..tostring(event.y))
                    -- print("img:"..tostring(img:getPositionX()).."   "..tostring(img:getPositionY()))

                    local preM = chessBoard[10][1]
                    local preN = chessBoard[10][2]

                    --定义动作
                    local movement = nil

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



function MainScene:moveChess(custom,fromM,fromeN,target,toM,toN)
    local chesspiece = chessPieces[custom]  
    max_zorder = max_zorder+1
    chesspiece:zorder(max_zorder)
    local piecescale = 109/56

    if target>0 then
        chessPieces[target]:removeSelf()
        transition.scaleTo(chesspiece, {time = 0.3, scale = piecescale*2})
        transition.scaleTo(chesspiece, {time = 0.1, delay = 0.3, scale = piecescale})
    end

    
    transition.moveTo(chesspiece,{time = 0.4, x = (toM-1)*109+116, y = (toN-1)*109+64})

    chessBoard[toM][toN] = custom
    chessBoard[fromM][fromeN] = 0

    img_selected:hide()


    --符合规则，马规则车规则等
    --车规则
    -- local target = chessPieces[ chessBoard[fromX][fromY] ]
    -- transition.moveTo(target, {time = 0.3, x = toX*109+116, y = toY*109+64})
end

function MainScene:scheduleStart( ... )
    print("start")
    n_pause = 0
    schedule_useTime = scheduler.scheduleGlobal(function()
        self:scheduleUpdateScene()
    end, 1)
end

function MainScene:schedulePause( ... )
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

function MainScene:scheduleExchange( ... )
    -- body
end

function MainScene:scheduleUpdateScene()
    if n_side<0 then
        n_redTime = n_redTime+1
        self.lbl_red:setString(timeToString(n_redTime))
    else
        n_blackTime = n_blackTime+1
        self.lbl_black:setString(timeToString(n_blackTime))
    end



    -- n_redTime = n_redTime+dt
    print("time"..tostring(n_redTime).."   "..tostring(n_blackTime))
    -- if n_redTime>3 then
    --     scheduler.unscheduleGlobal(schedule_useTime)
    -- end
end

function timeToString(dt)
    local s = dt%60
    local h = dt/60

    return string.format("%02d:%02d", h,s)
end

function MainScene:changeVoiceState()
    if self.voiceOpen >0 then
        self.img_voice:setButtonImage(cc.ui.UIPushButton.NORMAL,"closeVolice.png")
    else
        self.img_voice:setButtonImage(cc.ui.UIPushButton.NORMAL,"openVolice.png")
    end

    self.voiceOpen = self.voiceOpen * -1
end

function MainScene:pushHistory()
    -- local top = chessHistory[#chessHistory]
    

end

function MainScene:popHistory()
end

function MainScene:onEnter()
end

function MainScene:onExit()
end



return MainScene
