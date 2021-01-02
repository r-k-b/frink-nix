Run [Frink] on [NixOS] without much hassle.

[Frink]: https://frinklang.org/
[NixOS]: https://nixos.org/

# usage

To start a CLI session:

`$ nix run github:r-k-b/frink-nix`


# updating

To update Frink, run `./update.sh`. The file `LAST_UPDATED` indicates when this
was last run.

To update the other inputs to this flake, such as `nixpkgs`, run 
`nix flake update`.


# notes

I'd rather not keep a copy of Frink's files in this repo, but there doesn't seem
to be any permanent url for a given version of Frink.

It's not in package repos like Ubuntu, Snapcraft, or Arch, anyway.

---

Should the `installPhase` use `makeWrapper`? Something like
<https://git.marvid.fr/scolobb/nix-GINsim/src/commit/d7147baefccad2e6643fadc3600b76e8dbd2d67a/ginsim.nix>?


# see also

[Hillel Wayne's post *The Frink is Good, the Unit is Evil*](https://hillelwayne.com/post/frink/)

> If you want to learn more about how evil units are, check out Bill Kent’s
> [Measurement Data Report.](https://www.bkent.net/Doc/mdarchiv.pdf)

- From the same article.
