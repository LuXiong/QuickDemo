
local MainScene = class("MainScene", function()
	return display.newScene("MainScene")
	end)

chessPieces = {}
chessBoard = {}
chessHistory = {}

max_zorder = 1

img_selected = cc.ui.UIImage.new("selected.png")
    			:align(display.CENTER, 54, 54)
    			:setLayoutSize(109, 109)
    			:setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)


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

    self.side = -1
    self.voiceOpen = 1
    self.n_redTime = 0
    self.n_blackTime = 0
    -- self.schedulert = scheduler.scheduleGlobal(scheduleUpdateScene, 1)

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
                            -- body
                        end)
                        :addTo(self.floor)

    self.btn_pause = cc.ui.UIPushButton.new("pause.jpg")
                        :align(display.CENTER, display.width/2+551*chessScale, display.height/2)
                        :onButtonClicked(function()
                            -- body
                        end)
                        :addTo(self.floor)


    self.btn_regret = cc.ui.UIPushButton.new("regret.jpg")
                        :align(display.CENTER, display.width/2+551*chessScale, display.height/2-100)
                        :addTo(self.floor)



	self:initPieces()
	self:initBoard()
	self:refreshBoard(true)
 	img:setTouchEnabled(true)
	img:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)

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
                            if (self.side == 1 and chessBoard[m][n] <= 16)  or (self.side == -1 and chessBoard[m][n] > 16)  then
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
                            self.side = self.side * -1

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
    -- body
end

function MainScene:schedulePause( ... )
    -- body
end

function MainScene:scheduleExchange( ... )
    -- body
end

function MainScene:scheduleUpdateScene(dt)
    self.n_redTime = self.n_redTime+dt
    print(tostring(self.n_redTime))
end

function MainScene:changeVoiceState()
    if self.voiceOpen >0 then
        self.img_voice:setButtonImage(cc.ui.UIPushButton.NORMAL,"closeVolice.png")
    else
        self.img_voice:setButtonImage(cc.ui.UIPushButton.NORMAL,"openVolice.png")
    end

    self.voiceOpen = self.voiceOpen * -1
end

function pushHistory()
    local top = chessHistory[#chessHistory]
    if top then
        --todo
    end

end

function popHistory()
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

function MainScene:initPieces()
    img_bc1 = cc.ui.UIImage.new("bche.png")
                -- :align(display.CENTER, display.cx, 500)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_bm1 = cc.ui.UIImage.new("bma.png")
                -- :align(display.CENTER, display.cx, display.cy)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_bx1 = cc.ui.UIImage.new("bxiang.png")
                -- :align(display.CENTER, display.cx, display.cy)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_bs1 = cc.ui.UIImage.new("bshi.png")
                -- :align(display.CENTER, display.cx, 500)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_bc2 = cc.ui.UIImage.new("bche.png")
                -- :align(display.CENTER, display.cx, 500)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_bm2 = cc.ui.UIImage.new("bma.png")
                -- :align(display.CENTER, display.cx, display.cy)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_bx2 = cc.ui.UIImage.new("bxiang.png")
                -- :align(display.CENTER, display.cx, display.cy)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_bs2 = cc.ui.UIImage.new("bshi.png")
                -- :align(display.CENTER, display.cx, 500)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_bj = cc.ui.UIImage.new("bjiang.png")
                -- :align(display.CENTER, display.cx, display.cy)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_bp1 = cc.ui.UIImage.new("bpao.png")
                -- :align(display.CENTER, display.cx, display.cy)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_bp2 = cc.ui.UIImage.new("bpao.png")
                -- :align(display.CENTER, display.cx, display.cy)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_bz1 = cc.ui.UIImage.new("bzu.png")
                -- :align(display.CENTER, display.cx, 500)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_bz2 = cc.ui.UIImage.new("bzu.png")
                -- :align(display.CENTER, display.cx, 500)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_bz3 = cc.ui.UIImage.new("bzu.png")
                -- :align(display.CENTER, display.cx, 500)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_bz4 = cc.ui.UIImage.new("bzu.png")
                -- :align(display.CENTER, display.cx, 500)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_bz5 = cc.ui.UIImage.new("bzu.png")
                -- :align(display.CENTER, display.cx, 500)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_rc1 = cc.ui.UIImage.new("rche.png")
                -- :align(display.CENTER, display.cx, 500)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_rm1 = cc.ui.UIImage.new("rma.png")
                -- :align(display.CENTER, display.cx, display.cy)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_rx1 = cc.ui.UIImage.new("rxiang.png")
                -- :align(display.CENTER, display.cx, display.cy)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_rs1 = cc.ui.UIImage.new("rshi.png")
                -- :align(display.CENTER, display.cx, 500)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_rc2 = cc.ui.UIImage.new("rche.png")
                -- :align(display.CENTER, display.cx, 500)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_rm2= cc.ui.UIImage.new("rma.png")
                -- :align(display.CENTER, display.cx, display.cy)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_rx2 = cc.ui.UIImage.new("rxiang.png")
                -- :align(display.CENTER, display.cx, display.cy)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_rs2 = cc.ui.UIImage.new("rshi.png")
                -- :align(display.CENTER, display.cx, 500)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_rj = cc.ui.UIImage.new("rshuai.png")
                -- :align(display.CENTER, display.cx, display.cy)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_rp1 = cc.ui.UIImage.new("rpao.png")
                -- :align(display.CENTER, display.cx, display.cy)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_rp2 = cc.ui.UIImage.new("rpao.png")
                -- :align(display.CENTER, display.cx, display.cy)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_rz1 = cc.ui.UIImage.new("rbing.png")
                -- :align(display.CENTER, display.cx, 500)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_rz2 = cc.ui.UIImage.new("rbing.png")
                -- :align(display.CENTER, display.cx, 500)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_rz3 = cc.ui.UIImage.new("rbing.png")
                -- :align(display.CENTER, display.cx, 500)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_rz4 = cc.ui.UIImage.new("rbing.png")
                -- :align(display.CENTER, display.cx, 500)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
    img_rz5 = cc.ui.UIImage.new("rbing.png")
                -- :align(display.CENTER, display.cx, 500)
                :setLayoutSize(109, 109)
                :setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)

    print("tag:"..img_selected:getTag())

    chessPieces = {img_rc1,img_rc2,img_rm1,img_rm2,img_rp1,img_rp2,img_rz1,img_rz2,img_rz3,img_rz4,img_rz5,img_rx1,img_rx2,img_rs1,img_rs2,img_rj,img_bc1,img_bc2,img_bm1,img_bm2,img_bp1,img_bp2,img_bz1,img_bz2,img_bz3,img_bz4,img_bz5,img_bx1,img_bx2,img_bs1,img_bs2,img_bj}

end

function MainScene:initBoard()
    chessBoard  = {{1,0,0,7,0,0,27,0,0,18},{3,0,5,0,0,0,0,22,0,20},{12,0,0,8,0,0,26,0,0,29},{14,0,0,0,0,0,0,0,0,31},{16,0,0,9,0,0,25,0,0,32},{15,0,0,0,0,0,0,0,0,30},{13,0,0,10,0,0,24,0,0,28},{4,0,6,0,0,0,0,21,0,19},{2,0,0,11,0,0,23,0,0,17},{0,0}}
end

return MainScene
