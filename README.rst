=================
 konradgadek.xyz
=================
--------------------
 Source of the blog
--------------------

:Author: Konrad Gądek

.. image:: https://github.com/kgadek/kgadek.github.io/actions/workflows/ci.yml/badge.svg?branch=develop
   :target: https://github.com/kgadek/kgadek.github.io/actions/workflows/ci.yml

About
=====

I like pie.


Notes
=====

Build the binary, rebuild the blog::

    zola build

Set up git hook::

    ln scripts/pre-commit-hook.sh .git/hooks/pre-commit

Releasing the site::

    ./scripts/release.sh

