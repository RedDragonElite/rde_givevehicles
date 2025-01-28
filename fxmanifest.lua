fx_version 'cerulean'
games { 'gta5' }

author 'SerpentsByte'
description 'Give owned DLC Cars. ESX Legacy.'
version '1.0.0'

lua54 'yes'
shared_script { 
	'@ox_lib/init.lua',
    '@es_extended/imports.lua',
}	
server_script {
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'server.lua'
}
client_script 'client.lua'

dependencies {
    'ox_lib',
    'es_extended',
    'oxmysql'
}

