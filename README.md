# git-annex-remote-pcloud #

**git-annex-remote-pcloud** is a [git-annex](https://git-annex.branchable.com/) external remote that uses [pCloud](https://www.pcloud.com/) for storage.

*Homepage:* https://github.com/tochev/git-annex-remote-pcloud


## Disclaimer ##

*git-annex-remote-pcloud* is still experimental. Although it should be reliable please for the time being *keep additional copies of all data you do not want to loose*.

**I will not be held responsible for any data you loose as a result of using this software.**


## Install ##

Install `python3`, `python3-requests`:

    sudo apt-get install python3 python3-python-requests

Get the project:

    git clone https://github.com/tochev/git-annex-remote-pcloud

Initialize the git submodule containing *python3-pcloudapi*:

    cd git-annex-remote-pcloud
    git submodule update --init

Create a symlink to `git-annex-remote-pcloud` in your path:

    sudo ln -s GIT_ANNEX_REMOTE_PLCOUD_HOME/git-annex-remote-pcloud /usr/bin/


## Usage ##

Use it as you would use any git-annex remote.

### Usage ###

    $ git-annex-remote-pcloud --help
    This program is supposed to run only called by git annex!!

    To use it execute:
        PCLOUD_CREDENTIALS_FILE=/path/to/file \
        git annex initremote mypcloud type=external externaltype=pcloud \
            path=PCLOUD_FOLDER(default /annex) [credentials_file=~/.pcloud_auth] \
            encryption=none|shared|hybrid|pubkey

    The file with credentials should be one of:
        - two lines (username and password)
        - one line (authentication token)

    If the credentials file is supplied as an environment variable an authentication
    token will be acquired and saved in the git annex configuration.

### PCloud Remote Setup ###

    $ cat ~/.pcloud_auth
    pclouduser@somedomain.com
    very-SECRET-pass
    $ git annex initremote mypcloud type=external externaltype=pcloud \
        path=PCLOUD_FOLDER credentials_file=~/.pcloud_auth encryption=shared

### Using the Remote ###

Just like any other git annex remote:

    $ git annex copy . --to mypcloud
    $ git annex copy . --from mypcloud
    $ git annex drop FILE --from mypcloud
    $ git annex fsck --from mypcloud
    $ git annex unused --from mypcloud


## License ##

Distributed under MIT.


## Authors ##

Developed by Tocho Tochev [tocho AT tochev DOT net].


## FAQ ##

#### How stable is it? ####

See section Disclaimer.

#### Ok, I want to help. What can I do? ####

You can:

 - spread the word
 - tip me in bitcoin: 1CeVgiDoBJRUycycKZwkcwzpsB3oyZUtmR or litecoin: LYDMbejmRq7xr4f7ou3wonJ6VsstPb31sM
 - implement an improvement, I accept patches
 - suggest an improvement
