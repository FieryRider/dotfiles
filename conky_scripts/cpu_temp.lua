function conky_get_cpu_temp(cpu_number)
  --[[
  if hwmon_number ~= nil then
    return conky_parse('${hwmon ' .. hwmon_number .. ' temp ' .. cpu_number .. '}')
  end

  local hwmon0temp = conky_parse('${hwmon 0 temp 4}')
  local hwmon1temp = conky_parse('${hwmon 1 temp 4}')
  local hwmon2temp = conky_parse('${hwmon 2 temp 4}')

  if hwmon0temp ~= "" then
    hwmon_number = 0
  elseif hwmon1temp ~= "" then
    hwmon_number = 1
  elseif hwmon2temp ~= "" then
    hwmon_number = 2
  end

  return conky_parse('${hwmon ' .. hwmon_number .. ' temp ' .. cpu_number .. '}')
  ]]

  if hwmon_name == nil then
    for i=0,2 do
      local f = io.open("/sys/class/hwmon/hwmon" .. i .. "/name", "r")
      if f:read() == "coretemp" then
        hwmon_name = "hwmon" .. i
        f:close()
        break
      end
      f:close()
    end
  end

  local file_name = "/sys/class/hwmon/" .. hwmon_name ..  "/temp" .. (tonumber(cpu_number) + 1) .. "_input"
  local f = io.open(file_name, "r")
  local raw_temp = tonumber(f:read())
  f:close()
  local temp = raw_temp // 1000
  return temp
end
