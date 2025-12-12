#!/usr/bin/env python3
import os
import time
import subprocess
import gi
gi.require_version("Gtk", "3.0")
gi.require_version("AppIndicator3", "0.1")

from gi.repository import Gtk, AppIndicator3

CONFIG = os.path.expanduser("~/.config/gammastep/config.ini")

TIMER_DELAY=0.01

class GammaStepApplet:
    def __init__(self):
        self.indicator = AppIndicator3.Indicator.new(
            "gammastep-applet",
            "display-brightness-symbolic",
            AppIndicator3.IndicatorCategory.APPLICATION_STATUS,
        )
        self.indicator.set_status(AppIndicator3.IndicatorStatus.ACTIVE)
        self.redraw_ui(False)

    def create_menu_item(self, label, icon_name, callback):
        item = Gtk.ImageMenuItem(label=label)
        image = Gtk.Image.new_from_icon_name(icon_name, Gtk.IconSize.MENU)
        item.set_image(image)
        item.set_always_show_image(True)
        item.connect("activate", callback)
        return item

    def create_separator(self):
        line = Gtk.SeparatorMenuItem()
        return line

    def build_menu(self):
        menu = Gtk.Menu()

        if (self.is_running()):
            menu.append(self.create_menu_item("Toggle Off", "media-playback-start", self.toggle_gammastep))
        else:
            menu.append(self.create_menu_item("Toggle On", "media-playback-start-symbolic", self.toggle_gammastep))
        menu.append(self.create_separator())
        menu.append(self.create_menu_item("Set Warm (4000K)", "weather-clear-night", lambda _: self.set_temp(4000)))
        menu.append(self.create_menu_item("Set Neutral (5500K)", "weather-few-clouds", lambda _: self.set_temp(5500)))
        menu.append(self.create_menu_item("Set Cool (6500K)", "weather-clear", lambda _: self.set_temp(6500)))
        menu.append(self.create_separator())
        # menu.append(self.create_menu_item("Reset Temperature", "edit-undo-symbolic", self.reset_temp))
        menu.append(self.create_menu_item("Restart GammaStep", "view-refresh-symbolic", self.restart_gammastep))
        menu.append(self.create_menu_item("Quit Applet", "application-exit-symbolic", Gtk.main_quit))

        menu.show_all()
        self.indicator.set_menu(menu)

    def is_running(self):
        return subprocess.call(["pgrep", "-x", "gammastep"], stdout=subprocess.DEVNULL) == 0

    def toggle_gammastep(self, _):
        was_running = self.is_running()
        if self.is_running():
            subprocess.call(["pkill", "-x", "gammastep"])
        else:
            subprocess.Popen(["gammastep", "-c", CONFIG])
        
        self.redraw_ui(was_running)

    def restart_gammastep(self, _):
        subprocess.call(["pkill", "-x", "gammastep"])
        
        while subprocess.call(["pgrep", "-x", "gammastep"], stdout=subprocess.DEVNULL) == 0:
            time.sleep(TIMER_DELAY)

        subprocess.Popen(["gammastep", "-c", CONFIG])
        self.redraw_ui(self.is_running())

    def set_temp(self, temp):
        running = self.is_running()
        if self.is_running():
            subprocess.call(["pkill", "-x", "gammastep"])

            while subprocess.call(["pgrep", "-x", "gammastep"], stdout=subprocess.DEVNULL) == 0:
                time.sleep(TIMER_DELAY)

        subprocess.Popen(["gammastep", "-P", "-O", str(temp)])

        self.redraw_ui(False)

    def reset_temp(self, _):
        subprocess.call(["gammastep", "-x"])
        self.redraw_ui(self.is_running())

    def update_icon(self):
        icon =  "weather-clear-symbol" if self.is_running() else "display-brightness-symbolic"
        self.indicator.set_icon(icon)

    def redraw_ui(self, wait=True):
        while wait and subprocess.call(["pgrep", "-x", "gammastep"], stdout=subprocess.DEVNULL) == 0:
            time.sleep(TIMER_DELAY)

        self.update_icon()
        self.build_menu()

if __name__ == "__main__":
    GammaStepApplet()
    Gtk.main()

