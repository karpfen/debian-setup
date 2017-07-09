Debian System Setup
===========================

Adapted from ubuntu-post-install scripts of [Sam Hewitt](https://github.com/snwh/ubuntu-post-install) and [Mark
Padgham](https://github.com/mpadge/ubuntu-setup), to whom all credit is due.

## Usage

```
./setup.sh
```
or make an alias.

## Structure

There are six main `functions` in the directory of that name, some of which use
the `data` directory, and all of which use variables defined in
`functions/variables`.

1. `doall` enables all functions to be run **non-interactively** to build an
   entirely new system from scratch

2. `aptadd` adds `apt` keys (`/data/keys.list`) and repositories
   (`/data/repos.list`)

3. `apt` installs `packages.list` (and skips all those already installed)

4. `nonapt` opens a menu for the following additional functions

    i.  `pandoc` to install the latest version from source

    ii. `python` to install a host of additional python modules

    iii. `R packages` to install those

    iv.  `sourcecodepro` to install the font

    v. `travis` to install the ruby gem for `travis-ci`

5. `configure` provides 3 configuration options, including installing dotfiles

6. `cleanup` removes obsolete packages, kernels, and the like


In addition, `check` performs initial checks for packages necessary to run this
script

------

## Manual tasks

Some tasks can nevertheless only be completed manually ... 

### 1. Terminal font

```
profile -> general -> font -> SourceCodePro Light 9pt
```

### 2. Computer name

If not set at install, just change both:
```
/etc/hosts
/etc/hostname
```
