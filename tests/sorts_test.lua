local lu = require 'luaunit'
local equals = lu.assertEquals

local SortsTestSuit = {}

local function _copy(seq)
    local t = {}

    for i = 1, #seq do 
        t[i] = seq[i]
    end

    return t
end

function SortsTestSuit:create(alg_to_test) 
    local t = {}
    for key, method in pairs(SortsTestSuit) do
        t[key] = method
    end

    t.alg_to_test = alg_to_test

    return t
end

function SortsTestSuit:testUnsorted()
    local test_seq = {22, 15, 22, 46, 108, 0, 1 ,4, 3, 2, 106}
    local res = self.alg_to_test(test_seq)
    equals(res, {0, 1, 2, 3, 4, 15, 22, 22, 46, 106, 108})
end

function SortsTestSuit:testSorted()
    local test_seq = {1, 2, 3, 4, 5}
    local res = self.alg_to_test(_copy(test_seq))
    equals(res, test_seq)
end

function SortsTestSuit:testUnsortedDecrease()
    local test_seq = {5, 4, 3, 2, 1}
    local res = self.alg_to_test(test_seq)
    equals(res, {1, 2, 3, 4, 5})
end

function SortsTestSuit:testGuards()
    equals(self.alg_to_test({}), {})
    equals(self.alg_to_test({1}), {1})
    equals(self.alg_to_test({2, 1}), {1, 2})
    equals(self.alg_to_test({1, 1, 1, 1}), {1, 1, 1, 1})
end

return SortsTestSuit