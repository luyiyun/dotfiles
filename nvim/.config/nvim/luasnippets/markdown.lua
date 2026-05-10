-- Generated from the uploaded Obsidian LaTeX Suite snippets.
-- Put this file at: ~/.config/nvim/luasnippets/markdown.lua
-- It is designed for Markdown / Quarto math notes with LuaSnip.

local ls = require("luasnip")
local parse = ls.parser.parse_snippet
local s = ls.snippet
local f = ls.function_node

local snippets = {}

local function has_any(str, chars)
  for c in chars:gmatch(".") do
    if str:find(c, 1, true) then
      return true
    end
  end
  return false
end

local function cursor()
  local p = vim.api.nvim_win_get_cursor(0)
  return p[1] - 1, p[2]
end

local function in_vimtex_math()
  return vim.fn.exists("*vimtex#syntax#in_mathzone") == 1 and vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

local function in_treesitter_math()
  local ok, node = pcall(vim.treesitter.get_node, { ignore_injections = false })
  if not ok or not node then
    return false
  end
  while node do
    local typ = node:type()
    if typ:match("latex") or typ:match("math") or typ:match("equation") then
      return true
    end
    node = node:parent()
  end
  return false
end

local function in_syntax_math()
  local row, col = cursor()
  local ok, stack = pcall(vim.fn.synstack, row + 1, col + 1)
  if not ok then
    return false
  end
  for _, id in ipairs(stack) do
    local name = vim.fn.synIDattr(id, "name")
    if name:match("[mM]ath") or name:match("tex") or name:match("latex") then
      return true
    end
  end
  return false
end

local function in_mathzone()
  return in_vimtex_math() or in_treesitter_math() or in_syntax_math()
end

local function not_mathzone()
  return not in_mathzone()
end

-- Heuristic for Markdown/Quarto display math fences. Good enough for choosing
-- multiline matrix snippets inside $$ ... $$; inline math falls back to in_mathzone().
local function in_display_math()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_get_lines(0, 0, row, false)
  local open = false
  for _, line in ipairs(lines) do
    local _, dollars = line:gsub("%$%$", "")
    if dollars % 2 == 1 then
      open = not open
    end
    if line:find("\\%[") then
      open = true
    end
    if line:find("\\%]") then
      open = false
    end
  end
  return open
end

local function in_inline_math()
  return in_mathzone() and not in_display_math()
end

local function cond_for(opts)
  if opts:find("M", 1, true) then
    return in_display_math
  end
  if opts:find("n", 1, true) then
    return in_inline_math
  end
  if opts:find("m", 1, true) then
    return in_mathzone
  end
  if opts:find("t", 1, true) then
    return not_mathzone
  end
  return nil
end

local function word_trig_for(trig)
  return trig:match("^[%a_][%w_]*$") ~= nil
end

local function add_parse(trig, body, opts, priority)
  local ctx = {
    trig = trig,
    snippetType = opts:find("A", 1, true) and "autosnippet" or "snippet",
    wordTrig = word_trig_for(trig),
    priority = priority or 1000,
  }
  local cond = cond_for(opts)
  if cond then
    ctx.condition = cond
    ctx.show_condition = cond
  end
  table.insert(snippets, parse(ctx, body, { trim_empty = false, dedent = false }))
end

