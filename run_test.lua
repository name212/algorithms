local lu = require 'luaunit'

package.path = package.path .. ';vendor/share/lua/5.1/?.lua'

local SingleLinkedList = require 'single_linked_list'
local Sorts = require 'sorts'
local LinkedListTest = require 'tests.list_test'

TestSingleLinkedList = LinkedListTest:create(SingleLinkedList)

lu.LuaUnit.run()
