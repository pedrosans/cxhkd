CXHKD_PATH=.
SETUP_SCRIPT=${CXHKD_PATH}/setup.py
VERSION=$(shell git describe --abbrev=0 --tags $(git rev-list --tags --skip=0 --max-count=1))
LAST_VERSION=$(shell git describe --abbrev=0 --tags $(git rev-list --tags --skip=1 --max-count=1))

.SILENT:
install:
	python3 ${SETUP_SCRIPT} install --record $(CXHKD_PATH)/installed_files.txt 1>/dev/null
uninstall:
	cat $(CXHKD_PATH)/installed_files.txt | xargs rm -rf ; rm -f $(CXHKD_PATH)/installed_files.txt
manual:
	$(info Manual version ${VERSION})
	sed "s/VERSION/$(VERSION)/" cxhkd.1 > cxhkd.1~
	gzip -c cxhkd.1~ > cxhkd.1.gz
	rm cxhkd.1~
binaries:
	$(info Packing binaries for version ${VERSION}, after: ${LAST_VERSION})
	python3 ${SETUP_SCRIPT} --command-packages=stdeb.command bdist_deb 1>/dev/null && echo "Binaries packaged"
sources:
	$(info Packing version ${VERSION}, after: ${LAST_VERSION})
	python3 ${SETUP_SCRIPT} --command-packages=stdeb.command sdist_dsc --forced-upstream-version ${VERSION} 1>/dev/null
	echo "	SUCCESS The file deb_dist/cxhkd_${VERSION}-1_source.changes can describe the changes in this version"
publish:
	debsign -pgpg2 ${CXHKD_PATH}/deb_dist/cxhkd_${VERSION}-1_source.changes
	cd ${CXHKD_PATH}/deb_dist && dput ppa:pedrosans/pocoy cxhkd_${VERSION}-1_source.changes
	echo "Published"
clean:
	[ ! -f ${CXHKD_PATH}/tags ]                || rm -f  ${CXHKD_PATH}/tags                
	[ ! -f ${CXHKD_PATH}/cxhkd-*.tar.gz ]      || rm -f  ${CXHKD_PATH}/cxhkd-*.tar.gz      
	[ ! -f ${CXHKD_PATH}/MANIFEST ]            || rm -f  ${CXHKD_PATH}/MANIFEST            
	[ ! -f ${CXHKD_PATH}/installed_files.txt ] || rm -f  ${CXHKD_PATH}/installed_files.txt 
	[ ! -d ${CXHKD_PATH}/build ]               || rm -rf ${CXHKD_PATH}/build               
	[ ! -d ${CXHKD_PATH}/deb_dist ]            || rm -rf ${CXHKD_PATH}/deb_dist           
	[ ! -d ${CXHKD_PATH}/dist ]                || rm -rf ${CXHKD_PATH}/dist                
	echo Build and packaging artefacts were cleaned