local simple = {
  { trig = "mk", body = "\\$$1\\$", opts = "tA" },
  { trig = "dm", body = "\\$\\$\n$1\n\\$\\$", opts = "tAw" },
  { trig = "Dm", body = "\\$\\$\n$1\n\\$\\$", opts = "tAw" },
  { trig = "beg", body = "\\begin{$1}\n$2\n\\end{$1}", opts = "mA" },
  { trig = "@a", body = "\\alpha", opts = "mA" },
  { trig = "@A", body = "\\Alpha", opts = "mA" },
  { trig = "@b", body = "\\beta", opts = "mA" },
  { trig = "@B", body = "\\Aeta", opts = "mA" },
  { trig = "@c", body = "\\chi", opts = "mA" },
  { trig = "@C", body = "\\Chi", opts = "mA" },
  { trig = "@g", body = "\\gamma", opts = "mA" },
  { trig = "@G", body = "\\Gamma", opts = "mA" },
  { trig = "@d", body = "\\delta", opts = "mA" },
  { trig = "@D", body = "\\Delta", opts = "mA" },
  { trig = "@e", body = "\\epsilon", opts = "mA" },
  { trig = "@E", body = "\\Epsilon", opts = "mA" },
  { trig = ":e", body = "\\varepsilon", opts = "mA" },
  { trig = ":E", body = "\\varepsilon", opts = "mA" },
  { trig = "@z", body = "\\zeta", opts = "mA" },
  { trig = "@Z", body = "\\zeta", opts = "mA" },
  { trig = "@t", body = "\\theta", opts = "mA" },
  { trig = "@T", body = "\\Theta", opts = "mA" },
  { trig = "@k", body = "\\kappa", opts = "mA" },
  { trig = "@K", body = "\\kappa", opts = "mA" },
  { trig = "@l", body = "\\lambda", opts = "mA" },
  { trig = "@L", body = "\\Lambda", opts = "mA" },
  { trig = "@m", body = "\\mu", opts = "mA" },
  { trig = "@M", body = "\\mu", opts = "mA" },
  { trig = "@r", body = "\\rho", opts = "mA" },
  { trig = "@R", body = "\\rho", opts = "mA" },
  { trig = "@s", body = "\\sigma", opts = "mA" },
  { trig = "@S", body = "\\Sigma", opts = "mA" },
  { trig = "ome", body = "\\omega", opts = "mA" },
  { trig = "@o", body = "\\omega", opts = "mA" },
  { trig = "@O", body = "\\Omega", opts = "mA" },
  { trig = "@u", body = "\\upsilon", opts = "mA" },
  { trig = "@U", body = "\\Upsilon", opts = "mA" },
  { trig = "te", body = "\\text{$1}", opts = "m" },
  { trig = "text", body = "\\text{$1}", opts = "mA" },
  { trig = "bf", body = "\\mathbf{$1}", opts = "mA" },
  { trig = "bs", body = "\\boldsymbol{$1}", opts = "mA" },
  { trig = "sr", body = "^{2}", opts = "mA" },
  { trig = "cb", body = "^{3}", opts = "mA" },
  { trig = "rd", body = "^{$1}$2", opts = "mA" },
  { trig = "_", body = "_{$1}$2", opts = "mA" },
  { trig = "sq", body = "\\sqrt{ $1 }$2", opts = "mA" },
  { trig = "frac", body = "\\frac{$1}{$2}$3", opts = "mA" },
  { trig = "ee", body = "e^{ $1 }$2", opts = "mA" },
  { trig = "rm", body = "\\mathrm{$1}$2", opts = "mA" },
  { trig = "conj", body = "^{*}", opts = "mA" },
  { trig = "trace", body = "\\mathrm{Tr}", opts = "mA" },
  { trig = "det", body = "\\det", opts = "mA" },
  { trig = "re", body = "\\mathrm{Re}", opts = "mA" },
  { trig = "im", body = "\\mathrm{Im}", opts = "mA" },
  { trig = "pmb", body = "\\pmb{$1}", opts = "mA" },
  { trig = "bar", body = "\\bar{$1}$2", opts = "mA" },
  { trig = "hat", body = "\\hat{$1}$2", opts = "mA" },
  { trig = "dot", body = "\\dot{$1}$2", opts = "mA" },
  { trig = "ddot", body = "\\ddot{$1}$2", opts = "mA", priority = 2 },
  { trig = "cdot", body = "\\cdot", opts = "mA", priority = 2 },
  { trig = "vec", body = "\\vec{$1}$2", opts = "mA" },
  { trig = "tilde", body = "\\tilde{$1}$2", opts = "mA" },
  { trig = "und", body = "\\underline{$1}$2", opts = "mA" },
  { trig = "U", body = "\\underbrace{ ${LS_SELECT_RAW} }_{ $1 }", opts = "mA" },
  { trig = "O", body = "\\overbrace{ ${LS_SELECT_RAW} }^{ $1 }", opts = "mA" },
  { trig = "B", body = "\\underset{ $1 }{ ${LS_SELECT_RAW} }", opts = "mA" },
  { trig = "C", body = "\\cancel{ ${LS_SELECT_RAW} }", opts = "mA" },
  { trig = "K", body = "\\cancelto{ $1 }{ ${LS_SELECT_RAW} }", opts = "mA" },
  { trig = "S", body = "\\sqrt{ ${LS_SELECT_RAW} }", opts = "mA" },
  { trig = "circ", body = "\\circ", opts = "mA" },
  { trig = "ooo", body = "\\infty", opts = "mA" },
  { trig = "sum", body = "\\sum", opts = "mA" },
  { trig = "Sum", body = "\\sum\\limits_{$1}^{$2}$3", opts = "mA" },
  { trig = "prod", body = "\\prod", opts = "mA" },
  { trig = "Prod", body = "\\prod\\limits_{$1}^{$2}$3", opts = "mA" },
  { trig = "lim", body = "\\lim_{ ${1:n} \\to ${2:\\infty} } $3", opts = "mA" },
  { trig = "linf", body = "\\mathop{\\lim\\inf}_{ ${1:n} \\to ${2:\\infty} } $3", opts = "mA" },
  { trig = "lsup", body = "\\mathop{\\lim\\sup}_{ ${1:n} \\to ${2:\\infty} } $3", opts = "mA" },
  { trig = "+-", body = "\\pm", opts = "mA" },
  { trig = "-+", body = "\\mp", opts = "mA" },
  { trig = "...", body = "\\dots", opts = "mA" },
  { trig = "<->", body = "\\leftrightarrow ", opts = "mA" },
  { trig = "->", body = "\\to", opts = "mA" },
  { trig = "ae->", body = "\\overset{ a.e. }{ \\longrightarrow }", opts = "mA" },
  { trig = "as->", body = "\\overset{ a.s. }{ \\longrightarrow }", opts = "mA" },
  { trig = "au->", body = "\\overset{ a.u. }{ \\longrightarrow }", opts = "mA" },
  { trig = "mu->", body = "\\overset{ \\mu }{ \\longrightarrow }", opts = "mA" },
  { trig = "p->", body = "\\overset{ P }{ \\longrightarrow }", opts = "mA" },
  { trig = "d->", body = "\\overset{ d }{ \\longrightarrow }", opts = "mA" },
  { trig = "w->", body = "\\overset{ \\omega }{ \\longrightarrow }", opts = "mA" },
  { trig = "l->", body = "\\overset{ L_{${1:p}} }{ \\longrightarrow }", opts = "mA" },
  { trig = "<-", body = "\\leftarrow", opts = "mA" },
  { trig = "|->", body = "\\mapsto", opts = "mA" },
  { trig = "invs", body = "^{-1}", opts = "mA" },
  { trig = "sm", body = "\\setminus", opts = "mA" },
  { trig = "||", body = "\\mid", opts = "mA" },
  { trig = "and", body = "\\cap", opts = "mA" },
  { trig = "orr", body = "\\cup", opts = "mA" },
  { trig = "And", body = "\\bigcap_{$1}^{$2}$3", opts = "mA" },
  { trig = "Orr", body = "\\bigcup_{$1}^{$2}$3", opts = "mA" },
  { trig = "inn", body = "\\in", opts = "mA" },
  { trig = "notin", body = "\\not\\in", opts = "mA" },
  { trig = "\\subset eq", body = "\\subseteq", opts = "mA" },
  { trig = "eset", body = "\\emptyset", opts = "mA" },
  { trig = "set", body = "\\{ $1 \\}$2", opts = "mA" },
  { trig = "=>", body = "\\implies", opts = "mA" },
  { trig = "=<", body = "\\impliedby", opts = "mA" },
  { trig = "iff", body = "\\iff", opts = "mA" },
  { trig = "\\leq>", body = "\\iff", opts = "mA" },
  { trig = "e\\xi sts", body = "\\exists", opts = "mA", priority = 1 },
  { trig = "===", body = "\\equiv", opts = "mA" },
  { trig = "Sq", body = "\\square", opts = "mA" },
  { trig = "!=", body = "\\neq", opts = "mA" },
  { trig = ">=", body = "\\geq", opts = "mA" },
  { trig = "<=", body = "\\leq", opts = "mA" },
  { trig = ">>", body = "\\gg", opts = "mA" },
  { trig = "<<", body = "\\ll", opts = "mA" },
  { trig = "~~", body = "\\sim", opts = "mA" },
  { trig = "\\sim ~", body = "\\approx", opts = "mA" },
  { trig = "prop", body = "\\propto", opts = "mA" },
  { trig = "nabl", body = "\\nabla", opts = "mA" },
  { trig = "del", body = "\\nabla", opts = "mA" },
  { trig = "xx", body = "\\times", opts = "mA" },
  { trig = "**", body = "\\cdot", opts = "mA" },
  { trig = "para", body = "\\parallel", opts = "mA" },
  { trig = "contain", body = "\\supset", opts = "mA" },
  { trig = "Contain", body = "\\subset", opts = "mA" },
  { trig = "up", body = "\\uparrow", opts = "m" },
  { trig = "down", body = "\\downarrow", opts = "m" },
  { trig = "inf", body = "\\inf", opts = "mA" },
  { trig = "sup", body = "\\sup", opts = "mA" },
  { trig = "Inf", body = "\\inf\\limits_{$1} $2", opts = "mA" },
  { trig = "Sup", body = "\\sup\\limits_{$1} $2", opts = "mA" },
  { trig = "xnn", body = "x_{n}", opts = "mA" },
  { trig = "xii", body = "x_{i}", opts = "mA" },
  { trig = "xjj", body = "x_{j}", opts = "mA" },
  { trig = "xp1", body = "x_{n+1}", opts = "mA" },
  { trig = "ynn", body = "y_{n}", opts = "mA" },
  { trig = "yii", body = "y_{i}", opts = "mA" },
  { trig = "yjj", body = "y_{j}", opts = "mA" },
  { trig = "mcal", body = "\\mathcal{$1}$2", opts = "mA" },
  { trig = "mbb", body = "\\mathbb{$1}$2", opts = "mA" },
  { trig = "ell", body = "\\ell", opts = "mA" },
  { trig = "lll", body = "\\ell", opts = "mA" },
  { trig = "LL", body = "\\mathcal{L}", opts = "mA" },
  { trig = "HH", body = "\\mathcal{H}", opts = "mA" },
  { trig = "CC", body = "\\mathbb{C}", opts = "mA" },
  { trig = "RR", body = "\\mathbb{R}", opts = "mA" },
  { trig = "ZZ", body = "\\mathbb{Z}", opts = "mA" },
  { trig = "NN", body = "\\mathbb{N}", opts = "mA" },
  { trig = "II", body = "\\mathbb{1}", opts = "mA" },
  { trig = "\\mathbb{1}I", body = "\\hat{\\mathbb{1}}", opts = "mA" },
  { trig = "AA", body = "\\mathcal{A}", opts = "mA" },
  { trig = "BB", body = "\\mathbf{B}", opts = "mA" },
  { trig = "EE", body = "\\mathbb{E}", opts = "mA" },
  { trig = "QQ", body = "\\mathbb{Q}", opts = "mA" },
  { trig = ":i", body = "\\mathbf{i}", opts = "mA" },
  { trig = ":j", body = "\\mathbf{j}", opts = "mA" },
  { trig = ":k", body = "\\mathbf{k}", opts = "mA" },
  { trig = ":x", body = "\\hat{\\mathbf{x}}", opts = "mA" },
  { trig = ":y", body = "\\hat{\\mathbf{y}}", opts = "mA" },
  { trig = ":z", body = "\\hat{\\mathbf{z}}", opts = "mA" },
  { trig = "par", body = "\\frac{ \\partial ${1:y} }{ \\partial ${2:x} } $3", opts = "m" },
  { trig = "pa2", body = "\\frac{ \\partial^{2} ${1:y} }{ \\partial ${2:x}^{2} } $3", opts = "mA" },
  { trig = "pa3", body = "\\frac{ \\partial^{3} ${1:y} }{ \\partial ${2:x}^{3} } $3", opts = "mA" },
  { trig = "ddt", body = "\\frac{d}{dt} ", opts = "mA" },
  { trig = "oinf", body = "\\int_{0}^{\\infty} $1 \\, d${2:x} $3", opts = "mA" },
  { trig = "infi", body = "\\int_{-\\infty}^{\\infty} $1 \\, d${2:x} $3", opts = "mA" },
  { trig = "dint", body = "\\int_{${1:0}}^{${2:\\infty}} $3 \\, d${4:x} $5", opts = "mA" },
  { trig = "oint", body = "\\oint", opts = "mA" },
  { trig = "iiint", body = "\\iiint", opts = "mA" },
  { trig = "iint", body = "\\iint", opts = "mA" },
  { trig = "int", body = "\\int $1 \\, d${2:x} $3", opts = "mA" },
  { trig = "kbt", body = "k_{B}T", opts = "mA" },
  { trig = "hba", body = "\\hbar", opts = "mA" },
  { trig = "dag", body = "^{\\dagger}", opts = "mA" },
  { trig = "o+", body = "\\oplus ", opts = "mA" },
  { trig = "ox", body = "\\otimes ", opts = "mA" },
  { trig = "ot\\mathrm{Im}es", body = "\\otimes ", opts = "mA" },
  { trig = "bra", body = "\\bra{$1} $2", opts = "mA" },
  { trig = "ket", body = "\\ket{$1} $2", opts = "mA" },
  { trig = "brk", body = "\\braket{ $1 | $2 } $3", opts = "mA" },
  { trig = "outp", body = "\\ket{${1:\\psi}} \\bra{${1:\\psi}} $2", opts = "mA" },
  { trig = "pu", body = "\\pu{ $1 }", opts = "mA" },
  { trig = "msun", body = "M_{\\odot}", opts = "mA" },
  { trig = "solm", body = "M_{\\odot}", opts = "mA" },
  { trig = "cee", body = "\\ce{ $1 }", opts = "mA" },
  { trig = "iso", body = "{}^{${1:4}}_{${2:2}}${3:He}", opts = "mA" },
  { trig = "hel4", body = "{}^{4}_{2}He ", opts = "mA" },
  { trig = "hel3", body = "{}^{3}_{2}He ", opts = "mA" },
  { trig = "pmat", body = "\\begin{pmatrix}\n$1\n\\end{pmatrix}", opts = "MA" },
  { trig = "bmat", body = "\\begin{bmatrix}\n$1\n\\end{bmatrix}", opts = "MA" },
  { trig = "Bmat", body = "\\begin{Bmatrix}\n$1\n\\end{Bmatrix}", opts = "MA" },
  { trig = "vmat", body = "\\begin{vmatrix}\n$1\n\\end{vmatrix}", opts = "MA" },
  { trig = "Vmat", body = "\\begin{Vmatrix}\n$1\n\\end{Vmatrix}", opts = "MA" },
  { trig = "matrix", body = "\\begin{matrix}\n$1\n\\end{matrix}", opts = "MA" },
  { trig = "pmat", body = "\\begin{pmatrix}$1\\end{pmatrix}", opts = "nA" },
  { trig = "bmat", body = "\\begin{bmatrix}$1\\end{bmatrix}", opts = "nA" },
  { trig = "Bmat", body = "\\begin{Bmatrix}$1\\end{Bmatrix}", opts = "nA" },
  { trig = "vmat", body = "\\begin{vmatrix}$1\\end{vmatrix}", opts = "nA" },
  { trig = "Vmat", body = "\\begin{Vmatrix}$1\\end{Vmatrix}", opts = "nA" },
  { trig = "matrix", body = "\\begin{matrix}$1\\end{matrix}", opts = "nA" },
  { trig = "case", body = "\\begin{cases}\n$1\n\\end{cases}", opts = "mA" },
  { trig = "align", body = "\\begin{align}\n$1\n\\end{align}", opts = "mA" },
  { trig = "array", body = "\\begin{array}\n$1\n\\end{array}", opts = "mA" },
  { trig = "avg", body = "\\langle $1 \\rangle $2", opts = "mA" },
  { trig = "norm", body = "\\lvert $1 \\rvert $2", opts = "mA", priority = 1 },
  { trig = "Norm", body = "\\lVert $1 \\rVert $2", opts = "mA", priority = 1 },
  { trig = "ceil", body = "\\lceil $1 \\rceil $2", opts = "mA" },
  { trig = "floor", body = "\\lfloor $1 \\rfloor $2", opts = "mA" },
  { trig = "mod", body = "|$1|$2", opts = "mA" },
  { trig = "(", body = "(${LS_SELECT_RAW})", opts = "mA" },
  { trig = "[", body = "[${LS_SELECT_RAW}]", opts = "mA" },
  { trig = "{", body = "{${LS_SELECT_RAW}}", opts = "mA" },
  { trig = "(", body = "($1)$2", opts = "mA" },
  { trig = "{", body = "{$1}$2", opts = "mA" },
  { trig = "[", body = "[$1]$2", opts = "mA" },
  { trig = "lr(", body = "\\left( $1 \\right) $2", opts = "mA" },
  { trig = "lr|", body = "\\left| $1 \\right| $2", opts = "mA" },
  { trig = "lr{", body = "\\left\\{ $1 \\right\\} $2", opts = "mA" },
  { trig = "lr[", body = "\\left[ $1 \\right] $2", opts = "mA" },
  { trig = "lra", body = "\\left< $1 \\right> $2", opts = "mA" },
  {
    trig = "tayl",
    body = "${1:f}(${2:x} + ${3:h}) = ${1:f}(${2:x}) + ${1:f}'(${2:x})${3:h} + ${1:f}''(${2:x}) \\frac{${3:h}^{2}}{2!} + \\dots$4",
    opts = "mA",
  },
  { trig = "axm", body = "> [!axiom] $1\n> $2", opts = "t" },
  { trig = "def", body = "> [!definition] $1\n> $2", opts = "t" },
  { trig = "lem", body = "> [!lemma] $1\n> $2", opts = "t" },
  { trig = "prp", body = "> [!proposition] $1\n> $2", opts = "t" },
  { trig = "thm", body = "> [!theorem] $1\n> $2", opts = "t" },
  { trig = "cor", body = "> [!corollary] $1\n> $2", opts = "t" },
  { trig = "clm", body = "> [!claim] $1\n> $2", opts = "t" },
  { trig = "asm", body = "> [!assumption] $1\n> $2", opts = "t" },
  { trig = "exm", body = "> [!exm] $1\n> $2", opts = "t" },
  { trig = "exr", body = "> [!exercise] $1\n> $2", opts = "t" },
  { trig = "cnj", body = "> [!conjecture] $1\n> $2", opts = "t" },
  { trig = "hyp", body = "> [!hypothesis] $1\n> $2", opts = "t" },
  { trig = "rmk", body = "> [!remark] $1\n> $2", opts = "t" },
  { trig = "axiom", body = "> [!axiom] $1\n> $2", opts = "t" },
  { trig = "definition", body = "> [!definition] $1\n> $2", opts = "t" },
  { trig = "lemma", body = "> [!lemma] $1\n> $2", opts = "t" },
  { trig = "proposition", body = "> [!proposition] $1\n> $2", opts = "t" },
  { trig = "theorem", body = "> [!theorem] $1\n> $2", opts = "t" },
  { trig = "corollary", body = "> [!corollary] $1\n> $2", opts = "t" },
  { trig = "claim", body = "> [!claim] $1\n> $2", opts = "t" },
  { trig = "assumption", body = "> [!assumption] $1\n> $2", opts = "t" },
  { trig = "example", body = "> [!example] $1\n> $2", opts = "t" },
  { trig = "exercise", body = "> [!exercise] $1\n> $2", opts = "t" },
  { trig = "conjecture", body = "> [!conjecture] $1\n> $2", opts = "t" },
  { trig = "hypothesis", body = "> [!hypothesis] $1\n> $2", opts = "t" },
  { trig = "remark", body = "> [!remark] $1\n> $2", opts = "t" },
  { trig = "proof", body = "`\\begin{proof}`\n$1\n`\\end{proof}`", opts = "t" },
}

