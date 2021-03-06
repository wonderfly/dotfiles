# dotfiles
My dotfiles.

Installation of these files is managed by [rcm][rcm], which I've actually
bundled as part of my dotfiles in the [rcm](./rcm/) directory.

[rcm]: https://github.com/thoughtbot/rcm

To set up a new host:

* `git clone https://github.com/wonderfly/dotfiles ~/.dotfiles`
* `PATH="~/.dotfiles/third_party/rcm/bin:$PATH" rcup`

Alternatively you could build a Docker container that automatically sets
dotfiles up and also installs a lot of useful tools.

```
$ git clone https://github.com/wonderfly/dotfiles
$ cd dotfiles
$ docker build -t mydev-container .
$ docker run -it mydev-container
```

## Work dotfiles

I store my work dotfiles separately on an internal git server. `rcm` allows me
to manage them separately and merge them when needed:

* `git clone git://<internal-server>/my/dotfiles ~/.dotfiles-work`
* update `~/.rcrc` to include `DOTFILES_DIRS="${HOME}/.dotfiles-work ${HOME}/.dotfiles"`

`rcup` will now install my work-specific dotfiles alongside my regular ones.

## License

Most of the actual configurations are mine, but I borrowed heavily from Will
Norris, <https://github.com/willnorris/dotfiles>, especially on the RCM bits and
the overall structure. The things that I authored are released under the Apache
2.0 license as can be seen in [LICENSE](./LICENSE).
