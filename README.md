Vim Independence
================

This vim plugin allows you to load (git) project specific .vimrc files

# Installation

I recommend using [Vim Pathogen](https://github.com/tpope/vim-pathogen)

Therefore:

	cd .vim/bundles
	git clone git://github.com/AD7six/vim-independence.git

Alternatively - simply put the file independence.vim in your plugin folder directly

# Usage

The plugin is automatic, if the file `.vimrc` exists in your git project root - it will load it

For example, let's consider that you use the [Syntastic](https://github.com/scrooloose/syntastic)
plugin, and most of your projects are php. The default standard for syntastic to check code against
is the Zend standard - a reasonable default. If all of your projects follow the Zend standard, that's
fine. If all of your projects follow a different standard - that's also fine, you can simply define
`g:syntastic_phpcs_conf` in your `~/.vimrc` file and the syntastic plugin will take that config.

If you need to follow more than one standard using vim independence that becomes easy:

in `~/somepearproject` create `~/somepearproject/.vimrc` with the following contents:

    let g:syntastic_phpcs_conf = '--standard=Pear`

in `~/somesymfony2project` create `~/somesymfony2project/.vimrc` with the following contents:

    let g:syntastic_phpcs_conf = '--standard=Symfony2`

Etc.

# Gotchas

As you may deduce from the above example, if you modify a global variable in a project-specific
`.vimrc` file - those settings will persist for all subsequent buffers you open.

# Changelog

* 0.1.0 Intial release
