local SingleLinkedList = {}
SingleLinkedList.__index = SingleLinkedList


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

function SingleLinkedList:new()
    local t = {
        first = nil,
    }
    setmetatable(t, SingleLinkedList)
    return t
end

function SingleLinkedList:from(ar)
    local l = SingleLinkedList:new()
    
    for _, v in ipairs(ar) do 
        l:add(v)
    end
    
    return l
end

function SingleLinkedList:add(el, indx)
    local last_node = _find(self, indx)
    create_node(self, last_node, el)
end

function SingleLinkedList:find(indx)
    local node = _find(self, indx)
    return node and node.el
end

function SingleLinkedList:delete(indx)
    local node, prev_node = _find(self, indx)
    if not node then
        return false    
    end

    local next_node = node.next
    if not prev_node then
        self.first.next = nil
        self.first = next_node
    else
        prev_node.next = next_node
    end
    -- for gc
    node.next = nil

    return true
end

function SingleLinkedList:foreach(fun) 
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

function SingleLinkedList:reverse() 
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

function SingleLinkedList:to_seq()
    local tmp = {}
    local sup = function(el) table.insert(tmp, el) end
    self:foreach(sup)
    return tmp
end

return SingleLinkedList
