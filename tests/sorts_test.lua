local floor = math.floor

local function _copy(seq)
    local t = {}

    for i = 1, #seq do 
        t[i] = seq[i]
    end

    return t
end

local function _eq(s1, s2) 
    if #s1 ~= #s2 then
        return false
    end
    
    for i = 1, #s1 do 
        if s1[i] ~= s2[i] then
            return false
        end
    end

    return true
end

local function _print_seq(seq)
    local concat = table.concat
    local str = concat{
        "{", concat(seq, ', '), "}"
    }
    print(str)    
end

local function _test_sort_res(self, name, tp, original_seq, result_seq)
    print("**********\n", "Test sort ", name, " ", tp, "\n", "Original sequence: ")
    _print_seq(original_seq)
    local r1 = self[name](self, _copy(original_seq))
    print("\n Result: ")
    _print_seq(r1)
    local msg = "!! FAIL !!"
    if _eq(result_seq, r1) then
        msg = "ok"
    end

    print("\n", msg, "\n**********\n")
end

local function _full_test(self, name)
    local test_seq = {22, 15, 22, 46, 108, 0, 1 ,4, 3, 2, 106}
    local rest_seq = {0, 1, 2, 3, 4, 15, 22, 22, 46, 106, 108}
    local aboved = {1, 2, 3, 4, 5}
    _test_sort_res(self, name, "rnd", test_seq, rest_seq)
    _test_sort_res(self, name, "full_unsorted", {5, 4, 3, 2, 1}, aboved)
    _test_sort_res(self, name, "full_sorted", aboved, aboved)
end

local function _test_merge_procedure(self, name, seq, seq_to_test)
    print("**********\n", "Merge procedure ", name, "\n", "Original sequence: ")
    _print_seq(seq)
    local l = #seq
    local q = floor(l / 2)
    local res = self:_merge_proc(_copy(seq), 1, q, l)
    local msg = "!! FAIL !!"        
    if _eq(res, seq_to_test) then
        msg = "ok"    
    end
    _print_seq(res)
    print(msg, "\n")
end

local function _test_merge(self) 
    _test_merge_procedure(self, 'one', {1}, {1})
    _test_merge_procedure(self, 'two', {1, 2}, {1, 2})
    _test_merge_procedure(self, 'three', {1, 2, 3}, {1, 2, 3})
    _test_merge_procedure(self, 'even array', {5, 7, 9, 11, 4, 6, 10, 12}, {4, 5, 6, 7, 9, 10, 11, 12})
    _test_merge_procedure(self, 'odd array', {5, 7, 9, 11, 6, 10, 12}, {5, 5, 6, 7, 9, 10, 12})
end

return function(self)
    _full_test(self, 'insert')
    _full_test(self, 'selection')
    _test_merge(self)
    _full_test(self, 'merge')
    _full_test(self, 'buble')
end
