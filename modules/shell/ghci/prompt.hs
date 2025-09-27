:{
dotGHCI_myPrompt promptString ms _ = do
  -- Determine which is the main module.
  let main_module = head' [ m' | (m:m') <- ms, m == '*' ]
  -- Put together the final prompt string.
  -- ANSI escape sequences allow for displaying colours in compatible terminals.  See [http://www.lihaoyi.com/post/BuildyourownCommandLinewithANSIescapecodes.html this guide] for help interpreting them.
  return $ concat [ main_module, "\ESC[37m\STX", promptString, " \ESC[0m\STX" ]
  where
    head' (x:_) = " \ESC[38;5;227m\STX" ++ x
    head' _     = ""
:}
:set prompt-function dotGHCI_myPrompt "\ESC[38;5;129m\STX\xe61f"
:set prompt-cont-function dotGHCI_myPrompt "∷"