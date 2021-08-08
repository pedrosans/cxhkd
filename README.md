# cxhkd

Per context X hotkey daemon

* Code/mask pairs in the accelerator strings are cached as contexts in a tree
	- each context can also point to a command
* Handles key presses
	- no handling for key release and mapping notify
* Grabs the entire keyboard and the next pressed code/mask pairs can:
	- stop the key streak
		- and execute a command: if the current context has no child matching the last pressed code/mask pair
		- and do nothing: any key, but the modifiers, not listed in the current context children stops the streak (no dedicated key is configured to do it)
	- keep the key streak
		- and execute a command
		- and do nothing
* Can be configured to autostart: `cxhkd -a` writes the cxhkd.desktop honoring XDG specification
* Commands and keys are defined in the module: `~/.config/cxhkd/cxhkd.py`


### Config module

```python
ctrl_Return = \
	'pocoy window zoom'

ctrl_t = \
	'pocoy layout T'

ctrl_u = \
	'pocoy layout A'

ctrl_m = \
	'pocoy layout M last'

ctrl_shift_Return = \
	'alacritty'

ctrl_shift_j = \
	'pocoy window pushstack 1'

ctrl_shift_k = \
	'pocoy window pushstack -1'

class ctrl_e:
	pass

ctrl_e.q = \
	'xdotool getactivewindow windowminimize'

ctrl_e.o = \
	'pocoy only'

ctrl_e.h = ctrl_e.ctrl_h = \
	'pocoy focus left'

ctrl_e.j = ctrl_e.ctrl_j = \
	'pocoy focus down'

ctrl_e.k = ctrl_e.ctrl_k = \
	'pocoy focus up'

ctrl_e.l = ctrl_e.ctrl_l = \
	'pocoy focus right'

ctrl_e.e = ctrl_e.ctrl_e = ctrl_e.p = ctrl_e.ctrl_p = \
	'pocoy focus previous'

```

### Local build

Install

```
./setup.py install --record installed_files.txt
```

Uninstall

```
cat installed_files.txt | xargs rm -rf ; rm -f installed_files.txt
```

Manual

```shell
groff -mman cxhkd.1 -T utf8 | less
```

Debian dependencies

```bash
python3-distutils python3-xdg python3-xlib python3-gi gir1.2-gtk-3.0
```

Arch dependencies

```bash
python-pyxdg python-xlib gobject-introspection-runtime
```


### Remote build

```bash
sudo add-apt-repository ppa:pedrosans/pocoy
sudo apt-get update
sudo apt-get install cxhkd
```