for _, it in ipairs(simple) do
  add_parse(it.trig, it.body, it.opts, it.priority)
end

local function cap(n)
  return function(_, snip)
    return snip.captures[n] or ""
  end
end

local function add_rx(trig, nodes, opts, priority)
  local ctx = {
    trig = trig,
    trigEngine = "ecma",
    wordTrig = false,
    snippetType = opts:find("A", 1, true) and "autosnippet" or "snippet",
    priority = priority or 1200,
  }
  local cond = cond_for(opts)
  if cond then
    ctx.condition = cond
    ctx.show_condition = cond
  end
  table.insert(snippets, s(ctx, nodes))
end

-- Curated regex snippets from the uploaded file. These use ECMAScript regex;
-- LazyVim's LuaSnip extra builds jsregexp on Unix-like systems.
local GREEK =
  "alpha|Alpha|beta|Beta|chi|Chi|gamma|Gamma|delta|Delta|epsilon|Epsilon|varepsilon|zeta|theta|Theta|kappa|lambda|Lambda|mu|rho|sigma|Sigma|omega|Omega|upsilon|Upsilon"
local SYMBOL =
  "circ|infty|sum|prod|lim|inf|sup|pm|mp|dots|to|leftarrow|mapsto|setminus|mid|cap|cup|in|not\\s*in|subseteq|emptyset|implies|impliedby|iff|exists|equiv|square|neq|geq|leq|gg|ll|sim|approx|propto|nabla|times|cdot|parallel|supset|subset"
