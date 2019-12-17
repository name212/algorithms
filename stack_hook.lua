local error = error

local NotLimitedStack = {}
NotLimitedStack.__index = NotLimitedStack

function NotLimitedStack:new()
    -- да, типа синглетон
    return self
end

function NotLimitedStack:beforePush(stack)
    
end

function NotLimitedStack:afterPush(stack)
    
end

function NotLimitedStack:afterPop(stack)
    
end

local LimitedStack = {}
LimitedStack.__index = LimitedStack

function LimitedStack:new(max_deep)
    local t = {}
    setmetatable(t, LimitedStack)
    t:reset(max_deep)
    return t
end

function LimitedStack:beforePush(stack)
    if self.cur_count >= self.max then
        error('Stack overflow', 1)
        return nil
    end
end

function LimitedStack:afterPush(stack)
    self.cur_count = self.cur_count + 1
end

function LimitedStack:afterPop(stack)
    local cur_count = self.cur_count
    if cur_count > 0 then
        self.cur_count = cur_count - 1
    end
end

function LimitedStack:reset(new_deep)
    local max_to_set = new_deep or self.max
    max_to_set = tonumber(max_to_set)

    if not max_to_set or max_to_set < 1 then
        error('Incorrect deep')
    end
    self.max = max_to_set
    self.cur_count = 0
end


return {
    NotLimitedStack = NotLimitedStack,
    LimitedStack = LimitedStack
}