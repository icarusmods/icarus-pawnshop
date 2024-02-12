fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Icarus Modding'
description 'QB-Core based pawnshop using ox_lib!'
version '1.1.1'

client_scripts {
    'client.lua',
}

server_scripts {
    'server.lua',
}

shared_scripts {
    'shared/words.lua',
    'shared/config.lua',
    '@ox_lib/init.lua'
}

provides { 'qb-pawnshop' }