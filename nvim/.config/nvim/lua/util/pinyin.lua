local data = require("util.pinyin_data")

local M = {}

local chars_by_syllable
local chars_by_initial
local chars_by_double
local syllables_by_initial

local regex_magic = {
  ["\\"] = true,
  ["."] = true,
  ["^"] = true,
  ["$"] = true,
  ["*"] = true,
  ["+"] = true,
  ["?"] = true,
  ["("] = true,
  [")"] = true,
  ["["] = true,
  ["]"] = true,
  ["{"] = true,
  ["}"] = true,
  ["|"] = true,
}

local initial_keys = {
  zh = "v",
  ch = "i",
  sh = "u",
}

local initials = {
  "zh",
  "ch",
  "sh",
  "b",
  "p",
  "m",
  "f",
  "d",
  "t",
  "n",
  "l",
  "g",
  "k",
  "h",
  "j",
  "q",
  "x",
  "r",
  "z",
  "c",
  "s",
  "y",
  "w",
}

local final_keys = {
  a = "a",
  ai = "l",
  an = "j",
  ang = "h",
  ao = "k",
  e = "e",
  ei = "z",
  en = "f",
  eng = "g",
  ia = "w",
  ian = "m",
  iang = "d",
  iao = "c",
  ie = "x",
  i = "i",
  ["in"] = "n",
  ing = "y",
  iong = "s",
  iu = "q",
  o = "o",
  ong = "s",
  ou = "b",
  ua = "w",
  uai = "y",
  uan = "r",
  uang = "d",
  ue = "t",
  ui = "v",
  u = "u",
  un = "p",
  uo = "o",
  v = "v",
  ve = "t",
}

local syllable_aliases = {
  n = { "en" },
  ng = { "eng" },
}

local function iter_chars(text)
  return tostring(text or ""):gmatch("[%z\001-\127\194-\244][\128-\191]*")
end

local function normalize_query(query)
  query = vim.trim(tostring(query or "")):lower()
  return query:gsub("\195\188", "v"):gsub("\195\156", "v"):gsub("u:", "v")
end

