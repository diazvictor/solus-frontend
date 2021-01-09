--[[--
 @package   Solus Frontend
 @filename  init.lua
 @version   1.0
 @author    Díaz Urbaneja Víctor Eduardo Diex <victor.vector008@gmail.com>
 @date      07.01.2021 19:33:02 -04
]]

package.path = package.path .. ';../lib/?.lua'

print("Loading libraries:")
lgi = require 'lgi'
print("| 'lgi' loaded successfully. (Thanks Pavouk!)")

GObject = lgi.GObject
Gtk = lgi.require('Gtk', '3.0')
Gdk = lgi.Gdk
GLib = lgi.GLib
GdkPixbuf = lgi.GdkPixbuf

require 'solus'
print("Libraries loaded!\n")

assert = lgi.assert
local builder = Gtk.Builder()
assert(builder:add_from_file('../data/gtk/main_window.ui'), 'ERROR: the file does not exist')
ui = builder.objects

ui.head:pack_end(Gtk.Box {
	orientation = 'HORIZONTAL',
	spacing = 6,
	Gtk.Button {
		on_clicked = function ()
			print('Click!')
		end
	},
	Gtk.Separator {},
	Gtk.MenuButton {
		id = 'btn_menu',
		Gtk.Image {
			icon_name = 'open-menu-symbolic'
		}
	}
}, false, false, 0)

ui.head.child.btn_menu:set_popover(ui.menu)

require 'gamelist'
require 'gameinfo'

function ui.main_window:on_destroy()
	db:close()
	Gtk.main_quit()
end

ui.main_window:show_all()
Gtk.main()
