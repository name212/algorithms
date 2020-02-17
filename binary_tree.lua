local BinaryTree = {}
BinaryTree.__index = BinaryTree

local LEFT, RIGHT = 'left', 'right'

local function create_node(v, p)
    return {
        v = v,
        parent = p,
        [LEFT] = nil,
        [RIGHT] = nil,
    }
end

local function get_child_key(node, v) 
    local key
    if v <= node.v then
        key = LEFT
    else
        key = RIGHT
    end
    return key 
end

local function replace_node(self, to_replace, on_replace)
    local p = to_replace.parent
    -- меняем корневой
    if not p then
        self.root = on_replace
        -- смотрим гда находился узел
    elseif p.left == to_replace then
        p.left = on_replace
    else
        p.right = on_replace
    end

    -- выставляем родительский
    if on_replace then
        on_replace.parent = p
    end

end

function BinaryTree:new()
    local t = {
        root = nil
    }
    setmetatable(t, BinaryTree)
    return t
end

function BinaryTree:insert(v)
    local cur = self.root
    local key = LEFT
    local parent_for_v = cur
    while cur ~= nil do
        parent_for_v = cur 
        key = get_child_key(cur, v)
        cur = cur[key]
    end

    if parent_for_v == nil then
        self.root = create_node(v)
        return true
    end

    parent_for_v[key] = create_node(v, parent_for_v)
    return true
end

function BinaryTree:minimum(node)
    if not node then
        node = self.root
    end

    while node[LEFT] do 
        node = node[LEFT]
    end

    return node
end

function BinaryTree:find_node(v) 
    local cur = self.root
    while cur ~= nil do 
        local cur_v = cur.v
        if cur_v == v then
            return cur
        end

        local k = get_child_key(cur, v)
        cur = cur[k] 
    end

    return nil
end

function BinaryTree:walk_recursive(func) 
    local function w(node) 
        if node ~= nil then 
            w(node.left)
            func(node.v)
            w(node.right)
        end
    end

    w(self.root)
end

local function walk_direct(self, func, direct) 
    direct = direct or LEFT
    local anoter_direct = RIGHT
    if direct == RIGHT then
        anoter_direct = LEFT
    end
    local c = self.root
    if not c then
        return
    end

    local st = {c}
    local push = table.insert
    local pop = table.remove

    while #st > 0 do 
        local cur_next = c[direct]
        if not cur_next then
            local proc_node = pop(st)
            func(proc_node.v)
            c = proc_node
            local another_next = c[anoter_direct]
            if another_next then
                push(st, another_next)
                c = another_next
            end
        else
            push(st, cur_next)
            c = cur_next
        end
    end
end

function BinaryTree:walk_desc(func) 
    walk_direct(self, func, RIGHT)
end

function BinaryTree:walk_asc(func)
    walk_direct(self, func, LEFT)
end

function BinaryTree:delete(v) 
    local removed_node = self:find_node(v)
    if not removed_node then
        return false
    end


    if not removed_node.left then
        -- если удаляемая нода лист
        -- то мы попадем сюда  removed_node.right == nil
        replace_node(self, removed_node, removed_node.right)
        return true
    elseif not removed_node.right then
        replace_node(self, removed_node, removed_node.left)
        return true
    else
        -- здесь есть левый и правый потомок 
        local minimum_node = self:minimum(removed_node.right)
        -- сначала проверим, что  у правого нет левого потомка
        -- и тогда мы можем просто поменять правым потомком удаляемый узел
        -- а левый потомок удаленного становится левым потомком правого
        -- еще один кейз - у правого потомка удаляемого узла есть левый потомок
        -- так как мы должны найти левому потомку удаленного узла родителя
        -- то им станет минимальная нода правого узла, так как 
        -- right > removed_node, поэтому минимальный (самы левый узел правого)
        -- будет больше левого (для удаляемого) именно минимальный и встанет 
        -- на место удаленного узла. теперь если у минимального узла был правый
        -- то он станет левым для родителя минимального

        if minimum_node.parent ~= removed_node then
            -- случай с непустым левым
            -- тут мы ставим на место минимального его правого потомка, чтобы он не стал сиротой
            -- простую замену мы можем произвести, так как у минимального нет левого потомка
            -- и тут же назначаем правого ребенка для минимального узла как правый узел удаленного
            replace_node(self, minimum_node, minimum_node.right)
        
            minimum_node.right = removed_node.right
            minimum_node.right.parent = minimum_node
        end
    
        -- ну а тут по сути пристраиваем левого ребенка удаленного узла
        -- и заменяем удаленный узел на найденный минимальный
        -- да, третий кейз когда надо заменить удаленный на правый тут работает 
        -- так как minimum_node здесь может быть right
        replace_node(self, removed_node, minimum_node)
        minimum_node.left = removed_node.left
        minimum_node.left.parent = minimum_node
    end
    
    return true
end

return BinaryTree