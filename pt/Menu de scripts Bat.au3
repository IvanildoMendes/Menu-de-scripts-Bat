#include <GUIConstantsEx.au3>
#include <File.au3>

; Define o diretório do script
Local $sDir = @ScriptDir

; Cria a GUI
GUICreate("Arquivos de Scripts", 400, 300)

; Cria uma lista para exibir os arquivos .bat
Local $hListBox = GUICtrlCreateList("", 10, 10, 380, 200)

; Cria um botão para executar o arquivo selecionado
Local $hButton = GUICtrlCreateButton("Executar", 150, 220, 100, 30)

; Preenche a lista com arquivos .bat
Local $aFiles = FileFindFirstFile($sDir & "\bin\*.bat")
If $aFiles = -1 Then
    MsgBox(0, "Erro", "Nenhum arquivo .bat encontrado.")
Else
    While 1
        Local $sFile = FileFindNextFile($aFiles)
        If @error Then ExitLoop
        GUICtrlSetData($hListBox, $sFile)
    WEnd
    FileClose($aFiles)
EndIf

; Exibe a GUI
GUISetState(@SW_SHOW)

; Loop principal
While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
        Case $hButton
            ; Obtém o arquivo selecionado
            Local $sSelectedFile = GUICtrlRead($hListBox)
            If $sSelectedFile <> "" Then
                ; Executa o arquivo .bat selecionado
                Run($sDir & "\bin\" & $sSelectedFile) ; Corrigido para incluir o diretório "bin"
            Else
                MsgBox(0, "Erro", "Selecione um arquivo .bat para executar.")
            EndIf
    EndSwitch
WEnd
