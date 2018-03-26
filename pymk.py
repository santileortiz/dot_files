#!/usr/bin/python3
from mkpy.utility import *
import textwrap
assert sys.version_info >= (3,2)

#TODO: Resume installation where we lef off if something goes wrong
def default():
    bashrc ()
    vim ()

def fedora_packages ():
    ex ('sudo dnf install ' + \
            ' '.join([
                'gcc', 'gcc-c++', 'make', 'cmake' ,'automake', 'gvim', 'vim',
                # Required by YouCompleteMe (vim plugin)
                'python-devel', 'python3-devel'
                ]))

def vim ():
    ex ("rsync -avc ./vim/ ~/.vim")
    ex ('rsync -avc vimrc ~/.vimrc')

    ex ('git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim')
    ex ('vim +PluginInstall +qall')
    ex ('~/.vim/bundle/YouCompleteMe/install.py')

def bashrc ():
    if ex ('diff bashrc ~/.bashrc') == 1:
        ex ('mv ~/.bashrc ~/.bashrc.bak')
        ex ('cp bashrc ~/.bashrc')

def vim_update ():
    ex ("rsync -avc --exclude='/bundle' --exclude='/.netrwhist' --exclude='/.VimballRecord' ~/.vim/ ./vim/")
    ex ('rsync -avc ~/.vimrc ./vimrc')

def install_keyboard ():
    def seek_section_start (f):
        line = f.readline ()
        while '{' not in line:
            line = f.readline ()
        return line

    def extract_section (f, out_name):
        section = seek_section_start (f)
        brace_cnt = 1

        while brace_cnt > 0:
            line = f.readline ()
            if '{' in line:
                brace_cnt += 1
            if '}' in line:
                brace_cnt -= 1

            section += line

        out = open (out_name, "w")
        out.write (section)

    def insert_into_file (fname, prev_line, content, before=False):
        src = ''
        with open (fname, "r") as f:
            src = f.read().split('\n')

        res = ""
        for line in src:
            if line.rstrip().lstrip() == prev_line and before:
                res += content + '\n'

            res += line + '\n'

            if line.rstrip().lstrip() == prev_line and not before:
                res += content + '\n'

        f = open (fname, "w")
        f.write (res)
        f.close ()


    f = open ("custom_keyboard.xkb", "r")
    seek_section_start (f)
    extract_section (f, "santiago_k")
    extract_section (f, "santiago_t")
    extract_section (f, "santiago_c")
    extract_section (f, "santiago")
    f.close ()

    ex ('mv santiago_k /usr/share/X11/xkb/keycodes/')
    ex ('mv santiago_t /usr/share/X11/xkb/types/')
    ex ('mv santiago_c /usr/share/X11/xkb/compat/')
    ex ('mv santiago /usr/share/X11/xkb/symbols/')

    # Setup the system so it knows about the new layout
    content = """ 
              \0<layout>
              \0  <configItem>
              \0    <name>santiago</name>
              \0    <shortDescription>sa</shortDescription>
              \0    <description>santiago's keyboard layout</description>
              \0    <languageList>
              \0      <iso639Id>es</iso639Id>
              \0    </languageList>
              \0  </configItem>
              \0</layout>
              """
    content = textwrap.dedent(content).replace('\0', '    ')
    insert_into_file ('/usr/share/X11/xkb/rules/evdev.xml', '<layoutList>', content)

    content = """
              // Custom Layout
              ! layout        =   types
                santi         =   santi_t
              ! layout        =   keycodes
                santi         =   santi_k
              ! layout        =   compat
                santi         =   santi_c
              ! layout        =   symbols
                santi         =   santi
              """
    content = textwrap.dedent(content[1:])
    insert_into_file ('/usr/share/X11/xkb/rules/evdev', '// PC models', content, before=True)

if __name__ == "__main__":
    if get_cli_option ('--get_deps_pkgs'):
        get_target_dep_pkgs ()
        exit ()
    pymk_default()

