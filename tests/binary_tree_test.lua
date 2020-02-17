local lu = require 'luaunit'
local equals = lu.assertEquals
local is_nil = lu.assertNil
local not_nil = lu.assertNotNil

local BinaryTestSuite = {}

local function _to_sorted_asc_list(w) 
    local l = {}
    w:walk_recursive(function (v) 
        table.insert(l, v)
    end)
    return l
end

function BinaryTestSuite:create(module_to_test) 
    local t = {}
    for key, method in pairs(BinaryTestSuite) do
        t[key] = method
    end

    t.module = module_to_test

    return t
end

function BinaryTestSuite:setUp() 
    --        8
    --     /    \
    --    3      10
    --   / \       \
    --  1   6      14
    --     / \    / 
    --    4   7  13
    local t = self.module:new()
    t:insert(8)
    t:insert(3)
    t:insert(6)
    t:insert(1)
    t:insert(10)
    t:insert(7)
    t:insert(14)
    t:insert(13)
    t:insert(4)

    self.t = t
end

function BinaryTestSuite:testAdding() 
    local l = _to_sorted_asc_list(self.t)
    equals(l, {1, 3, 4, 6, 7, 8, 10, 13, 14})
end

function BinaryTestSuite:testFind()
    local t = self.t
    not_nil(t:find_node(8))
    not_nil(t:find_node(6))
    not_nil(t:find_node(13))
    is_nil(t:find_node(100))
end

function BinaryTestSuite:testMinimum()
    local t = self.t
    local min =  
    equals(t:minimum().v, 1)

    local founded_node = t:find_node(6)
    equals(t:minimum(founded_node).v, 4)

    founded_node = t:find_node(13)
    equals(t:minimum(founded_node).v, 13)
end

function BinaryTestSuite:testDelete()
    --        8
    --     /    \
    --    3      10
    --   / \       \
    --  1   6      14
    --     / \    / 
    --    4   7  13

    -- case 3
    local t = self.t
    t:delete(8)
    equals(
        _to_sorted_asc_list(t), 
        {1, 3, 4, 6, 7, 10, 13, 14}
    )

    --       10
    --     /    \
    --    3      14
    --   / \     / 
    --  1   6   13 
    --     / \   
    --    4   7  


    -- -- case 1
    t:delete(14)
    equals(
        _to_sorted_asc_list(t), 
        {1, 3, 4, 6, 7, 10, 13}
    )

    --       10
    --     /    \
    --    3      13
    --   / \      
    --  1   6    
    --     / \   
    --    4   7 

    -- -- case 4
    t:delete(3)
    equals(
        _to_sorted_asc_list(t), 
        {1, 4, 6, 7, 10, 13}
    )

    --       10
    --     /    \
    --    4      13
    --   / \      
    --  1   6    
    --       \   
    --        7 


    -- -- case 2
    t:delete(6)
    equals(
        _to_sorted_asc_list(t), 
        {1, 4, 7, 10, 13}
    )

    -- --       10
    -- --     /    \
    -- --    4      13
    -- --   / \      
    -- --  1   7    
end

return BinaryTestSuite