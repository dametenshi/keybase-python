# keybase-python

[![Build Status](https://travis-ci.org/ianchesal/keybase-python.svg?branch=develop)](https://travis-ci.org/ianchesal/keybase-python)

A Python implementation of the keybase.io API

## What is Keybase?

From [their website](https://keybase.io/):

> Keybase is two things.
> 
> 1. a public, publicly-auditable directory of keys and identity proofs
> 1. a protocol (this API) for accessing the directory

Keybase has an existing command line written in Node.js as well as [a well documented HTTP API](https://keybase.io/__/api-docs/1.0). This Python API is mostly an experiment for my own edification and hopefully it becomes something useful for everyone. I was smitten with Keybase's nice HTML API and thought, "Why not?".

## Documentation

The official documentation for the project can be found here: http://keybase-python-api.readthedocs.org/en/latest/

### Installation

    pip install keybase-api

## Examples

See the [official documentation](http://keybase-python-api.readthedocs.org/en/latest/) for more examples of how to use the API.

### Get a User's Credentials

	kbase = Keybase('irc')
	primary_key = kbase.get_public_key()
	primary_key.kid
	u'0101f56ecf27564e5bec1c50250d09efe963cad3138d4dc7f4646c77f6008c1e23cf0a'

You can use the `ascii` or `bundle` properties on the `primary_key` object in the above example to get an ASCII version of their primary public key, suitable for feeding in to a signature verification or encryption routine.

### Use a User's Public Key to Verify the Signature on a Signed File

Where the file was signed with a `gpg` command like so:

    gpg -u keybase.io/irc --sign helloworld.txt

So there is one, binary, file `helloworld.txt.gpg` that contains both the data and the signature on the data to verify.

    kbase = Keybase('irc')
    verified = kbase.verify_file('helloworld.txt.gpg')
    assert verified

Where the file was signed with a `gpg` command like so:

	gpg -u keybase.io/irc --detach-sign helloworld.txt

So there are two files:

1. The original data file; and
1. The detached `.sig` file that contains the signature for the data.

In this case:

    kbase = Keybase('irc')
    fname = 'helloworld.txt'
    sigfname = 'helloworld.txt.sig'
    verified = kbase.verify_file(fname, sigfname)
    assert verified

### Use a User's Public Key to Encrypt a Message to that User

Given some `str` formatted data, you can create an ASCII armored, encrypted `str` representation of that data suitable for sending to the user. Only someone with the private key will be able to decrypt this data.

    kbase = Keybase('irc')
    instring = 'Hello, world!'
    encrypted = kbase.encrypt(instring)
    assert encrypted
    assert not encrypted.isspace()
    assert encrypted != instring

## Development

### GnuPG

Most of the testing was done against GnuPG:

    > gpg2 --version
    gpg (GnuPG) 2.0.22
    libgcrypt 1.6.1
    Copyright (C) 2013 Free Software Foundation, Inc.
    License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
    This is free software: you are free to change and redistribute it.
    There is NO WARRANTY, to the extent permitted by law.

    Home: ~/.gnupg
    Supported algorithms:
    Pubkey: RSA, ELG, DSA, ECC, ?
    Cipher: IDEA, 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH,
            CAMELLIA128, CAMELLIA192, CAMELLIA256
    Hash: MD5, SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
    Compression: Uncompressed, ZIP, ZLIB, BZIP2

### Continuous Integration

I'm using Travis CI to build and test on every push to the public github repository. You can find the Travis CI page for this project here: https://travis-ci.org/ianchesal/keybase-python/

The project is currently setup in Travis to test Python 2.6, 2.7 and 3.3. But only 2.7 is being targetted at this point and time and 2.6, 3.3 are listed as allowed-to-fail in the .travis.yml file for the project.

### Branching in Git

I'm using [git-flow](http://nvie.com/posts/a-successful-git-branching-model/) for development in git via github. I've loved the branching model git-flow proposed from day one and the addon to git makes it very intuitive and easy to follow. I generally don't push my `feature/*` branches to the public repository; I do keep `development` and `master` up to date here though.

### TODO Work

Please see [TODO.md](TODO.md) for the short list of big things I thought worth writing down.

## Contact Me

Questions or comments about `keybase`? Hit me up at ian.chesal@gmail.com.
