[![][travis-badge]][travis-link]
![][license-badge]

<div align="center">
  <a href="http://github.com/oh-my-fish/oh-my-fish">
  <img width=90px  src="https://cloud.githubusercontent.com/assets/8317250/8510172/f006f0a4-230f-11e5-98b6-5c2e3c87088f.png">
  </a>
</div>
<br>

# fzf

:cherry_blossom: A command-line [fuzzy finder](https://github.com/junegunn/fzf) written in Go - Plugin for [Oh My Fish][omf-link].

## Install

On OSX `fzf` can be installed using `homebrew`:

```fish
$ brew install fzf
```
Please add the package now:

```fish
$ omf install fzf
```

## Usage

Fuzzily change directory:

```fish
$ fcd
```
Fuzzily browse command history and return selection:

```fish
$ fh
```

Fuzzily browse file listings and return selection"

```fish
$ fls
```

# License

[MIT][mit] © [Tom Hensel][author] et [al][contributors]


[mit]:            http://opensource.org/licenses/MIT
[author]:         http://github.com/{{USER}}
[contributors]:   https://github.com/gretel/pkg-fzf/graphs/contributors
[omf-link]:       https://www.github.com/oh-my-fish/oh-my-fish

[license-badge]:  https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square
[travis-badge]:   http://img.shields.io/travis/{{USER}}/fzf.svg?style=flat-square
[travis-link]:    https://travis-ci.org/gretel/fzf
