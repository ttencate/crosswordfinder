#!/bin/sh

LIST_DIR=lists
mkdir -p $LIST_DIR

aspell -l nl dump master \
   | iconv -f utf8 -t ascii//translit \
   | tr '[A-Z]' '[a-z]' \
   | egrep '^[a-z]+$' \
   | sort \
   | uniq \
   > $LIST_DIR/Nederlands

aspell -l en_GB dump master \
   | iconv -f utf8 -t ascii//translit \
   | tr '[A-Z]' '[a-z]' \
   | egrep '^[a-z]+$' \
   | sort \
   | uniq \
   > $LIST_DIR/'English (GB)'

aspell -l en_US dump master \
   | iconv -f utf8 -t ascii//translit \
   | tr '[A-Z]' '[a-z]' \
   | egrep '^[a-z]+$' \
   | sort \
   | uniq \
   > $LIST_DIR/'English (US)'
