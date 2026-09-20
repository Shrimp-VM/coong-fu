@tool
extends BasePanel

func afterExit():
	EditorManager.instance.editor.fileManager.auto_compile()
