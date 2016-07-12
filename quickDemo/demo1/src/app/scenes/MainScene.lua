
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    self.sp = display.newSprite("flattop.png")
        :pos(display.cx, display.cy)
        :scale(1.5)
        :addTo(self)

    while true do
    	--todo
    end
    transition.moveTo(self.sp, {time = 0.5, x = display.cx, y = display.height - 100})
    transition.scaleTo(self.sp, {time = 1, scale = 2})
    transition.scaleTo(self.sp, {time = 1, scale = 0.1})
end


function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
