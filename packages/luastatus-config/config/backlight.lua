-- Note that this widget only shows backlight level when it changes.
widget = luastatus.require_plugin('backlight-linux').widget{
    cb = function(level)
        if level ~= nil then
            return string.format(' %d%%', level * 100)
        end
    end,
}