local function escape_regex(text)
  local ret = {}
  for ch in iter_chars(text) do
    ret[#ret + 1] = regex_magic[ch] and ("\\" .. ch) or ch
  end
  return table.concat(ret)
end

local function escape_char_class(text)
  return (text:gsub("([%]%^%-\\])", "\\%1"))
end

local function split_pinyin(py)
  for _, initial in ipairs(initials) do
    if py:sub(1, #initial) == initial then
      return initial, py:sub(#initial + 1)
    end
  end
  return "", py
end

local function final_key(final, initial)
  if (initial == "j" or initial == "q" or initial == "x" or initial == "y") and final == "u" then
    return final_keys.v
  end
  return final_keys[final]
end

local function zero_initial_code(final)
  local key = final_keys[final]
  if not key then
    return nil
  end

  if #final == 2 then
    return final
  end
  return final:sub(1, 1) .. key
end

local function double_codes(py)
  if py == "n" then
    return { "en" }
  end
  if py == "ng" then
    return { "eg" }
  end

  local initial, final = split_pinyin(py)
  local key = final_key(final, initial)
  local codes = {}

  if initial == "" then
    local code = zero_initial_code(final)
    if code then
      codes[#codes + 1] = code
    end
  elseif key then
    codes[#codes + 1] = (initial_keys[initial] or initial) .. key
    if (initial == "j" or initial == "q" or initial == "x" or initial == "y") and final == "u" then
      codes[#codes + 1] = initial .. "u"
    end
  end

  return codes
end

local function syllable_forms(py)
  local ret = { py }
  vim.list_extend(ret, syllable_aliases[py] or {})
  return ret
end

local function combine_codes(codes_by_syllable, limit)
  local ret = { "" }
  for _, codes in ipairs(codes_by_syllable) do
    if #codes == 0 then
      return {}
    end
    local next_ret = {}
    for _, prefix in ipairs(ret) do
      for _, code in ipairs(codes) do
        next_ret[#next_ret + 1] = prefix .. code
        if #next_ret >= limit then
          ret = next_ret
          goto continue
        end
      end
    end
    ret = next_ret
    ::continue::
  end
  return ret
end

local function class_for(chars)
  if not chars or chars == "" then
    return nil
  end
  return "[" .. escape_char_class(chars) .. "]"
end

local function add_alt(alts, seen, regex)
  if regex and regex ~= "" and not seen[regex] then
    seen[regex] = true
    alts[#alts + 1] = regex
  end
end

local function ensure_reverse()
  if chars_by_syllable then
    return
  end

  chars_by_syllable = {}
  chars_by_initial = {}
  chars_by_double = {}
  syllables_by_initial = {}

  for ch, py in pairs(data.char) do
    if py:match("^[a-zv]+$") then
      for _, form in ipairs(syllable_forms(py)) do
        chars_by_syllable[form] = (chars_by_syllable[form] or "") .. ch
      end

      local initial = py:sub(1, 1)
      chars_by_initial[initial] = (chars_by_initial[initial] or "") .. ch

      for _, code in ipairs(double_codes(py)) do
        chars_by_double[code] = (chars_by_double[code] or "") .. ch
      end
    end
  end

  for py in pairs(chars_by_syllable) do
    local initial = py:sub(1, 1)
    syllables_by_initial[initial] = syllables_by_initial[initial] or {}
    table.insert(syllables_by_initial[initial], py)
  end

  for _, list in pairs(syllables_by_initial) do
    table.sort(list, function(a, b)
      if #a == #b then
        return a < b
      end
      return #a > #b
    end)
  end
end

local function segment_full_pinyin(query, limit)
  ensure_reverse()

  local memo = {}
  local function go(pos)
    if pos > #query then
      return { {} }
    end
    if memo[pos] then
      return memo[pos]
    end

    local ret = {}
    local first = query:sub(pos, pos)
    for _, syllable in ipairs(syllables_by_initial[first] or {}) do
      if query:sub(pos, pos + #syllable - 1) == syllable then
        for _, rest in ipairs(go(pos + #syllable)) do
          local seq = { syllable }
          vim.list_extend(seq, rest)
          ret[#ret + 1] = seq
          if #ret >= limit then
            memo[pos] = ret
            return ret
          end
        end
      end
    end

    memo[pos] = ret
    return ret
  end

  return go(1)
end

local function sequence_regex(seq, source)
  local ret = {}
  for _, key in ipairs(seq) do
    local part = class_for(source[key])
    if not part then
      return nil
    end
    ret[#ret + 1] = part
  end
  return table.concat(ret)
end

local function initial_regex(query)
  ensure_reverse()

  local seq = {}
  for i = 1, #query do
    local initial = query:sub(i, i)
    if not chars_by_initial[initial] then
      return nil
    end
    seq[#seq + 1] = initial
  end
  return sequence_regex(seq, chars_by_initial)
end

local function double_regex(query)
  ensure_reverse()

  if #query % 2 ~= 0 then
    return nil
  end

  local seq = {}
  for i = 1, #query, 2 do
    local code = query:sub(i, i + 1)
    if not chars_by_double[code] then
      return nil
    end
    seq[#seq + 1] = code
  end
  return sequence_regex(seq, chars_by_double)
end

function M.index_text(text)
  local full = {}
  local initials_text = {}
  local doubles_by_syllable = {}

  for ch in iter_chars(text) do
    local py = data.char[ch]
    if py then
      local forms = syllable_forms(py)
      full[#full + 1] = forms[1]
      initials_text[#initials_text + 1] = py:sub(1, 1)
      doubles_by_syllable[#doubles_by_syllable + 1] = double_codes(py)
      for i = 2, #forms do
        full[#full + 1] = forms[i]
      end
    end
  end

  if #full == 0 then
    return ""
  end

  local chunks = {
    table.concat(full),
    table.concat(initials_text),
    table.concat(full, " "),
  }

  for _, code in ipairs(combine_codes(doubles_by_syllable, 16)) do
    chunks[#chunks + 1] = code
  end

  return table.concat(chunks, " ")
end

function M.to_rg_regex(query)
  query = normalize_query(query)
  if query == "" then
    return ""
  end

  if not query:match("^[a-zv]+$") then
    return escape_regex(query)
  end

  ensure_reverse()

  local alts = {}
  local seen = {}

  for _, seq in ipairs(segment_full_pinyin(query, 32)) do
    add_alt(alts, seen, sequence_regex(seq, chars_by_syllable))
  end

  add_alt(alts, seen, initial_regex(query))
  add_alt(alts, seen, double_regex(query))
  add_alt(alts, seen, escape_regex(query))

  if #alts == 1 then
    return alts[1]
  end
  return "(?:" .. table.concat(alts, "|") .. ")"
end

function M.file_transform(item)
  local index = M.index_text(item.file or item.text)
  if index ~= "" then
    item.text = tostring(item.text or "") .. " " .. index
  end
end

function M.grep_filter_transform(picker, filter)
  local pattern, args = Snacks.picker.util.parse(filter.search or "")
  pattern = normalize_query(pattern)

  if pattern ~= "" then
    filter.search = M.to_rg_regex(pattern)
    if #args > 0 then
      filter.search = filter.search .. " -- " .. table.concat(args, " ")
    end
    picker.opts.regex = true
  end
end

local function root()
  return LazyVim and LazyVim.root({ normalize = true }) or vim.fn.getcwd()
end

function M.files()
  Snacks.picker.files({
    cwd = root(),
    hidden = true,
    title = "Find Files (Pinyin)",
    transform = M.file_transform,
  })
end

function M.grep()
  Snacks.picker.grep({
    cwd = root(),
    hidden = true,
    regex = true,
    title = "Grep (Pinyin)",
    filter = {
      transform = function(...)
        return M.grep_filter_transform(...)
      end,
    },
  })
end

return M
