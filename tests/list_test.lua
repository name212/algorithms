local lu = require 'luaunit'
local equals = lu.assertEquals
local is_nil = lu.assertNil

local ListTestSuite = {}

function ListTestSuite:create(module_to_test) 
    local t = {}
    for key, method in pairs(ListTestSuite) do
        t[key] = method
    end

    t.module = module_to_test

    return t
end

function ListTestSuite:setUp() 
    local module = self.module
    self.l1 = module:from{1}
    self.l2 = module:from{1, 2}
    self.l3 = module:from{1, 2, 3}
    self.l4 = module:from{1, 2, 3, 4}
    self.l5 = module:from{1, 2, 3, 4, 5}
end

function ListTestSuite:testAdd()
    local v = {
        [self.l1] = {1,},
        [self.l2] = {1, 2,},
        [self.l3] = {1, 2, 3,},
        [self.l4] = {1, 2, 3, 4,},
        [self.l5] = {1, 2, 3, 4, 5,},
    }

    for l, to_comp in pairs(v) do
        equals(l:to_seq(), to_comp)
    end
end

function ListTestSuite:testFind()
    local l5 = self.l5
    equals(l5:find(1), 1)
    equals(l5:find(3), 3)
    equals(l5:find(5), 5)
    is_nil(l5:find(0))
    is_nil(l5:find(13))
end

function ListTestSuite:testReverse()
    local v = {
        [self.l1] = {1,},
        [self.l2] = {2, 1},
        [self.l3] = {3, 2, 1},
        [self.l4] = {4, 3, 2, 1},
        [self.l5] = {5, 4, 3, 2, 1},
    }

    for l, to_comp in pairs(v) do
        l:reverse()
        equals(l:to_seq(), to_comp)
    end
end

local function one_delete(self, orig, indx) 
    local t = self.module:from(orig)
    t:delete(indx)
    return t:to_seq()
end

function ListTestSuite:testDelete()
    local module = self.module

    local t1 = module:new()
    t1:delete(1)
    equals(t1, {})
    equals(one_delete(self, {1}, 0), {1})
    equals(one_delete(self, {1, 2, 3, 4, 5}, 0), {1, 2, 3, 4, 5})
    equals(one_delete(self, {1, 2, 3, 4, 5}, 1), {2, 3, 4, 5})
    equals(one_delete(self, {1, 2, 3, 4, 5}, 2), {1, 3, 4, 5})
    equals(one_delete(self, {1, 2, 3, 4, 5}, 5), {1, 2, 3, 4})
    equals(one_delete(self, {1, 2, 3, 4, 5}, 6), {1, 2, 3, 4, 5})
    local t2 = module:from{1, 2, 3, 4, 5}
    t2:delete(2)
    t2:delete(2)
    equals(t2:to_seq(), {1, 4, 5})
end

return ListTestSuite