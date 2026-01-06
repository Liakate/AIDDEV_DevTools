-- DevTools hardened bootstrap
if not AIDDEV_DevTools then AIDDEV_DevTools = {} end
local DT = AIDDEV_DevTools
if DT._deferred then return end

AIDDEV_DevTools = AIDDEV_DevTools or {}
if not AIDDEV_DevTools then return end
-- AIDDEV_DevTools/UI/DevToolsFrame.lua

local UiColors = _G.AIDDEV_UiColors or {
    Severity = function(_, severity, text)
        local colors = {
            fatal   = "|cffff0000",
            error   = "|cffff0000",
            warning = "|cffffff00",
            info    = "|cff00ff00",
        }
        local c = colors[severity] or colors.info
        return c .. (text or "") .. "|r"
    end
}

local DevToolsUI = {}
AIDDEV_DevToolsUI = DevToolsUI

local lastReport = nil

function DevToolsUI:SetReport(report)
    lastReport = report

    local frame = AIDDEVDevToolsFrame
    if not frame then return end

    if not frame.contentText then
        local fs = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
        fs:SetJustifyH("LEFT")
        fs:SetJustifyV("TOP")
        frame.contentText = fs
        frame.Scroll:SetScrollChild(fs)
    end

    if not report or not report.entries then
        frame.contentText:SetText("No report available.")
        return
    end

    local text = ""
    text = text .. UiColors:Severity("info",
        string.format("Fatal: %d  Errors: %d  Warnings: %d",
            report.fatalCount or 0,
            report.errorCount or 0,
            report.warningCount or 0)
    ) .. "\n\n"

    for _, e in ipairs(report.entries) do
        text = text .. UiColors:Severity(e.severity,
            string.format("[%s] %s", e.ruleId or "?", e.message or "?")
        ) .. "\n"
    end

    frame.contentText:SetText(text)
end

function AIDDEV_DevTools_ShowReport(report)
    AIDDEV_DevToolsUI:SetReport(report)
end

function AIDDEV_DevTools_ToggleFrame()
    local frame = AIDDEVDevToolsFrame
    if frame:IsShown() then
        frame:Hide()
    else
        frame:Show()
    end
end

function AIDDEV_DevTools_OnLoad(frame)
    -- nothing extra yet
end
