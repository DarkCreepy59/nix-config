function execute_command(command)
    local handle = io.popen(command)
    local result = handle:read("*a")
    handle:close()

    return result
end

widget = {
    plugin = 'timer',
    cb = function()
        local date = 

        return 'uwu'
    end
}
