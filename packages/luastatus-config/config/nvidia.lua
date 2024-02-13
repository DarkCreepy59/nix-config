--   󰜋 󰜌 󰤄 󰵲
function execute_command(command)
    local handle = io.popen(command)
    local result = handle:read("*a")
    handle:close()

    return result
end

widget = {
    plugin = 'timer',
    opts = {period = 5},
    cb = function()
        local status = string.gsub(execute_command("cat /sys/bus/pci/devices/0000:01:00.0/power/runtime_status"), '\n', '')

        if status == "active" then
            return ' Active'
        end
    end
}