local MACRO = "(?:" .. GREEK .. "|" .. SYMBOL .. ")"

-- bare macro names -> backslashed macro names, e.g. alpha -> \alpha
add_rx(
  "([^\\\\])(" .. MACRO .. ")",
  { f(cap(1), {}), f(function(_, snip)
    return "\\" .. (snip.captures[2] or "")
  end, {}) },
  "rmA",
  900
)

-- modifiers after LaTeX commands, e.g. \alpha sr -> \alpha^{2}
add_rx(
  "\\\\(" .. MACRO .. ") sr",
  { f(function(_, snip)
    return "\\" .. (snip.captures[1] or "") .. "^{2}"
  end, {}) },
  "rmA"
)
add_rx(
  "\\\\(" .. MACRO .. ") cb",
  { f(function(_, snip)
    return "\\" .. (snip.captures[1] or "") .. "^{3}"
  end, {}) },
  "rmA"
)
add_rx(
  "\\\\(" .. MACRO .. ") hat",
  { f(function(_, snip)
    return "\\hat{\\" .. (snip.captures[1] or "") .. "}"
  end, {}) },
  "rmA"
)
add_rx(
  "\\\\(" .. MACRO .. ") dot",
  { f(function(_, snip)
    return "\\dot{\\" .. (snip.captures[1] or "") .. "}"
  end, {}) },
  "rmA"
)
add_rx(
  "\\\\(" .. MACRO .. ") bar",
  { f(function(_, snip)
    return "\\bar{\\" .. (snip.captures[1] or "") .. "}"
  end, {}) },
  "rmA"
)
add_rx(
  "\\\\(" .. MACRO .. ") vec",
  { f(function(_, snip)
    return "\\vec{\\" .. (snip.captures[1] or "") .. "}"
  end, {}) },
  "rmA"
)
add_rx(
  "\\\\(" .. MACRO .. ") tilde",
  { f(function(_, snip)
    return "\\tilde{\\" .. (snip.captures[1] or "") .. "}"
  end, {}) },
  "rmA"
)
add_rx(
  "\\\\(" .. MACRO .. ") und",
  { f(function(_, snip)
    return "\\underline{\\" .. (snip.captures[1] or "") .. "}"
  end, {}) },
  "rmA"
)

