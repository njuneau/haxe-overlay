Haxe overlay
============

Summary
-------

This repository contains Gentoo ebuilds for the following software:

* Haxe 3.4.x
* Neko 2.1.x

Please note that the ebuilds are **experimental** and **unofficial**. Contributions welcome!

Supported architectures
-----------------------

* amd64

Overlay installation
--------------------

Add the dev-haxe category
`````````````````````````

Since the ebuilds reside in a new category named *dev-haxe*, add the following in **/etc/portage/categories**::

       dev-haxe

Option 1) Manual repository installation
````````````````````````````````````````

To use the overlay, perform the following. We assume that your overlays reside in  **/usr/local/portage**.

1. Add the following in **/etc/portage/repos.conf/haxe-overlay.conf**::

    [haxe-overlay]
    location = /usr/local/portage/haxe-overlay
    sync-type = git
    sync-uri = https://github.com/njuneau/haxe-overlay.git


3. Sync your repositories. For example, perform the following::

       emaint sync -a

Option 2) Using Layman
``````````````````````

While the overlay is not yet registered in the main Gentoo overlay list, you still can use the following command to add
*haxe-overlay* to Layman's recognized list of overlays::

    layman -o https://raw.githubusercontent.com/njuneau/haxe-overlay/master/repository.xml

This should make *haxe-overlay* visible to Layman. If you perform the following::

    layman -L

**haxe-overlay** should appear with the Git coordinates pointing to this repository.

Installing Haxe
---------------

If you are on Gentoo stable, you need to add the ebuilds in **/etc/portage/package.keywords**. The two ebuilds are:

* dev-haxe/neko
* dev-haxe/haxe
