local Rules = {}
Rules.Map = {
  ["BB-LC-001"] = { severity="HARD", findings={"DT001"}, description="Executable code at file load" },
  ["BB-LC-002"] = { severity="HARD", findings={"DT002"}, description="Init not gated by PLAYER_LOGIN" },
  ["BB-SL-001"] = { severity="HARD", findings={"DT003"}, description="Invalid slash registration" },
  ["BB-UI-001"] = { severity="SOFT", findings={"DT004"}, description="Early UI construction" },
  ["BB-FI-001"] = { severity="HARD", findings={"DT005"}, description="TOC integrity failure" },
}
return Rules
