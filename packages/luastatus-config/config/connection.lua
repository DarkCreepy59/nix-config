widget = {
    plugin = 'network-linux',
    opts = {
        wireless = true,
        timeout = 10,
    },
    cb = function(t)
        if not t then
            return ''
        end

        local r = {}
        for iface, params in pairs(t) do
            if params.wireless then
                if params.wireless.ssid then
                    if params.wireless.ssid == 'wiffind' then
                        params.wireless.ssid = 'Maison'
                    end
                    r[#r + 1] = string.format(' %s', params.wireless.ssid)
                end
            end
        end
        
        if #r == 0 then
            return ' Offline'
        else
            return r
        end
    end,
}
