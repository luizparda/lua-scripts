local AxeMarker =  {}

AxeMarker.option = Menu.AddOption({ "Hero Specific", "Axe"}, "AxeMarker", "Shows when an enemy is kilable by ult")
AxeMarker.font = Renderer.LoadFont("Tahoma", 18, Enum.FontWeight.EXTRABOLD)
AxeMarker.UltimateDamage = {250,325,400}


function AxeMarker.OnDraw()
    if not Menu.IsEnabled(AxeMarker.option) then return end

    local myHero = Heroes.GetLocal()

    if not myHero then return end

	local myName = NPC.GetUnitName(myHero)

	if myName ~= "npc_dota_hero_axe" then return end

	local CullingBlade = NPC.GetAbility(myHero,"axe_culling_blade")

	if AxeMarker.UltimateDamage[Ability.GetLevel(CullingBlade)] == nil then return end

    local myTeam = Entity.GetTeamNum(myHero)

    for i = 1, Heroes.Count() do
        local hero = Heroes.Get(i)
        local sameTeam = Entity.GetTeamNum(hero) == myTeam

        if not sameTeam and not NPC.IsDormant(hero) and  Entity.GetHealth(hero) <= AxeMarker.UltimateDamage[Ability.GetLevel(CullingBlade)] then
            local pos = NPC.GetAbsOrigin(hero)
            local x, y, visible = Renderer.WorldToScreen(pos)

            if visible then
                Renderer.SetDrawColor(255,0,0,255)
                Renderer.DrawTextCentered(AxeMarker.font, x, y, "KILLABLE", 1)
            end
        end
    end
end

return AxeMarker
