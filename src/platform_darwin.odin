//+build darwin

package main

import "core:strings"
import NS "vendor:darwin/Foundation"

platform_init :: proc() {
	user_defaults := NS.UserDefaults.standardUserDefaults()
	flag_str := NS.String.alloc()->initWithOdinString("AppleMomentumScrollSupported")
	user_defaults->setBoolForKey(true, flag_str)

	velocity_multiplier = -15
}

open_file_dialog :: proc() -> (string, bool) {
	panel := NS.OpenPanel.openPanel()
	panel->setCanChooseFiles(true)
	panel->setResolvesAliases(true)
	panel->setCanChooseDirectories(false)
	panel->setAllowsMultipleSelection(false)

	if panel->runModal() == .OK {
		urls := panel->URLs()
		ret_count := urls->count()
		if ret_count != 1 {
			return "", false
		}

		url := urls->objectAs(0, ^NS.URL)
		return strings.clone_from_cstring(url->fileSystemRepresentation()), true
	}

	return "", false
}

