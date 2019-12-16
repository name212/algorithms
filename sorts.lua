local floor = math.floor

local Sorts = {}
Sorts.__index = Sorts

function Sorts:_merge_proc(seq, start_indx, middle_indx, end_indx)
    local n1 = middle_indx - start_indx + 1
    local n2 = end_indx - middle_indx
    local L, R = {}, {}

    for i = 1, n1 do 
        local indx = start_indx + i - 1
        L[i] = seq[indx] 
    end

    for i = 1, n2 do 
        local indx = middle_indx + i
        R[i] = seq[indx] 
    end

    L[n1 + 1] = 100500
    R[n2 + 1] = 100500
    local i = 1
    local j = 1

    for c = start_indx, end_indx do 
        local left = L[i]
        local right = R[j]

        if left < right then
            seq[c] = left
            i = i + 1
        else
            seq[c] = right 
            j = j + 1            
        end
    end

    return seq
end

function Sorts:insert(seq)
    local seq_l = #seq

    for i = 2, seq_l do
        local key = seq[i]
        local j = i - 1
        while j > 0 and seq[j] > key do 
            seq[j + 1] = seq[j]
            j = j - 1
        end
        seq[j + 1] = key
    end
    return seq
end


function Sorts:selection(seq)
    local seq_len = #seq
    for i = 1, #seq - 1 do 
        -- минимальным элементом принимаем первый текущий элемент по циклу
        -- ибо предыдущие уже отсортированы
        local min_elem, indx_to_swap = seq[i], i
        -- ищем в оставшемся массиве минимальный элемент 
        for j = i, #seq do 
            local cur = seq[j]
            if min_elem > cur then
                min_elem = cur
                indx_to_swap = j        
            end         
        end
        -- ставим на место текущего элемента минимальный
        -- а на место минимального текущий (обмениваем)
        seq[i], seq[indx_to_swap] = seq[indx_to_swap], seq[i]
    end
    
    return seq
end

function Sorts:merge(seq)
    local this = self
    local _merge_proc = self._merge_proc
    local function _merge_sort(A, p, r)
        if p < r then
            local midl = (p + r) / 2
            local q = floor(midl)
            _merge_sort(A, p, q)
            _merge_sort(A, q + 1, r)
            _merge_proc(this, A, p, q, r)        
        end
    end

    _merge_sort(seq, 1, #seq)
    return seq    
end

function Sorts:buble(seq) 
  local l = #seq
  for i = 1, l - 1 do 
      for j = l, i + 1, -1 do 
        if seq[j] < seq[j - 1] then 
           seq[j], seq[j - 1] = seq[j - 1], seq[j] 
        end
      end
  end
  return seq
end


return Sorts
