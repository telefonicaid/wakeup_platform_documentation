SUBDIRS = books
 
.PHONY: all subdirs $(SUBDIRS) clean gh_pages

all: clean subdirs
 
subdirs: $(SUBDIRS)
 
$(SUBDIRS):
	$(MAKE) -C $@

clean:
	rm -rf output

gh-pages: all
	git checkout gh-pages
	rm -rf doc
	mv output doc
	git add doc
	git commit --amend -m "Automatic documentation generation"
	git push origin gh-pages -f
	git checkout master
