widget = luastatus.require_plugin('battery-linux').widget{
    period = 2,
    dev = 'BAT1',
    cb = function(t)
        local icon = ''
        if t.status == "Charging" then
            icon = ''
        elseif t.capacity <= 10 then
            icon = '' -- 0 - 10
        elseif t.capacity > 10 and t.capacity <= 35 then
            icon = '' -- 10 - 35
        elseif t.capacity > 35 and t.capacity <= 65 then
            icon = '' -- 35 - 65
        elseif t.capacity > 65 and t.capacity <= 100 then
            icon = '' -- 65 - 100
        end

        return string.format('%s %d%% ', icon, t.capacity)
    end
}
