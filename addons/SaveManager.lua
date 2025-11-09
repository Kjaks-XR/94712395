print"save manager loaded 0.3 for series B - FIXED"

local httpService = game:GetService('HttpService')

local SaveManager = {} do
	SaveManager.Folder = 'LinoriaLibSettings'
	SaveManager.Ignore = {}
	
	-- Obfuscation characters - wide variety but moderate
local NOISE_CHARS = ">£#$½_*-!@#$%^&*()_+-=[]{}|;:',.<>?/\\`~¥¢¡¿§¶†‡€™áàâäãåæçéèêëíìîïñóòôöõøœßúùûüýÿ"
	
	-- Helper function to encode to base64
	local function base64Encode(str)
		local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
		return ((str:gsub('.', function(x)
			local r, b = '', x:byte()
			for i = 8, 1, -1 do r = r .. (b % 2 ^ i - b % 2 ^ (i - 1) > 0 and '1' or '0') end
			return r
		end) .. '0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
			if (#x < 6) then return '' end
			local c = 0
			for i = 1, 6 do c = c + (x:sub(i, i) == '1' and 2 ^ (6 - i) or 0) end
			return b:sub(c + 1, c + 1)
		end)) .. ({'', '==', '='})[#str % 3 + 1]
	end
	
	-- Helper function to decode from base64
	local function base64Decode(str)
		local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
		str = str:gsub('[^' .. b .. '=]', '')
		return (str:gsub('.', function(x)
			if (x == '=') then return '' end
			local r, b = '', b:find(x) - 1
			for i = 6, 1, -1 do r = r .. (b % 2 ^ i - b % 2 ^ (i - 1) > 0 and '1' or '0') end
			return r
		end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
			if (#x ~= 8) then return '' end
			local c = 0
			for i = 1, 8 do c = c + (x:sub(i, i) == '1' and 2 ^ (8 - i) or 0) end
			return string.char(c)
		end))
	end
		-- Inject randomized noise with no predictable patterns
	local function injectNoise(str)
		local result = ''
		local i = 1
		while i <= #str do
			result = result .. str:sub(i, i)
			
			-- Vary noise insertion: use random intervals instead of fixed probability
			-- This prevents repeating patterns from emerging
			local insertChance = math.random(100)
			
			if insertChance <= 18 then
				-- Randomly decide: insert 0-4 noise chars at random intervals
				local noiseCount = math.random(0, 4)
				for _ = 1, noiseCount do
					local randomIdx = math.random(1, #NOISE_CHARS)
					result = result .. NOISE_CHARS:sub(randomIdx, randomIdx)
				end
			end
			
			i = i + 1
		end
		return result
	end
	
	-- Remove noise from string
	local function removeNoise(str)
		local result = ''
		for i = 1, #str do
			local char = str:sub(i, i)
			if not NOISE_CHARS:find(char, 1, true) then
				result = result .. char
			end
		end
		return result
	end
	
	-- Simple bytecode layer (XOR encryption with random key)
	local function bytecodeEncode(str)
		local key = math.random(1, 255)
		local result = string.char(key)
		for i = 1, #str do
			result = result .. string.char(bit32.bxor(str:byte(i), key))
		end
		return result
	end
	
	-- Bytecode decode
	local function bytecodeDecode(str)
		if #str < 1 then return '' end
		local key = str:byte(1)
		local result = ''
		for i = 2, #str do
			result = result .. string.char(bit32.bxor(str:byte(i), key))
		end
		return result
	end
	
	-- Hex encode
	local function hexEncode(str)
		local result = ''
		for i = 1, #str do
			result = result .. string.format('%02x', str:byte(i))
		end
		return result
	end
	
	-- Hex decode
	local function hexDecode(str)
		local result = ''
		for i = 1, #str, 2 do
			local hex = str:sub(i, i + 1)
			result = result .. string.char(tonumber(hex, 16))
		end
		return result
	end
	SaveManager.Parser = {
	Toggle = {
		Save = function(idx, object) 
			return { type = 'Toggle', idx = idx, value = object.Value } 
		end,
		Load = function(idx, data)
			if Toggles[idx] then
				local oldOnChange = Toggles[idx].OnChange
				Toggles[idx].OnChange = nil
				Toggles[idx]:SetValue(data.value)
				Toggles[idx].OnChange = oldOnChange
			end
		end,
	},
	Slider = {
		Save = function(idx, object)
			return { type = 'Slider', idx = idx, value = object.Value }
		end,
		Load = function(idx, data)
			if Options[idx] then
				local oldOnChange = Options[idx].OnChange
				Options[idx].OnChange = nil
				Options[idx]:SetValue(tonumber(data.value) or data.value)
				Options[idx].OnChange = oldOnChange
			end
		end,
	},
	Dropdown = {
		Save = function(idx, object)
			return { type = 'Dropdown', idx = idx, value = object.Value, multi = object.Multi }
		end,
		Load = function(idx, data)
			if Options[idx] then 
				Options[idx]:SetValue(data.value)
			end
		end,
	},
	ColorPicker = {
		Save = function(idx, object)
			return { type = 'ColorPicker', idx = idx, value = object.Value:ToHex(), transparency = object.Transparency }
		end,
		Load = function(idx, data)
			if Options[idx] then 
				Options[idx]:SetValueRGB(Color3.fromHex(data.value), data.transparency)
			end
		end,
	},
	KeyPicker = {
		Save = function(idx, object)
			return { type = 'KeyPicker', idx = idx, mode = object.Mode, key = object.Value }
		end,
		Load = function(idx, data)
			if Options[idx] then 
				Options[idx]:SetValue({ data.key, data.mode })
			end
		end,
	},
	Input = {
		Save = function(idx, object)
			return nil  -- Don't save input boxes
		end,
		Load = function(idx, data)
			-- Don't load input boxes
		end,
	},
}

	function SaveManager:SetIgnoreIndexes(list)
		for _, key in next, list do
			self.Ignore[key] = true
		end
	end

	function SaveManager:SetFolder(folder)
		self.Folder = folder;
		self:BuildFolderTree()
	end

	function SaveManager:Save(name)
		if (not name) then return false, 'no config file is selected' end
		local fullPath = self.Folder .. '/settings/' .. name .. '.json'
		local data = { objects = {} }

		for idx, toggle in next, Toggles do
			if self.Ignore[idx] then continue end
			table.insert(data.objects, self.Parser[toggle.Type].Save(idx, toggle))
		end

		for idx, option in next, Options do
			if not self.Parser[option.Type] then continue end
			if self.Ignore[idx] then continue end
			table.insert(data.objects, self.Parser[option.Type].Save(idx, option))
		end	

		local success, encoded = pcall(httpService.JSONEncode, httpService, data)
		if not success then return false, 'failed to encode data' end

		-- Layer 1: Base64 encode
		local base64 = base64Encode(encoded)
		
		-- Layer 2: Inject noise
		local obfuscated = injectNoise(base64)
		
		-- Layer 3: Bytecode encode
		local bytecoded = bytecodeEncode(obfuscated)
		
		-- Layer 4: Hex encode
		local hexed = hexEncode(bytecoded)


	local final = hexed .. '0197384-97GH-S' -- sonuna imza ekledik
	writefile(fullPath, final)
		return true
	end
function SaveManager:LoadSafe(name)
	if (not name) then return false, 'no config file is selected' end
	local file = self.Folder .. '/settings/' .. name .. '.json'
	if not isfile(file) then return false, 'invalid file' end

	local fileContent = readfile(file)
	
	-- Remove signature from end
	local signature = '0197384-97GH-S'
	if fileContent:sub(-#signature) == signature then
		fileContent = fileContent:sub(1, -#signature - 1)
	end
	
	-- Layer 4: Hex decode
	local decoded_hex = hexDecode(fileContent)
	
	-- Layer 3: Bytecode decode
	local decoded_bytecode = bytecodeDecode(decoded_hex)
	
	-- Layer 2: Remove noise
	local cleaned = removeNoise(decoded_bytecode)
	
	-- Layer 1: Base64 decode
	local decoded_str = base64Decode(cleaned)
	
	local success, decoded = pcall(httpService.JSONDecode, httpService, decoded_str)
	if not success then return false, 'decode error' end

	-- Disable all callbacks before loading
	local originalCallbacks = {}
	
	for idx, toggle in next, Toggles do
		originalCallbacks[idx] = toggle.OnChange
		toggle.OnChange = nil
	end

	for idx, option in next, Options do
		originalCallbacks[idx] = option.OnChange
		option.OnChange = nil
	end

	-- Load all values silently (no callbacks triggered)
	for _, option in next, decoded.objects do
		if self.Parser[option.type] then
			pcall(function()
				self.Parser[option.type].Load(option.idx, option)
			end)
		end
	end

	-- Restore callbacks (without triggering them)
	for idx, toggle in next, Toggles do
		toggle.OnChange = originalCallbacks[idx]
	end

	for idx, option in next, Options do
		option.OnChange = originalCallbacks[idx]
	end

	return true
end

	function SaveManager:IgnoreThemeSettings()
		self:SetIgnoreIndexes({ 
			"BackgroundColor", "MainColor", "AccentColor", "OutlineColor", "FontColor",
			"ThemeManager_ThemeList", 'ThemeManager_CustomThemeList', 'ThemeManager_CustomThemeName',
		})
	end

	function SaveManager:BuildFolderTree()
		local paths = { self.Folder, self.Folder .. '/themes', self.Folder .. '/settings' }
		for i = 1, #paths do
			if not isfolder(paths[i]) then makefolder(paths[i]) end
		end
	end

	function SaveManager:RefreshConfigList()
		local list = listfiles(self.Folder .. '/settings')
		local out = {}
		for i = 1, #list do
			local file = list[i]
			if file:sub(-5) == '.json' then
				local pos = file:find('.json', 1, true)
				local start = pos
				local char = file:sub(pos, pos)
				while char ~= '/' and char ~= '\\' and char ~= '' do
					pos = pos - 1
					char = file:sub(pos, pos)
				end
				if char == '/' or char == '\\' then
					table.insert(out, file:sub(pos + 1, start - 1))
				end
			end
		end
		return out
	end

	function SaveManager:SetLibrary(library)
		self.Library = library
	end

	function SaveManager:LoadAutoloadConfig()
		if isfile(self.Folder .. '/settings/autoload.txt') then
			local name = readfile(self.Folder .. '/settings/autoload.txt')
			local success, err = self:LoadSafe(name)
			if not success then
				return self.Library:Notify('Failed to load autoload config: ' .. err)
			end
			self.Library:Notify(string.format('Auto loaded config %q', name))
		end
	end

	function SaveManager:BuildConfigSection(tab)
		assert(self.Library, 'Must set SaveManager.Library')

		local section = tab:AddRightGroupbox('Configuration')
		section:AddInput('SaveManager_ConfigName', { Text = 'Config name' })
		section:AddDropdown('SaveManager_ConfigList', { Text = 'Config list', Values = self:RefreshConfigList(), AllowNull = true })
		section:AddDivider()

		section:AddButton('Create config', function()
			local name = Options.SaveManager_ConfigName.Value
			if name:gsub(' ', '') == '' then return self.Library:Notify('Invalid config name (empty)', 2) end
			local success, err = self:Save(name)
			if not success then return self.Library:Notify('Failed to save config: ' .. err) end
			self.Library:Notify(string.format('Created config %q', name))
			Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
			Options.SaveManager_ConfigList:SetValue(nil)
		end):AddButton('Load config', function()
			local name = Options.SaveManager_ConfigList.Value
			local success, err = self:LoadSafe(name)
			if not success then return self.Library:Notify('Failed to load config: ' .. err) end
			self.Library:Notify(string.format('Loaded config %q', name,15))
		end)

		section:AddButton('Overwrite config', function()
			local name = Options.SaveManager_ConfigList.Value
			local success, err = self:Save(name)
			if not success then return self.Library:Notify('Failed to overwrite config: ' .. err) end
			self.Library:Notify(string.format('Overwrote config %q', name))
		end)

		section:AddButton('Refresh list', function()
			Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
			Options.SaveManager_ConfigList:SetValue(nil)
		end)

		section:AddButton('Set as autoload', function()
			local name = Options.SaveManager_ConfigList.Value
			writefile(self.Folder .. '/settings/autoload.txt', name)
			SaveManager.AutoloadLabel:SetText('Current autoload config: ' .. name)
			self.Library:Notify(string.format('Set %q to auto load', name))
		end)

		SaveManager.AutoloadLabel = section:AddLabel('Current autoload config: none', true)
		if isfile(self.Folder .. '/settings/autoload.txt') then
			local name = readfile(self.Folder .. '/settings/autoload.txt')
			SaveManager.AutoloadLabel:SetText('Current autoload config: ' .. name)
		end

		SaveManager:SetIgnoreIndexes({ 
    "showplayerlistui",  -- Bu toggle load olmuyor
    "SaveManager_ConfigList", 
    "SaveManager_ConfigName",
	"luaTabshow",
	"freecamToggle",
})
	end

	SaveManager:BuildFolderTree()
end

return SaveManager
