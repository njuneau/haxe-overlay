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

To use the overlay, perform the following. We assume that your overlays reside in  **/usr/local/portage**.

1. Add the following in **/etc/portage/repos.conf/haxe-overlay.conf**::

    [haxe-overlay]
    location = /usr/local/portage/haxe-overlay
    sync-type = git
    sync-uri = https://github.com/njuneau/haxe-overlay.git

2. Since the ebuilds reside in a new category named *dev-haxe*, add the following in **/etc/portage/categories**::

       dev-haxe

3. Sync your repositories. For example, perform the following::

       emaint sync -a

Installing Haxe
---------------

If you are on Gentoo stable, you need to add the ebuilds in **/etc/portage/package.keywords**. The two ebuilds are:

* dev-haxe/neko
* dev-haxe/haxe
