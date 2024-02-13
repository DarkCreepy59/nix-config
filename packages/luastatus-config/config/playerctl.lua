function execute_command(command)
    local handle = io.popen(command)
    local result = handle:read("*a")
    handle:close()

    return result
end

widget = {
    plugin = 'timer',
    opts = { period = 5 },
    cb = function()
        -- 2>&1 to redirect stderr to stdout because "No players found" is printed to stderr
        -- (the check would check and the journal would be filled with "No players found")
        local players = string.gsub(execute_command("playerctl --list-all 2>&1"), '\n', '')
        if players == "No players found" then
            return
        end

        local status = string.gsub(execute_command("playerctl status"), '\n', '')
        local title = string.gsub(execute_command('playerctl metadata xesam:title'), '\n', '')

        if status == "Playing" then
            return string.format(' %s', title)
        end
    end
}
