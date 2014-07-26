categorize-inbox-to-fs
======================

> Read contents of files supported by Tika extractor and categorize them into filesystem directories.

Building
========

    gulp
    

Running the binary
==================

    ./bin/sortinbox.js --src=path/to/scanned/doc/*.pdf


Rules customization
===================

You can extend the functionality at `src/predicate/document-type/index.coffee`.


Contributing
============

Open a new ticket on Github