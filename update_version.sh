#!/bin/sh
git flow release start v$1
sed -i -e "s/__version__ = '.*'/__version__ = '$1'/g" keybase/__init__.py
python setup.py develop
git commit keybase/__init__.py -m "Update to version v$1"
git flow release finish v$1
python setup.py bdist_egg upload -r pypi
python setup.py sdist upload -r pypi
