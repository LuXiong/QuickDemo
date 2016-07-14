
local MainScene = class("MainScene", function()
	return display.newScene("MainScene")
	end)

chessPieces = {}
chessBoard = {}

img_selected = cc.ui.UIImage.new("selected.png")
    			:align(display.CENTER, 54, 54)
    			:setLayoutSize(109, 109)
    			:setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)



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

function MainScene:refreshBoard(isadd)
	if isadd then
		img_selected:addTo(img)
	end

	img_selected:hide()

	for i=1,9 do
		for j=1,10 do
			
			local piece = chessPieces[math.abs(chessBoard[i][j])]
			if piece then
				if isadd then
					piece:align(display.CENTER, (i-1)*109+116, (j-1)*109+64)
					:addTo(img)
				end
				local lastX = chessBoard[10][1]
				local lastY = chessBoard[10][2]
				if lastX>0 and lastY>0 then
					if chessBoard[lastX][lastY]>0 then
						img_selected:align(display.CENTER, (lastX-1)*109+116, (lastY-1)*109+75)
						img_selected:show()
					end
					
					-- print("chessBoard[i][j]:"..tostring(chessBoard[i][j]))
					-- img_selected:addTo(piece,1,-1)
				-- else
				-- 	img_selected:removeSelf()
				end
			end
			
		end
	end

	-- img_selected:addTo(img_rz5)
end

function MainScene:ctor()

	local chessScale = 1;
	if display.height<1111 then
		chessScale = display.height/1111
	end


	print("displaySize:"..tostring(display.width).."   "..tostring(display.height))

	img = cc.ui.UIImage.new("background.png")
			:align(display.CENTER, 551*chessScale, 556*chessScale)
			:setLayoutSize(1101*chessScale, 1111*chessScale)
			:setLayoutSizePolicy(display.FIXED_SIZE, display.FIXED_SIZE)
			:setLayoutPadding(0, 0, 0, 0)
			:addTo(self)
	local width,height = img:getLayoutSize()
	local top,right,bottom,left = img:getLayoutPadding()
	local contentw, contenth = img:getContentSize()

	print("img layoutSize:"..tostring(width).."   "..tostring(height))
	print("img padding:"..tostring(top).."   "..tostring(right).."   "..tostring(bottom).."   "..tostring(left))
	print("img position:"..tostring(img:getPositionX()).."   "..tostring(img:getPositionY()).."   "..tostring(img.width).."   "..tostring(img.height))
	print("img contentSize:"..tostring(contentw).."   "..tostring(contenth))

	self:initPieces()
	self:initBoard()
	self:refreshBoard(true)
	-- chessBoard[1][1] = chessBoard[1][1]*-1
 --    self:refreshBoard(false)
 	img:setTouchEnabled(true)
	img:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)

        			local m = math.floor((event.x/chessScale-62)/109)+1
        			local n = math.floor((event.y/chessScale-21)/109)+1
        			print("x:"..tostring(event.x).."    y:"..tostring(event.y))
        			print("m:"..tostring(m).."    n:"..tostring(n))
        			chessBoard[10][1] = m
        			chessBoard[10][2] = n
        			-- print("chessBoard:"..tostring(chessBoard[1][2]))
     --    			local piecee = chessPieces[chessBoard[m][n]]
					-- if piecee then
					-- 	chessBoard[m][n] = chessBoard[m][n]*-1
						self:refreshBoard(false)
					-- end
        		return false
    end)


end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
