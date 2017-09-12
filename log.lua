local dlog = os.date("%A-%d_%H-%M-%S")
print('Log File : logs/log_' .. dlog .. '.log')
os.execute("mkdir logs")
local fileLog = io.open('logs/log_' .. dlog .. '.log', 'w+')

function ecrireLog(log)
	fileLog:write(os.date("%Y/%m/%d %X") .. ' | ' .. log .. '\r\n')
	fileLog:flush()
end