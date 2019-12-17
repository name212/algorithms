local LinkedStack = {}
LinkedStack.__index = LinkedStack

local function create_node(cur_top, el)
    return {
        el = el,
        next = cur_top
    }
end

function LinkedStack:new()
    local t = {
        top_el = nil
    }

    setmetatable(t, LinkedStack)
    return t
end

function LinkedStack:from(ar) 
    local st = self:new()
    for i = #ar, 1, -1 do
        st:push(ar[i])
    end
    return st
end

function LinkedStack:push(el) 
    self.top_el = create_node(self.top_el, el)
end

function LinkedStack:pop() 
    local top = self.top_el
    if not top then
        return nil
    end
    self.top_el = top.next
     -- for gc
    top.next = nil
    return top.el
end

function LinkedStack:is_empty() 
    return self.top_el == nil
end

function LinkedStack:top() 
    local top = self.top_el
    return top and top.el
end

function LinkedStack:to_seq()
    local t = {}
    local cur_top = self.top_el
    while cur_top do 
        table.insert(t, cur_top.el)
        cur_top = cur_top.next
    end

    return t
end

return LinkedStack