local function calculate_padding()
	local total_height = vim.api.nvim_get_option("lines")
	local layout_height = 20 -- Approximate height of your Alpha layout
	return math.max(0, math.floor((total_height - layout_height) / 2))
end

local function button(sc, txt, keybind)
	local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

	local opts = {
		position = "center",
		text = txt,
		shortcut = sc,
		cursor = 6,
		width = 19,
		align_shortcut = "right",
		hl_shortcut = "Number",
		hl = "Function",
	}
	if keybind then
		opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
	end

	return {
		type = "button",
		val = txt,
		on_press = function()
			local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
			vim.api.nvim_feedkeys(key, "normal", false)
		end,
		opts = opts,
	}
end

local function getGreeting(name)
	local tableTime = os.date("*t")
	local hour = tableTime.hour
	local greetingsTable = {
		[1] = "  Sleep well",
		[2] = "  Good morning",
		[3] = "  Good afternoon",
		[4] = "  Good evening",
		[5] = "☾ .⭒˚ Good night",
	}
	local greetingIndex = 0
	if hour == 23 or hour < 7 then
		greetingIndex = 1
	elseif hour < 12 then
		greetingIndex = 2
	elseif hour >= 12 and hour < 18 then
		greetingIndex = 3
	elseif hour >= 18 and hour < 21 then
		greetingIndex = 4
	elseif hour >= 21 then
		greetingIndex = 5
	end
	return greetingsTable[greetingIndex] .. ", " .. name
end

local function getLen(str, start_pos)
	local byte = string.byte(str, start_pos)
	if not byte then
		return nil
	end
	return (byte < 0x80 and 1) or (byte < 0xE0 and 2) or (byte < 0xF0 and 3) or (byte < 0xF8 and 4) or 1
end

local function colorize(header, header_color_map, colors)
	for letter, color in pairs(colors) do
		local color_name = "AlphaJemuelKwelKwelWalangTatay" .. letter
		vim.api.nvim_set_hl(0, color_name, color)
		colors[letter] = color_name
	end

	local colorized = {}

	for i, line in ipairs(header_color_map) do
		local colorized_line = {}
		local pos = 0

		for j = 1, #line do
			local start = pos
			pos = pos + getLen(header[i], start + 1)

			local color_name = colors[line:sub(j, j)]
			if color_name then
				table.insert(colorized_line, { color_name, start, pos })
			end
		end

		table.insert(colorized, colorized_line)
	end

	return colorized
end

