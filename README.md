# cxhkd

Per context X hotkey daemon

Commands and keys are defined in the config module: `~/.config/cxhkd/cxhkd.py`

* Code/mask pair in the accelerator strings are cached
* Only handles key presses (ignores key release and mapping notify)
* Grabs the keyboard if the pressed code/mask identifies a context with nested contexts, starting a key streak
* Any key, but the modifiers, not listed in the current context stops the streak (no dedicated key)

### Example config file

```python
ctrl_Return = \
	'pocoy window zoom'

ctrl_t = \
	'pocoy layout T'

ctrl_u = \
	'pocoy layout A'

ctrl_m = \
	'pocoy layout M last'

ctrl_shift_x = \
	'xdotool getactivewindow windowkill'

ctrl_shift_Return = \
	'alacritty'

ctrl_shift_j = \
	'pocoy window pushstack 1'

ctrl_shift_k = \
	'pocoy window pushstack -- -1'


class ctrl_e: pass


ctrl_e.q = \
	'xdotool getactivewindow windowminimize'

ctrl_e.o = \
	'pocoy only'

ctrl_e.e = ctrl_e.ctrl_e = ctrl_e.p = ctrl_e.ctrl_p = \
	'pocoy focus previous'

ctrl_e.h = ctrl_e.ctrl_h = \
	'pocoy focus left'

ctrl_e.j = ctrl_e.ctrl_j = \
	'pocoy focus down'

ctrl_e.k = ctrl_e.ctrl_k = \
	'pocoy focus up'

ctrl_e.l = ctrl_e.ctrl_l = \
	'pocoy focus right'

```

### Locally

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


### PPA

```bash
sudo add-apt-repository ppa:pedrosans/pocoy
sudo apt-get update
sudo apt-get install cxhkd
```
