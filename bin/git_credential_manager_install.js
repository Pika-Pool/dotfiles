const { stdout, exit, argv } = require('process')
const path = require('path')

const [, , releases_json_path] = argv

/** @type {import('./git_credential_manager_types').LatestRelease} */
const latest_release = require(path.resolve(process.cwd(), releases_json_path))

const was_success = latest_release.assets.some(
	({ name, browser_download_url }) => {
		if (/.deb$/.test(name)) {
			stdout.write(browser_download_url)
			return true
		}

		return false
	}
)

if (!was_success) exit(1)
