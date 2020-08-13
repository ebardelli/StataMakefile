# Stata setup
ifeq ($(OS),Windows_NT)
	STATA = "C:\Program Files\Stata16\StataSE-64.exe"
	FLAGS = do "C:\ado\run.do"
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Darwin)
        STATA = /usr/local/bin/stata-se
        FLAGS = -e do
    endif
endif

doFiles = $(wildcard doFiles/*.do)
logFiles = $(patsubst doFiles/%,$Logs/%,$(doFiles:%.do=%.log))

.PHONY: all clean_logs clean_doc clean_all

all: $(logFiles)

memo: Documentation/memo.docx

Documentation/memo.docx: Documentation/memo.md
	cd Documentation && pandoc memo.md --filter pandoc-citeproc -o memo.docx

Logs/%.log: doFiles/%.do
	$(STATA) $(FLAGS) $<

clean_logs:
	rm $(logFolder)/*.log

clean_doc:
	rm Documentation/memo.docx

clean_all: clean clean_logs
