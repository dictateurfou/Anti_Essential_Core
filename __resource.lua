ui_page('html/index.html')

files({
    'html/index.html',
    'html/script.js',
    'html/font/pricedown.ttf',
    'html/style.css'
})

client_script 'client.lua'
server_script '@mysql-async/lib/MySQL.lua'
server_script 'utils.lua'
server_script 'log.lua'
server_script 'server.lua'

server_exports {
    'test',
    'getIdentifier',
    'getPlayerInfo',
    'getPlayerAllMoney',
    'refreshMoney',
    'removeMoney',
    'AddMoney',
    'addBank',
    'removeBank',
    'removeDirtyMoney',
    'addDirtyMoney',
    'setDirtyMoney',
    'removeMoneyForBank',
    'removeBankForMoney',
    'FetchAllForResult',
}