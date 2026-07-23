const themeKey = "property-hub-theme"
const prefersDarkScheme = window.matchMedia("(prefers-color-scheme: dark)")

function readStoredTheme() {
	const storedTheme = window.localStorage.getItem(themeKey)

	if (storedTheme === "dark" || storedTheme === "light") {
		return storedTheme
	}

	return prefersDarkScheme.matches ? "dark" : "light"
}

function applyTheme(theme) {
	document.documentElement.dataset.theme = theme
}

applyTheme(readStoredTheme())

window.addEventListener("storage", (event) => {
	if (event.key === themeKey && (event.newValue === "dark" || event.newValue === "light")) {
		applyTheme(event.newValue)
	}
})

export { applyTheme, readStoredTheme, themeKey }