-- letter postfix snippets: xbar -> \bar{x}, xhat -> \hat{x}, etc.
add_rx("([a-zA-Z])bar", { f(function(_, snip)
  return "\\bar{" .. (snip.captures[1] or "") .. "}"
end, {}) }, "rmA")
add_rx("([a-zA-Z])hat", { f(function(_, snip)
  return "\\hat{" .. (snip.captures[1] or "") .. "}"
end, {}) }, "rmA")
add_rx(
  "([a-zA-Z])ddot",
  { f(function(_, snip)
    return "\\ddot{" .. (snip.captures[1] or "") .. "}"
  end, {}) },
  "rmA",
  1300
)
add_rx(
  "([a-zA-Z])dot",
  { f(function(_, snip)
    return "\\dot{" .. (snip.captures[1] or "") .. "}"
  end, {}) },
  "rmA",
  1200
)
add_rx("([a-zA-Z])vec", { f(function(_, snip)
  return "\\vec{" .. (snip.captures[1] or "") .. "}"
end, {}) }, "rmA")
add_rx(
  "([a-zA-Z])tilde",
  { f(function(_, snip)
    return "\\tilde{" .. (snip.captures[1] or "") .. "}"
  end, {}) },
  "rmA"
)
add_rx(
  "([a-zA-Z])und",
  { f(function(_, snip)
    return "\\underline{" .. (snip.captures[1] or "") .. "}"
  end, {}) },
  "rmA"
)
add_rx(
  "([A-Za-z])_(\\d\\d)",
  { f(cap(1), {}), f(function(_, snip)
    return "_{" .. (snip.captures[2] or "") .. "}"
  end, {}) },
  "rmA"
)
add_rx(
  "([a-zA-Z]),\\.",
  { f(function(_, snip)
    return "\\mathbf{" .. (snip.captures[1] or "") .. "}"
  end, {}) },
  "rmA"
)
add_rx(
  "([a-zA-Z])\\.,",
  { f(function(_, snip)
    return "\\mathbf{" .. (snip.captures[1] or "") .. "}"
  end, {}) },
  "rmA"
)

