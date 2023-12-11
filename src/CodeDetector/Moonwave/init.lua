local Types = require(script.Parent.Parent.Types)

local Moonwave = {}

function Moonwave:GetMoonwaveTag(line: string): Types.MoonwaveTags
	local tagType = line:gsub("^@", "")
	local tagValue = ""
	local tagDescription = ""

	if tagType == "method" then
		return {
			Method = true,
		}
	elseif tagType == "yielding" then
		return {
			Yielding = true,
		}
	elseif tagType == "param" then
		return {
			Param = {
				Name = tagType,
				Value = tagValue,
				Description = tagDescription,
			},
		}
	elseif tagType == "return" then
		return {
			Return = {
				Name = tagType,
				Value = tagValue,
				Description = tagDescription,
			},
		}
	elseif tagType == "error" then
		return {
			Error = {
				Name = tagType,
				Value = tagValue,
				Description = tagDescription,
			},
		}
	end
	return {}
end

function Moonwave:GetMoonwaveComment(source: table, startLine: number, endLine: number): Types.MoonwaveComment
	local moonwaveComment: Types.MoonwaveComment = {
		-- General
		Description = "",
		StartLine = startLine,
		EndLine = endLine,

		-- Doc Comments
		Class = nil,
		Within = nil,
		Prop = nil,
		Type = nil,
		Interfce = nil,
		Function = nil,
		Tags = {},
	}

	for i = startLine, endLine do
		local line = source[i]
		local lineTrimmed = line:match("^%s*(.-)%s*$")
		local lineTrimmedNoSpace = lineTrimmed:gsub("%s", "")

		if lineTrimmedNoSpace:match("^%-%-") then
			local lineTrimmedNoSpaceNoComment = lineTrimmedNoSpace:gsub("^%-%-", "")
			local lineTrimmedNoSpaceNoCommentTrimmed = lineTrimmedNoSpaceNoComment:match("^%s*(.-)%s*$")

			if lineTrimmedNoSpaceNoCommentTrimmed:match("^@") then
				local tag = self:GetMoonwaveTag(lineTrimmedNoSpaceNoCommentTrimmed)
				if tag then
					table.insert(moonwaveComment.Tags, tag)
				end
			else
				moonwaveComment.Description = moonwaveComment.Description .. lineTrimmedNoSpaceNoCommentTrimmed .. "\n"
			end
		end
	end
end

return Moonwave
