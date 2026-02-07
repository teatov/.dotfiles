PKGSYNCDIR="$HOME/.pkgsync"

NPMEXCLUDE="corepack,npm"
PACMANEXCLUDE="base,filesystem,man-db,msys2-runtime"
CHOCOEXCLUDE="Chocolatey,chocolatey,chocolatey-.*"
CHOCOEXCLUDE+=",KB[0-9]*,vcredist[0-9]*,[0-9]*"

pkgsave() {
	pipx list --short | cut -d " " -f 1 >"$PKGSYNCDIR/pipx.txt"

	npm list -g --depth 0 | sed "1d" | cut -d " " -f 2 | cut -d "@" -f 1 |
		sed "/^${NPMEXCLUDE//,/\$\|^}\$/d" >"$PKGSYNCDIR/npm.txt"

	if [[ $MSYSTEM ]]; then
		pacman -Qe | cut -d " " -f 1 |
			sed "/^${PACMANEXCLUDE//,/\$\|^}\$/d" >"$PKGSYNCDIR/pacman.txt"

		choco list | sed "$d" | cut -d " " -f 1 |
			sed "/^${CHOCOEXCLUDE//,/\$\|^}\$/d" >"$PKGSYNCDIR/choco.txt"
	else
		dnf repoquery --userinstalled --leaves |
			awk -F "-[0-9]+:" "{print \$1}" >"$PKGSYNCDIR/dnf.txt"
	fi
}

pkgload() {
	if [[ $1 == "pipx" ]]; then
		pipx install $(cat "$HOME/.pkgsync/pipx.txt")
	elif [[ $1 == "npm" ]]; then
		npm install --global $(cat "$HOME/.pkgsync/npm.txt")
	elif [[ $1 == "pacman" ]]; then
		pacman -S $(cat "$HOME/.pkgsync/pacman.txt")
	fi
}
