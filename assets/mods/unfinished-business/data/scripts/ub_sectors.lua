RegisterListener('OnEnterSector', 'setup_ub_sectors')
RegisterListener('OnItemAction', 'handle_action_item')

function setup_ub_sectors(x, y, z)
    local sectorID = GetCurrentSector()
    local sectorInfo = GetSectorInfo(sectorID)
    if (sectorInfo.uiFlags & SectorFlags.SF_HAS_ENTERED_TACTICAL) ~= 0 then
        -- not the first time here
        return
    end

    if sectorID == 'H9' then -- the guardpost
        -- Add some money to the location
        add_money(9026,  {15000, 10000, 7000})
    elseif sectorID == "I10" then -- the first sector of the town
        -- Add some money to the location
        add_money(11894, {8000,   4000, 3000})
        add_money(7906,  {12000,  6000, 5000})
    end
end

function add_money(grid_no, amounts_by_difficulty)
    local amt = amounts_by_difficulty[gGameOptions.ubDifficultyLevel]
    local money = CreateMoney(amt)
    PlaceItem(grid_no, money, Visibility.INVISIBLE)
end

function handle_action_item(grid_no, obj, processed)
    local action = obj.bActionValue
    if action == UB_ActionItems.ACTION_ITEM_BIGGENS_BOMBS then
        --[[
                                    if( ShouldThePlayerStopWhenWalkingOnBiggensActionItem( 17 ) )
                        {
                                HavePersonAtGridnoStop( sGridNo );
--]]
        -- Make Biggens run for cover and then detonate the explosives
        TriggerNPCRecord(UB_MercProfiles.BIGGENS, 17)
        processed.val = TRUE
    elseif action == UB_ActionItems.ACTION_ITEM_BIGGENS_WARNING then
        --[[
                        if( ShouldThePlayerStopWhenWalkingOnBiggensActionItem( 16 ) )
                        {
                                HavePersonAtGridnoStop( sGridNo );
--]]
        -- Have Biggens spit out a warning about the bombs
        TriggerNPCRecord(UB_MercProfiles.BIGGENS, 16)
        processed.val = TRUE
    end
end