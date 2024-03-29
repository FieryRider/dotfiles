function trim(s)
  return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

function conky_get_cpu_temp()
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

  for i=0,4 do
    local f = io.open("/sys/class/hwmon/hwmon" .. i .. "/name", "r")
    if trim(f:read()) == "gigabyte_wmi" then
      hwmon_name = "hwmon" .. i
      f:close()
      break
    end
    f:close()
  end

  local file_name = "/sys/class/hwmon/" .. hwmon_name ..  "/temp3_input"
  local f = io.open(file_name, "r")
  local raw_temp = tonumber(f:read())
  f:close()
  local temp = raw_temp // 1000
  return temp
end
