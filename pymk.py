#!/usr/bin/python3
from mkpy.utility import *
assert sys.version_info >= (3,2)

#TODO: Resume installation where we lef off if something goes wrong
def default():
    bashrc ()
    vim ()

def fedora_packages ():
    ex ('sudo dnf install ' + \
            ' '.join([
                'gcc', 'gcc-c++', 'make', 'cmake' ,'automake',
                # Required by YouCompleteMe (vim plugin)
                'python-devel', 'python3-devel'
                ]))

def vim ():
    ex ('cp -r vim ~/.vim')
    ex ('cp vimrc ~/.vimrc')

    ex ('git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim')
    ex ('gvim +PluginInstall +qall')
    ex ('~/.vim/bundle/YouCompleteMe/install.py')

def bashrc ():
    if ex ('diff bashrc ~/.bashrc') == 1:
        ex ('mv ~/.bashrc ~/.bashrc.bak')
        ex ('cp bashrc ~/.bashrc')

if __name__ == "__main__":
    if get_cli_option ('--get_deps_pkgs'):
        get_target_dep_pkgs ()
        exit ()
    pymk_default()

