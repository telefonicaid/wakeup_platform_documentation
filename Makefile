SUBDIRS = books
 
.PHONY: all subdirs $(SUBDIRS) clean gh_pages

all: clean version.info subdirs
 
subdirs: $(SUBDIRS)
 
$(SUBDIRS):
	$(MAKE) -C $@

version.info:
	@echo "Getting version information from GIT ..."
	@git describe --all --always > version.info
	@echo " - Version = " `cat version.info`
	@date > date.info
	@echo " - Date = " `cat date.info`

clean:
	rm -rf output
	rm -f version.info
	rm -f date.info

gh-pages: all
	git checkout gh-pages
	rm -rf doc
	mv output doc
	git add doc
	git commit --amend -m "Automatic documentation generation"
	git push origin gh-pages -f
	git checkout master
