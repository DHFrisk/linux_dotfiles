import XMonad
import XMonad.Util.EZConfig
-- import XMonad.Operations.unGrab # before: XMonad.Util.Ungrab
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Magnifier
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Util.Loggers
import XMonad.Hooks.SetWMName
import XMonad.Layout.Tabbed
import qualified XMonad.StackSet as W
import XMonad.Layout.Spacing

main :: IO ()
-- If you want to make the "fullscreen" functionality to work properly you should define main as the following:
--  $ ewmhFullscreen $ ewmh $ xmobarProp $ myConfig
main = xmonad 
    . withEasySB (statusBarProp "xmobar ~/.config/xmonad/xmobarrc" (pure myXmobarPP)) defToggleStrutsKey
    $ myConfig

myConfig = def
    {   layoutHook  = spacingRaw True (Border 0 4 4 4) True (Border 4 4 4 4) True $ myLayout -- Use custom layouts
    ,   startupHook = setWMName "LG3D"
    ,   borderWidth = 2
    --,   modMask     = mod4Mask -- Rebind Mod to the Super key
    -- ,   terminal    ="xterm-kitty"
    }

    `additionalKeysP`
    [("M-S-z", spawn "xscreensaver-command -lock"   )
    , ("M-C-s", unGrab *> spawn "scrot -s"          )
    , ("M-f", spawn "firefox")
    , ("M-j", windows W.focusUp)
    , ("M-k", windows W.focusDown)
    , ("M-C-t", spawn "kitty")
    ]


myLayout =  Full ||| tiled ||| Mirror tiled ||| threeCol 
    where
        threeCol= magnifiercz' 1.5 $ ThreeColMid nmaster delta ratio
        tiled   = Tall nmaster delta ratio
        nmaster = 1     -- Default number of windows in the master pane
        ratio   = 1/2   -- Default proportion of screen occupied by master pane
        delta   = 3/100 -- Percent of screen to increment by when resizing panes

myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = magenta " • "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2
    , ppHidden          = white . wrap " " ""
    , ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = myOrder 
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    , ppWsSep           = "  "
    }
  where
    formatFocused   = wrap (white    "{") (white    "}") . red . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . white . ppWindow
    -- formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
    -- formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30
    myOrder [ws, l, _, wins] = [ws, l, wins] -- also could be like this: \(ws : l : _ : wins : _) -> [ws, l, wins]

    blue, lowWhite, magenta, red, white, yellow, grey, black :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""
    grey     = xmobarColor "#6272a4" ""
    black    = xmobarColor "#ffffff" ""