-- trig functions: sin -> \sin, etc.
add_rx("([^\\\\])(arcsin|arccos|arctan|arccot|arccsc|arcsec|sin|cos|tan|cot|csc|sec)", {
  f(cap(1), {}),
  f(function(_, snip)
    return "\\" .. (snip.captures[2] or "")
  end, {}),
}, "rmA")

-- derivatives
add_rx("pa([A-Za-z])([A-Za-z])", {
  f(function(_, snip)
    return "\\frac{ \\partial " .. (snip.captures[1] or "") .. " }{ \\partial " .. (snip.captures[2] or "") .. " } "
  end, {}),
}, "rm")
add_rx("pa([A-Za-z])([A-Za-z])([A-Za-z])", {
  f(function(_, snip)
    return "\\frac{ \\partial^{2} "
      .. (snip.captures[1] or "")
      .. " }{ \\partial "
      .. (snip.captures[2] or "")
      .. " \\partial "
      .. (snip.captures[3] or "")
      .. " } "
  end, {}),
}, "rm")
add_rx("pa([A-Za-z])([A-Za-z])2", {
  f(function(_, snip)
    return "\\frac{ \\partial^{2} "
      .. (snip.captures[1] or "")
      .. " }{ \\partial "
      .. (snip.captures[2] or "")
      .. "^{2} } "
  end, {}),
}, "rmA")
add_rx("de([A-Za-z])([A-Za-z])", {
  f(function(_, snip)
    return "\\frac{ d" .. (snip.captures[1] or "") .. " }{ d" .. (snip.captures[2] or "") .. " } "
  end, {}),
}, "rm")
add_rx("de([A-Za-z])([A-Za-z])2", {
  f(function(_, snip)
    return "\\frac{ d^{2}" .. (snip.captures[1] or "") .. " }{ d" .. (snip.captures[2] or "") .. "^{2} } "
  end, {}),
}, "rmA")

-- iden3 -> 3x3 identity matrix
add_rx("iden(\\d)", {
  f(function(_, snip)
    local n = tonumber(snip.captures[1]) or 2
    local rows = {}
    for r = 1, n do
      local cols = {}
      for c = 1, n do
        table.insert(cols, r == c and "1" or "0")
      end
      table.insert(rows, table.concat(cols, " & "))
    end
    return "\\begin{pmatrix}\n" .. table.concat(rows, " \\\\\\n") .. "\n\\end{pmatrix}"
  end, {}),
}, "mA")

return snippets