local color_map = {
	[[      AAAA]],
	[[AAAAAA  AAAA]],
	[[AA    AAAA  AAAA        KKHHKKHHHH]],
	[[AAAA    AAAA  AA    HHBBKKKKKKKKKKKKKK]],
	[[  AAAAAA      AAKKBBHHKKBBYYBBKKKKHHKKKKKK]],
	[[      AAAA  BBAAKKHHBBBBKKKKBBYYBBHHHHKKKKKK]],
	[[        BBAABBKKYYYYHHKKYYYYKKKKBBBBBBZZZZZZ]],
	[[    YYBBYYBBKKYYYYYYYYYYKKKKBBKKAAAAZZOOZZZZ]],
	[[    XXXXYYYYBBYYYYYYYYBBBBBBKKKKBBBBAAAAZZZZ]],
	[[    XXXXUUUUYYYYBBYYYYYYBBKKBBZZOOAAZZOOAAAAAA]],
	[[  ZZZZZZXXUUXXXXYYYYYYYYBBAAAAZZOOOOAAOOZZZZAAAA]],
	[[  ZZUUZZXXUUUUXXXXUUXXFFFFFFFFAAAAOOZZAAZZZZ  AA]],
	[[    RRRRUUUUZZZZZZZZXXOOFFFFOOZZOOAAAAAAZZZZAA]],
	[[    CCSSUUUUZZXXXXZZXXOOFFFFOOZZOOOOZZOOAAAA]],
	[[    CCCCUUUUUUUUUURRRROOFFFFOOZZOOOOZZOOZZZZ]],
	[[    CCCCUUUUUUUUSSCCCCEEQQQQOOZZOOOOZZOOZZZZ]],
	[[    CCCCUUGGUUUUCCCCCCEEQQQQOOZZOOOOZZEEZZ]],
	[[    RRRRGGGGUUGGCCCCCCOOOOOOOOZZOOEEZZII]],
	[[      IIRRGGGGGGCCCCCCOOOOOOOOZZEEII]],
	[[            GGRRCCCCCCOOOOEEEEII  II]],
	[[                RRRRRREEEE  IIII]],
	[[                      II]],
	[[]],
}
return {
	"goolord/alpha-nvim",
	config = function()
		-- require'alpha'.setup(require'alpha.themes.dashboard'.config)
		local present, alpha = pcall(require, "alpha")
		if not present then
			return
		end

		local color = require("utils.color_utils")
		local mocha = require("catppuccin.palettes").get_palette("mocha")

		-- Header

		local yellow = "#FAC87C"
		local orange = "#BF854E"
		local maroon = "#502E2B"
		local brown = "#38291B"
		local colors = {
			["A"] = { fg = mocha.rosewater },
			["Y"] = { fg = yellow },
			["B"] = { fg = color.darken(yellow, 5) },
			["X"] = { fg = color.darken(yellow, 20) },
			["U"] = { fg = color.darken(yellow, 25) },
			["F"] = { fg = color.darken(yellow, 35) },
			["O"] = { fg = color.darken(yellow, 45) },
			["K"] = { fg = maroon },
			["H"] = { fg = color.darken(maroon, 10) },
			["Z"] = { fg = mocha.crust },
			["G"] = { fg = color.darken(yellow, 25) },
			["R"] = { fg = orange },
			["Q"] = { fg = color.darken(orange, 20) },
			["E"] = { fg = color.darken(orange, 35) },
			["I"] = { fg = brown },
			["C"] = { fg = mocha.mantle },
			["S"] = { fg = mocha.subtext1 },
		}

		local header_val = {}
		for _, line in ipairs(color_map) do
			local header_line = [[]]
			for i = 1, #line do
				if line:sub(i, i) ~= " " then
					header_line = header_line .. "█"
				else
					header_line = header_line .. " "
				end
			end
			table.insert(header_val, header_line)
		end

		-- local header_add = [[          N        E      O    B   E E         ]]
		-- table.insert(header_val, header_add)

		-- local hl_add = {}
		-- for i = 1, #header_add do
		-- 	table.insert(hl_add, { "NeoBeeTitle", 1, i })
		-- end

		local colorized = colorize(header_val, color_map, colors)
		-- table.insert(colorized, hl_add)

		local header = {
			type = "text",
			val = header_val,
			opts = {
				hl = colorized,
				position = "center",
			},
		}

		-- Greetings
		local userName = "Evry"
		local greeting = getGreeting(userName)

		local greetHeading = {
			type = "text",
			val = greeting,
			opts = {
				position = "center",
				hl = "String",
			},
		}

		local fortune = {
			type = "text",
			val = "First, solve the problem. Then, write the code.",
			opts = {
				position = "center",
				hl = "Comment",
			},
		}
		local function horizontal_buttons()
			local buttons = {
				button("s", "  Restore", ":SessionManager load_last_session<CR>"),
				button("r", "🗐  Recents", ":Telescope oldfiles<CR>"),
				button("f", "  Search", ":Telescope find_files<CR>"),
				button("M-p", "  Files", ":Neotree filesystem reveal left<CR>"),
				button("u", "  Update", ":Lazy sync<CR>"),
				button("c", "  Config", ":e ~/.config/nvim/<CR>"),
				button("q", "  Quit", ":qa!<CR>"),
			}

			local line = {}
			for _, btn in ipairs(buttons) do
				table.insert(line, btn.val .. " (" .. btn.opts.shortcut .. ")")
				table.insert(line, "  ") -- Adjust the spacing between buttons as needed
			end
			return table.concat(line, " ")
		end

		-- local buttons = {
		-- 	type = "text",
		-- 	val = horizontal_buttons(),
		-- 	opts = {
		-- 		position = "center",
		-- 		hl = "Function",
		-- 		spacing = 1,
		-- 	},
		-- }

		local buttons = {
			type = "group",
			val = {
				button("s", " Restore", ":SessionManager load_last_session<CR>"),
				button("r", "🗐 Recents", ":Telescope oldfiles<CR>"),
				button("f", " Search", ":Telescope find_files<CR>"),
				button("M-p", " Files", ":Neotree filesystem reveal left<CR>"),
				button("u", " Update", ":Lazy sync<CR>"),
				button("c", " Config", ":e ~/.config/nvim/<CR>"),
				-- button("q", " Quit", ":qa!<CR>"),
			},
			opts = {
				position = "center",
				spacing = 1,
				width = 80, -- Adjust width to center the entire row of buttons
				align = "center", -- Center align all buttons in the row
			},
		}
		local section = {
			header = header,
			buttons = buttons,
			greetHeading = greetHeading,
			footer = fortune,
		}

		local opts = {
			layout = {
				{ type = "padding", val = calculate_padding() },
				section.header,
				{ type = "padding", val = 1 },
				section.greetHeading,
				{ type = "padding", val = 1 },
				section.buttons,
				{ type = "padding", val = 1 },
				section.footer,
			},
			opts = {
				margin = 8,
				align = "center",
			},
		}

		alpha.setup(opts)
	end,
}
