# git-annex-remote-pcloud #

**git-annex-remote-pcloud** is a [git-annex](https://git-annex.branchable.com/) external remote that uses [pCloud](https://www.pcloud.com/) for storage.

*Homepage:* https://github.com/tochev/git-annex-remote-pcloud


## Disclaimer ##

*git-annex-remote-pcloud* is still experimental. Although it should be reliable please for the time being *keep additional copies of all data you do not want to lose*.

**I will not be held responsible for any data you lose as a result of using this software.**


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

    The file with credentials should be in one of the following formats:
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

Just like any other git annex remote, see the git-annex manual.

    $ git annex copy . --to mypcloud
    $ git annex copy . --from mypcloud
    $ git annex drop FILE --from mypcloud
    $ git annex fsck --from mypcloud [--numcopies=2]
    $ git annex unused --from mypcloud
    $ git annex sync mycploud [--content]


## License ##

Distributed under MIT.


## Authors ##

Developed by Tocho Tochev [tocho AT tochev DOT net].


## FAQ ##

#### How stable is it? ####

See the Disclaimer section.

#### Backups ####

You should backup the configuration like you would do for any other git-annex remote.

Below is a list of git-annex hacks.

Cloning the repo and configuring the remote in the new repo.

    git clone OLD_REPO NEW_REPO
    cd NEW_REPO
    vim .git/config
    # Add the git annex remote configuration from OLD_REPO/.git/config
    # It should be something like:
    #   [remote "mypcloud"]
    #       annex-externaltype = pcloud
    #       annex-uuid = 38578a06-ff82-11e3-9b07-cb7a506f0b17
    #       annex-cost = 200.0
    #       annex-availability = GloballyAvailable

The parameters of the git-annex remotes are kept in remote.log in the git-annex branch:

    git show-file git-annex:remote.log | less


#### Ok, I want to help. What can I do? ####

You can:

 - spread the word
 - tip me in bitcoin: 1CeVgiDoBJRUycycKZwkcwzpsB3oyZUtmR or litecoin: LYDMbejmRq7xr4f7ou3wonJ6VsstPb31sM
 - implement an improvement, I accept patches
 - suggest an improvement
