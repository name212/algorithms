package.path = package.path .. ';vendor/share/lua/5.1/?.lua'

local lu = require 'luaunit'

local SingleLinkedList = require 'single_linked_list'
local Sorts = require 'sorts'
local LinkedStack = require 'stack'
local BinaryTree = require 'binary_tree'

local LinkedListTest = require 'tests.list_test'
local MergeTestSuit = require 'tests.merge_test'
local SortsTestSuit = require 'tests.sorts_test'
local StackTestSuit = require 'tests.stack_test'

local BinaryTreeSuit = require 'tests.binary_tree_test'

local function merge_wrapped() 
    return function (seq, start_indx, middle_indx, end_indx)
        return Sorts:_merge_proc(seq, start_indx, middle_indx, end_indx)
    end
end
local function wrap_sort(name)
    return function (seq) 
        return Sorts[name](Sorts, seq)
    end
end

TestSingleLinkedList = LinkedListTest:create(SingleLinkedList)
TestMerge = MergeTestSuit:create(merge_wrapped())
TestInsertSort = SortsTestSuit:create(wrap_sort('insert'))
TestBubleSort = SortsTestSuit:create(wrap_sort('buble'))
TestSelectionSort = SortsTestSuit:create(wrap_sort('selection'))
TestMergeSort = SortsTestSuit:create(wrap_sort('merge'))
TestMergeSort = SortsTestSuit:create(wrap_sort('quick'))
TestLinkedStack = StackTestSuit:create(LinkedStack)
TestBinaryTree = BinaryTreeSuit:create(BinaryTree)

lu.LuaUnit.run()