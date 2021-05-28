require'lspconfig'.elmls.setup {
    cmd = {"elm-language-server"},
	init_options= {
		elmAnalyseTrigger = "change",
		elmFormatPath = "elm-format",
    	elmPath = "elm",
    	elmTestPath = "elm-test"
	}
}
