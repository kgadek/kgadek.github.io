==================
 kgadek.github.io
==================
--------------------
 Source of the blog
--------------------

:Author: Konrad Gądek

.. image:: https://circleci.com/gh/kgadek/kgadek.github.io/tree/develop.svg?style=svg
   :target: https://circleci.com/gh/kgadek/kgadek.github.io/tree/develop

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

