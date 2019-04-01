==================
 kgadek.github.io
==================
--------------------
 Source of the blog
--------------------

:Author: Konrad Gądek

.. contents::


About
=====

I like pie.


Building the site
=================

Build the binary, rebuild the blog::

    zola build


Setting up git hooks
====================

.. note::
   This section needs updating.

::

    ln scripts/pre-commit-hook.sh .git/hooks/pre-commit


Updating the site (graft way)
=============================

Create ``master`` branch::

    git checkout --orphan master
    git commit --allow-empty --no-verify  -S -m 'Init'

Create new ``master`` from current ``develop``::

    git checkout master
    git rm -rf .
    git read-tree develop^{tree}:_site
    git checkout -- .
    git commit --no-verify -m "Deploy from develop SHA1:$(git rev-parse --short develop) ($(git log -1 --format=%cd develop))"
    git replace --graft @ $(git show --pretty=%P @ | head -n1) develop
    git commit --amend -S --no-edit --no-verify
