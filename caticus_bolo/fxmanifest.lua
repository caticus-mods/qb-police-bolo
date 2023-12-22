fx_version 'cerulean'

games { 'gta5' }

author 'caticus'

client_script 'client.lua'

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  "server.lua",
  'config.lua'
}

ui_page{
    'ui/index.html'
}

files {
    'ui/*.*',
    'ui/**/*.*',
}
dependencies {
  'qb-core'
}

