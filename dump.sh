#!/bin/sh

aspell -l nl dump master \
   | iconv -f utf8 -t ascii//translit \
   | tr '[A-Z]' '[a-z]' \
   | egrep '^[a-z]+$' \
   | sort \
   | uniq \
   > Nederlands.list

aspell -l en_GB dump master \
   | iconv -f utf8 -t ascii//translit \
   | tr '[A-Z]' '[a-z]' \
   | egrep '^[a-z]+$' \
   | sort \
   | uniq \
   > 'English (GB).list'

aspell -l en_US dump master \
   | iconv -f utf8 -t ascii//translit \
   | tr '[A-Z]' '[a-z]' \
   | egrep '^[a-z]+$' \
   | sort \
   | uniq \
   > 'English (US).list'
