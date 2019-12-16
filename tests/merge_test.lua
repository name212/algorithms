local lu = require 'luaunit'
local equals = lu.assertEquals

local MergeTestSuit = {}

local floor = math.floor

local function _do_merge(self, seq) 
    local l = #seq
    local q = floor(l / 2)
    return self.alg_to_test(seq, 1, q, l)
end

function MergeTestSuit:create(alg_to_test) 
    local t = {}
    for key, method in pairs(MergeTestSuit) do
        t[key] = method
    end

    t.alg_to_test = alg_to_test

    return t
end

function MergeTestSuit:testOne() 
    equals(_do_merge(self, {1}), {1})
end

function MergeTestSuit:testTwo()
    equals(_do_merge(self, {1, 2}), {1, 2})
end

function MergeTestSuit:testEven() 
    equals(_do_merge(self, {5, 7, 9, 11, 4, 6, 10, 12}), {4, 5, 6, 7, 9, 10, 11, 12})
end

function MergeTestSuit:testOdd()
    equals(_do_merge(self, {5, 7, 9, 6, 8, 10, 12}), {5, 6, 7, 8, 9, 10, 12})
end

return MergeTestSuit