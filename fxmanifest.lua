
fx_version 'cerulean'
game 'gta5'

lua54 'yes'

description 'Lizenzierter Blackmarket Shop'
author 'CCP'

shared_script '@ox_lib/init.lua'

client_script 'client.lua'
server_script 'server.lua'

shared_script 'config.lua'

dependency 'es_extended'
dependency 'oxmysql'
