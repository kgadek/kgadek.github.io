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

Build the binary, rebuild the blog, add the blog::

    stack build
    stack exec site rebuild
    git add _site

You can automate the process by using ``pre-commit`` hook::

    cp pre-commit .git/hooks/pre-commit


Updating the site
=================

Create ``master`` branch::

    git checkout --orphan master
    git commit --allow-empty --no-verify  -S -m 'Init'

Create new ``master`` from current ``develop``::

    git checkout master
    git rm -rf .
    git read-tree develop^{tree}:_site
    git checkout -- .
    git show develop:LICENSE > LICENSE
    git add LICENSE
    git commit --no-verify -m "Deploy from develop SHA1:$(git rev-parse --short develop) ($(git log -1 --format=%cd develop))"
    git replace --graft @ $(git show --pretty=%P @ | head -n1) develop
    git commit --amend -S --no-edit --no-verify
