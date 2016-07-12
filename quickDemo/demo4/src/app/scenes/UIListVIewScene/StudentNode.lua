--Class
StudentNode = class("StudentNode", cc.ui.UIListViewItem)

-- function StudentNode:new (o,data,rect)
--   o = o or {}
--   setmetatable(o, self)
--   self.__index = self
--   self.data = data
--   self.rect = rect
--   return o
-- end 

function StudentNode:ctor(data,rect)
  self.data = data
  self.rect = rect
  print(tostring(rect.width))
  self:setData()
  return self
end

function StudentNode:setData()
  if not self.data then
    return
  end

  node = cc.Node.new()

  local bound = {x = 0, y = 0, width = 400, height = 50}
  local lbl_name =  cc.ui.UILabel.new({
    UILabelType = 2, 
    text = self.data.name, 
    size = 24})
  :align(display.CENTER, bound.x+bound.width/2-100, bound.y+bound.height/2)
  :addTo(node)
  local lbl_age = cc.ui.cc.ui.UILayout.new({
    UILabelType = 2,
    text = self.data.age,
    size = 18
    })  
  :align(display.CENTER, bound.x+bound.width/2+100, bound.y+bound.height/2)
  :addTo(node)


end