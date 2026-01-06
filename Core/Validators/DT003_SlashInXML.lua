local DT003 = {}

DT003.id         = "DT003"
DT003.title      = "Slash Command Registered via XML OnLoad"
DT003.category   = "Lifecycle / UI"
DT003.severity   = "Soft"
DT003.confidence = "High"
DT003.rules      = { "BRZ-UI-002" }

function DT003:Run(context)
    local findings = {}
    local handlers = context.GetXMLOnLoadHandlers and context:GetXMLOnLoadHandlers() or nil
    if not handlers then return findings end

    for _, h in ipairs(handlers) do
        local src = context.FindLuaFunction and context:FindLuaFunction(h.name)
        if src then
            if src:match("SLASH_") or src:match("SlashCmdList") or src:match("["']/%w+") then
                table.insert(findings, {
                    id = self.id,
                    file = h.xmlFile,
                    line = h.line,
                    summary = "Slash command registered inside XML OnLoad handler.",
                    explanation = "On Bronzebeard, UI frames may not instantiate automatically, which can prevent this handler from executing.",
                    guidance = "Register slash commands during PLAYER_LOGIN or central lifecycle initialization.",
                    confidence = self.confidence,
                })
            end
        end
    end
    return findings
end

return DT003
