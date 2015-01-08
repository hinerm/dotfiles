How far should I go to agnosticize dotfile management?
* Should we support Windows? Cygwin? Git Bash?
    * No symlinks with Git Bash...
    * Best way to solve symlinks issue:
        * A helper shell plugin for refreshing dotfiles!
        * Uses symlinks if available on the system.
        * Otherwise, copies changed files from $DOTFILES.
* Should I write plugins for SSH and Git dotfiles?
    * They do not fully support includes (see below).

How to handle plugins that depend on other plugins?
* Frameworks have no explicit support for dep mgmt.
* Ideally, want arbitrary cherry picking to be feasible.
* Convert all plugins to separate dirs?
    * If so, how to handle bash support?

How to define new commands?
* As aliases?
    * Often simplest, but buries them.
* As functions?
    * Often elegant, but buries them.
* As shell scripts?
    * Ideal for them to be editable with "vif"
    * Probably easier to keep them POSIX compliant
    * Probably easier to consume them from other shells like bash
    * What about annoying ".sh" suffixes (e.g., scijava-scripts)?
        * Just add a function that calls the shell script.

How modular to make the commands?
* One plugin per suite of commands?
    * Less verbose, but less cherry pickable.
* One plugin per command?
    * More verbose, but more cherry pickable.
    * Each plugin could add a function that calls its shell script.

Where to put very general new commands?
* Should include shell plugins in the same repository.
    * One shell plugin per script, adding a function that calls it?
        * That way, we don't have to modify the path at all...
* It seems that ctr-scripts is good!

What if git is not available on the system?
* zgen requires git
* fall back to bash?

What if zsh is too old (<4.3.17)?
* skynet is 4.3.10
* ash is 4.2.6

What if the shell is not bash _or_ zsh?
* Nearly everything I have is (supposed to be) POSIX compliant
* Is it worth the effort to keep it that way?

Ultimate goals:
* Provide plugins for each GitHub org.
* Make it dirt simple for new LOCI developers to bootstrap everything.
    * Start with ctrueden/dotfiles.
* Make it possible for power users to cherry pick and tweak everything.
    * Fork and edit ctrueden/dotfiles!

===========================
sh -c "$(curl -fsSL https://ctrueden.github.io/dotstrap)"

The name "dotstrap" is already taken though...

===========================
Projects that manage zshrc:
* https://github.com/robbyrussell/oh-my-zsh
* https://github.com/zsh-users/antigen
* https://github.com/sorin-ionescu/prezto

Info about zsh etc.:
* https://joshldavis.com/2014/07/26/oh-my-zsh-is-a-disease-antigen-is-the-vaccine/
* http://grml.org/zsh/zsh-lovers.html

Projects that try to manage dotfiles:
* https://github.com/mattdbridges/dotify
* https://github.com/lostgeek/dottify
* https://github.com/rustygeldmacher/dottle

Well-curated dotfiles projects:
* https://github.com/skwp/dotfiles

Related projects:
* https://github.com/powerline/powerline

Possible names that aren't taken:
* dottish
* dottly

License:
* http://unlicense.org/

===========================
How do various dot files include configuration blocks?

### SSH

Nope. But you can have your shell profile rebuild the file on every login.
http://www.linuxsysadmintutorials.com/multiple-ssh-client-configuration-files/

### git

http://stackoverflow.com/a/9733277
```
[include]
    path = /path/to/file
```
But it doesn't support environment variable expansion... :-(
