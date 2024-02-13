function execute_command(command)
    local handle = io.popen(command)
    local result = handle:read("*a")
    handle:close()

    return result
end

-- This widget suppose the use of a patched barlib and dwm to use ';' to center the text
widget = {
    plugin = 'timer',
    cb = function()
        execute_command("echo $PATH >&2")
        local date = string.gsub(execute_command("date +'; %m/%d (%a)  %R'"), '\n', '')

        return date
    end
}
