local LinkedList = {}
LinkedList.__index = LinkedList


local function create_node(self, prev_node, el)
    local n = {
        next = nil,
        el   = el,
    }
    
    if prev_node then
        prev_node.next = n        
    else
        n.next = self.first
        self.first = n
    end 
    
end

local function _find(self, indx)
    local prev = nil
    local cur = self.first     

    if not cur or (indx and indx < 1) then
        return nil, nil
    end
    
    
    local cur_indx = 1
    local found = false
    while cur.next do
        if indx and indx == cur_indx then
            found = true            
            break            
        end        
        prev = cur
        cur = cur.next
        cur_indx = cur_indx + 1
    end
    
     if indx and indx > cur_indx then
        return nil, nil
    end 

    return cur, prev
end

function LinkedList:new()
    local t = {
        first = nil,
    }
    setmetatable(t, LinkedList)
    return t
end

function LinkedList:from(ar)
    local l = LinkedList:new()
    
    for _, v in ipairs(ar) do 
        l:add(v)
    end
    
    return l
end

function LinkedList:add(el, indx)
    local last_node = _find(self, indx)
    create_node(self, last_node, el)
end

function LinkedList:find(indx)
    local node = _find(self, indx)
    return node and node.el
end

function LinkedList:delete(indx)
    local node, prev_node = _find(self, indx)
    if not node or not prev_node then
        return false    
    end
    
    local next_node = node.next
    prev_node.next = next_node
    return true
end

function LinkedList:foreach(fun) 
    local cur = self.first     

    if not cur then
        return nil
    end
    
    
    while cur do
        fun(cur.el) 
        cur = cur.next
    end

    return cur
end

function LinkedList:reverse() 
    local prev = nil
    local cur = self.first
    if not cur then
        return nil
    end
    local nxt = cur and cur.next

    while nxt do 
        cur.next = prev
        prev = cur
        cur = nxt
        nxt = cur.next
    end
    
    cur.next = prev
    self.first = cur
end

return LinkedList
