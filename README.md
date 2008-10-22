Radiant Extensions
===

Extensions to Radiant core.

Tested on Radiant 0.6.9.

Tag Parsing
---

This extends the way Radius parses tags, allowing you to "nest" tags inside the attributes of
another tag.

Example:

    <r:link id="<r:slug/>-id" />

Generates:

    <a href="/example-page" id="example-page-id">Example Page</a>
    
Tags
---

* Extendend `<r:if_children />` to specify minimum number of children.
* Added `<r:meta:if_description>` to test for description attribute in Page.
* Added `<r:set />` and `<r:get />` tags for setting/getting variables.
* Added `<r:if_matches>` for regular expression matching against any value.
