# Dotfiles

These are written assuming the following things:

1. The system is a VM in VMWare
2. An ArchLinux aarch64 install

I personally use an Apple M1 device and this makes sense for my workflow.

If you like Arch but are having issues installing it in the [VMWare Fusion Tech Preview](https://customerconnect.vmware.com/downloads/get-download?downloadGroup=FUS-PUBTP-2021H1)
have a look at my [arch installation repo](https://github.com/daimaou92/install-arch-vmwarefusion-techpreview).

## The major programs

1. xorg with i3-gaps (almost default config)
2. go
3. node
4. rust
5. kitty
6. neovim (with lsp)
7. zsh

There are `*conf.sh` files in the root of this repo that setup parts of the
system one by one. The order I run them in:

```Bash
./zshconf.sh
./xconf.sh
./nvimconf.sh
```

Please inspect them, before running, to see if what it does is what you want.
