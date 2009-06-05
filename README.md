Radiant Extensions
===

About
---

A [Radiant][rd] Extension by [Aissac][ai] that adds some new tags to Radiant core.

Tested on Radiant 0.6.9. 0.7.1 and 0.8

Installation
---

[Radiant Extensions Extension][ree] has no dependencies, so all you have to do it install it

    git submodule add git://github.com/Aissac/radiant-extensions-extension.git vendor/extensions/radiant_extensions

Usage
---

This extension extends the way Radius parses tags, allowing you to "nest" tags inside the attributes of
another tag.

Example:

    <r:link id="<r:slug/>-id" />

Generates:

    <a href="/example-page" id="example-page-id">Example Page</a>
    
###Available Tags

* See the "available tags" documentation built into the Radiant page admin for more details.
* Extendend `<r:if_children />` to specify minimum number of children.
* Added `<r:meta:if_description>` to test for description attribute in Page.
* Added `<r:set />` and `<r:get />` tags for setting/getting variables.
* Added `<r:if_matches>` for regular expression matching against any value.

Contributors
---

* Istvan Hoka
* Cristi Duma

[rd]: http://radiantcms.org/
[ai]: http://www.aissac.ro/
[ree]: http://blog.aissac.ro/radiant/extensions-extension/