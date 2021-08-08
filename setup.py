#!/usr/bin/env python3
from distutils.core import setup
setup(
	name='cxhkd',
	version='0.2',
	description='Per context X hotkey daemon',
	author='Pedro Santos',
	author_email='pedrosans@gmail.com',
	url='https://github.com/pedrosans/cxhkd',
	classifiers=['License :: GPL3'],
	scripts=['cxhkd'],
	data_files=[('/usr/share/man/man1/', ['cxhkd.1.gz'])],
)
# eof
