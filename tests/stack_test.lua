local TestUtils = require 'tests.test_utils'
local lu = require 'luaunit'
local equals = lu.assertEquals
local is_nil = lu.assertNil

local StackTestSuit = {}

TestUtils.create_suit_for_module(StackTestSuit)

function StackTestSuit:testFrom()
    local module = self.module
    equals(module:from{1, 2, 3, 4}:to_seq(), {1, 2, 3, 4})
    equals(module:new():to_seq(), {})
end

function StackTestSuit:testPush() 
    local module = self.module
    local t1 = module:new()
    t1:push(1)
    equals(t1:to_seq(), {1})
    t1:push(2)
    equals(t1:to_seq(), {2, 1})
end

function StackTestSuit:testPop() 
    local module = self.module
    local t1 = module:new()
    t1:push(1)
    equals(t1:pop(), 1)
    equals(t1:to_seq(), {})
    local t2 = module:new()

    t2:push(1)
    t2:push(2)

    equals(t2:pop(), 2)
    equals(t2:to_seq(), {1})
    equals(t2:pop(), 1)
    is_nil(t2:pop())
end

function StackTestSuit:testTop()
    local module = self.module
    local t1 = module:new()
    t1:push(1)
    equals(t1:top(), 1)
    equals(t1:to_seq(), {1})
    
    t1:push(2)
    equals(t1:top(), 2)
    equals(t1:to_seq(), {2, 1})
end

function StackTestSuit:testIsEmpty()
    local module = self.module 
    equals(module:new():is_empty(), true)

    local t1 = module:new()
    t1:push(1)
    t1:push(2)
    equals(t1:is_empty(), false)
    t1:pop()
    t1:pop()

    equals(t1:is_empty(), true)
end

return StackTestSuit