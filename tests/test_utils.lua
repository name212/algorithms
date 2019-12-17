local TestUtils = {}

function TestUtils.create_suit_for_module(suit)
    suit.create = function (self, module_to_test) 
        local t = {}
        for key, method in pairs(suit) do
            t[key] = method
        end

        t.module = module_to_test

        return t
    end
end

return TestUtils