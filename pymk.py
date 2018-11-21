#!/usr/bin/python3
from mkpy.utility import *
import textwrap
assert sys.version_info >= (3,2)

#TODO: Resume installation where we lef off if something goes wrong
def default():
    bashrc ()
    vim ()

def elementary_packages ():
    ex ('sudo apt-get install ' + \
            ' '.join([
                'gcc', 'make', 'cmake' ,'automake', 'vim-gnome',
                # Required by YouCompleteMe (vim plugin)
                'python2.7-dev'
                ]))

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

def bashrc_update ():
    ex ('rsync -avc ~/.bashrc ./bashrc')

def install_keyboard ():
    layout_file = pathlib.Path('/usr/share/X11/xkb/symbols/santiago')
    if layout_file.exists():
        print ('Keyboard layout seems to be already installed')
        return

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
              \0<!--CUSTOM LAYOUTS START-->
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
              \0<!--CUSTOM LAYOUTS END-->
              """
    content = textwrap.dedent(content).replace('\0', '    ')
    insert_into_file ('/usr/share/X11/xkb/rules/evdev.xml', '<layoutList>', content)

    content = """
              // CUSTOM LAYOUTS START
              ! layout        =   types
                santiago      =   santiago_t
              ! layout        =   keycodes
                santiago      =   santiago_k
              ! layout        =   compat
                santiago      =   santiago_c
              ! layout        =   symbols
                santiago      =   santiago
              // CUSTOM LAYOUTS END

              """
    content = textwrap.dedent(content[1:])
    insert_into_file ('/usr/share/X11/xkb/rules/evdev', '// PC models', content, before=True)

if __name__ == "__main__":
    # Everything above this line will be executed for each TAB press.
    # If --get_completions is set, handle_tab_complete() calls exit().
    handle_tab_complete ()

    pymk_default()

