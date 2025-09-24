-- https://wiki.haskell.org/GHC/GHCi

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
{-
-- Colourise ghci output (use :nopretty to disable)
-- Required libraries: pretty-show hscolour
:set -package pretty-show -package hscolour
import qualified Language.Haskell.HsColour as HSC
import qualified Language.Haskell.HsColour.Colourise as HSC
:{
dotGHCI_myPrint :: (Show a) => a -> IO ()
dotGHCI_myPrint a = putStrLn $ HSC.hscolour HSC.TTY myColourPrefs False False "" False $ Text.Show.Pretty.ppShow a
  where
    myColourPrefs = HSC.defaultColourPrefs -- { HSC.conop    = [HSC.Foreground HSC.Yellow]
                                           -- , HSC.conid    = [HSC.Foreground HSC.Yellow, HSC.Bold]
                                           -- , HSC.string   = [HSC.Foreground $ HSC.Rgb 29 193 57]
                                           -- , HSC.char     = [HSC.Foreground HSC.Cyan]
                                           -- , HSC.number   = [HSC.Foreground $ HSC.Rgb 202 170 236]
                                           -- , HSC.keyglyph = [HSC.Foreground HSC.Yellow]
                                           -- }
:}
:seti -interactive-print dotGHCI_myPrint
:def! pretty \_ -> return ":set -interactive-print dotGHCI_myPrint"
:def! nopretty \_ -> return ":set -interactive-print System.IO.print"
:m -Language.Haskell.HsColour
:m -Language.Haskell.HsColour.Colourise
-}