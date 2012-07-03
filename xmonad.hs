import XMonad
import XMonad.Util.Run
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ICCCMFocus
import XMonad.Config.Gnome
import XMonad.Actions.CycleWS

import qualified XMonad.StackSet as W

myManageHook = composeAll (
  [ manageHook gnomeConfig
  , className =? "Unity" --> doIgnore
  , className =? "Unity-launcher" --> doFloat
    , className =? "Unity-2d-panel" --> doIgnore
    , className =? "Unity-2d-launcher" --> doFloat  
  ])

main = 
  xmonad $ gnomeConfig {
                        manageHook = manageDocks <+> myManageHook <+> manageHook gnomeConfig 
                       , layoutHook = avoidStruts $ layoutHook defaultConfig
                       , logHook = takeTopFocus
                       } `additionalKeys` [ ((mod4Mask, xK_d), spawn "dmenu_run -b")
                                          , ((mod4Mask, xK_Return), spawn "x-terminal-emulator")
                                          , ((mod1Mask .|. controlMask, xK_Right), nextWS)
                                          , ((mod1Mask .|. controlMask, xK_Left), prevWS)                     
                                          , ((mod1Mask .|. controlMask .|. shiftMask, xK_Right), shiftToNext)                     
                                          , ((mod1Mask .|. controlMask .|. shiftMask, xK_Left), shiftToPrev)
                                          , ((mod4Mask .|. controlMask .|. shiftMask, xK_Right), shiftToNext >> nextWS)                     
                                          , ((mod4Mask .|. controlMask .|. shiftMask, xK_Left), shiftToPrev >> prevWS)
                                          , ((controlMask .|. shiftMask, xK_c), kill)
                                          , ((mod1Mask .|. shiftMask, xK_backslash), spawn "google-chrome")
                                          , ((controlMask .|. shiftMask, xK_backslash), spawn "google-chrome")
                                          , ((mod1Mask .|. shiftMask, xK_Left), windows W.swapDown)
                                          , ((mod1Mask .|. shiftMask, xK_Right), windows W.swapUp)
                                          , ((mod1Mask .|. shiftMask, xK_Down), windows W.swapDown)
                                          , ((mod1Mask .|. shiftMask, xK_Up), windows W.swapUp) 
                                          , ((mod1Mask , xK_Right), nextScreen)
                                          , ((mod1Mask , xK_Left), prevScreen)
                                          , ((mod1Mask .|. shiftMask, xK_t), spawn "~/Sublime\\ Text\\ 2/sublime-text-2")
                                          ]
