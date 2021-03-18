common_config = {
	background = true,
	use_xft = true,
	font = 'Ubuntu mono:pixelsize=14',
	xftalpha = 0.5,
	update_interval = 1,
	total_run_times = 0,
	own_window = true,
	own_window_type = 'normal',
	own_window_argb_visual = true,
	own_window_transparent = true,
	own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',
	double_buffer = true,
	minimum_width = 260, minimum_height = 5,
	maximum_width = 300,
	draw_shades = false,
	draw_outline = false,
	draw_borders = false,
	draw_graph_borders = false,
	default_color = '#bbbbbb',
	default_shade_color = 'red',
	default_outline_color = 'green',
	alignment = 'top_right',
	no_buffers = true,
	uppercase = false,
	cpu_avg_samples = 4,
	override_utf8_locale = true,
	lua_load = '~/code/git/dotfiles/conky_scripts/cpu_temp.lua'
}

common_text = [[
${color #dddddd}${font Ubuntu mono:pixelsize=55}${alignr}${time %H:%M:%S}${font}${color}
${font Ubuntu mono:weight:Bold}${alignr}${time %a %d.%m.%Y}${font}

${color #ffffff}${font Ubuntu mono:pixelsize=20,weight:Bold}System Info${font} ${hr 2}${color}

${color #55aaff}$nodename${color} - $sysname $kernel
${color #55aaff}Uptime:${color} $uptime
${color #55aaff}Load:${color} $loadavg
${color #55aaff}GPU: ${color}${exec lspci -d 10de:13c2 -k | command grep -Po '(?<=Kernel driver in use: ).*'} (${exec loginctl show-session $(loginctl | grep $(whoami) | awk '{print $1}') -p Type | grep -Po '(?<=Type=).*'})
${color #55aaff}Last Update: ${color}${execi 600 date -d $(grep --text "Running 'pacman -Syu'" /var/log/pacman.log | tail -1 | cut -d' ' -f1 | sed 's/[][]//g') '+%d-%m-%Y %H:%M:%S'}

${color #ffffff}${font Ubuntu mono:pixelsize=20,weight:Bold}CPU${font} ${hr 2}${color}

${color #55aaff}CPU: ${color #dddddd}Intel Core i5-4670${color} @ ${freq_g} GHz
CPU utilization$alignr ${color #ffffff}${cpu cpu0}%${color}
${color #5555ff}${cpubar cpu0}${color}
Core 1: ${color #5555ff}${cpubar cpu1 6,160}${color}  ${color #ffffff}${cpu cpu1}%${color}
Core 2: ${color #5555ff}${cpubar cpu2 6,160}${color}  ${color #ffffff}${cpu cpu2}%${color}
Core 3: ${color #5555ff}${cpubar cpu3 6,160}${color}  ${color #ffffff}${cpu cpu3}%${color}
Core 4: ${color #5555ff}${cpubar cpu4 6,160}${color}  ${color #ffffff}${cpu cpu4}%${color}
IOWait: ${color #ffff00}${execi 1 iostat -c 1 1 | tail -4 | head -1 | awk '{print $4}'}%${color}
${font Font Awesome 5 Free:style=Solid:size=12}${if_match ${lua get_cpu_temp 0} < 35}${else}${if_match ${lua get_cpu_temp 0} < 60}${else}${endif}${endif}${font} ${color #ff0000}${lua get_cpu_temp 0}°C | ${lua get_cpu_temp 1}°C ${lua get_cpu_temp 2}°C ${lua get_cpu_temp 3}°C ${lua get_cpu_temp 4}°C${color}

${color #ffffff}${font Ubuntu mono:pixelsize=20,weight:Bold}Memory${font} ${hr 2}${color}

MEM $alignc ${color #ffffff}$mem / $memmax $alignr $memperc%${color}
${color #00aa00}$membar${color}
SWAP $alignc ${color #ffffff}$swap / $swapmax $alignr $swapperc%${color}
${color #33cc00}$swapbar${color}
Dirty:   ${color #ffffff}${execi 2 grep Dirty: /proc/meminfo | cut -b 21-}${color} | Writeback:   ${color #ffffff}${execi 2 grep Writeback: /proc/meminfo | cut -b 21-}${color}

${color #ffffff}${font Ubuntu mono:pixelsize=20,weight:Bold}Top Processes${font} ${hr 2}${color}

${color #ffffff}$processes${color} processes

${color #dddddd}${font Ubuntu mono:pixelsize=14,weight:Bold}NAME               PID     CPU     MEM${font}${color}
${top name 1} $alignr ${top pid 1} ${top cpu 1}% ${top mem 1}%
${top name 2} $alignr ${top pid 2} ${top cpu 2}% ${top mem 2}%
${top name 3} $alignr ${top pid 3} ${top cpu 3}% ${top mem 3}%
${top name 4} $alignr ${top pid 4} ${top cpu 4}% ${top mem 4}%
${top name 5} $alignr ${top pid 5} ${top cpu 5}% ${top mem 5}%

${color #ffffff}${font Ubuntu mono:pixelsize=20,weight:Bold}Disk IO${font} ${hr 2}${color}

Disk IO Read (sda): $alignr ${color #ffffff}${diskio_read sda}${color}
Disk IO Write (sda): $alignr ${color #ffffff}${diskio_write sda}${color}
Disk IO Read (sdb): $alignr ${color #ffffff}${diskio_read sdb}${color}
Disk IO Write (sdb): $alignr ${color #ffffff}${diskio_write sdb}${color}

${color #ffffff}${font Ubuntu mono:pixelsize=20,weight:Bold}Network${font} ${hr 2}${color}

${color #dddddd}${font Ubuntu mono:pixelsize=14,weight:Bold}enp3s0${font}${color}
Up:      ${color #ffffff}${upspeed enp3s0}/s${color}
Down:    ${color #ffffff}${downspeed enp3s0}/s${color}
]]

function merge_conf(conf1, conf2)  --> merge tables
    if type(conf1) == 'table' and type(conf2) == 'table'
    then
	for k,v in pairs(conf2)
	do
		if type(v)=='table' and type(conf1[k] or false)=='table'
		then
			merge_conf(conf1[k],v)
		else
			conf1[k]=v
		end
	end
    end
    return conf1
end

