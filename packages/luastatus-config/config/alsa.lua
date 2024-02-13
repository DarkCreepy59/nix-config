function round(num)
    return math.floor(num + .5)
end

widget = {
    plugin = 'alsa',
    cb = function(t)
        if t.mute then
            return ' Mute'
        else
            -- Round the result because no matter if alsa or pulse, instead of 20% it's something like 19.99...
            local percent = round((t.vol.cur - t.vol.min) / (t.vol.max - t.vol.min) * 100)

            local icon = ''
            if percent <= 10 then
                icon = ''
            elseif percent > 10 and percent <= 40 then
                icon = ''
            else
                icon = ''
            end

            return string.format('%s %d%%', icon, percent)
        end
    end,
}
