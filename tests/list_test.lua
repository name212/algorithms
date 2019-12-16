local function prn(e) 
    io.write(e, ' ')
end

local function print_list(l) 
    l:foreach(prn)
    print('')
end

local function test_del(module, indx)
    local dl = module:from{1, 2, 3, 4, 5}
    dl:delete(indx)
    print_list(dl)
end


return function (module) 
    local l1 = module:from{1}
    local l2 = module:from{1, 2}
    local l3 = module:from{1, 2, 3}
    local l4 = module:from{1, 2, 3, 4}
    local l5 = module:from{1, 2, 3, 4, 5}
    print('Init')
    
    print_list(l1)
    print_list(l2)
    print_list(l3)
    print_list(l4)
    print_list(l5)

    print('Find')
    print(l5:find(1))
    print(l5:find(3))
    print(l5:find(5))
    print(l5:find(0))
    print(l5:find(13))

    l1:reverse()
    l2:reverse()
    l3:reverse()
    l4:reverse()
    l5:reverse()

    print('Reverse')
    print_list(l1)
    print_list(l2)
    print_list(l3)
    print_list(l4)
    print_list(l5)
    
    print('Del')
    test_del(module, 0)
    test_del(module, 1)
    test_del(module, 2)
    test_del(module, 3)
    test_del(module, 4)
    test_del(module, 5)
    test_del(module, 6)
end
