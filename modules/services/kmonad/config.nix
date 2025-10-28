{}:''


(defcfg
  input  (device-file "/dev/input/by-id/YOUR_KEYBOARD_HERE")
  output (uinput-sink "kmonad")
  fallthrough true
  allow-cmd true
)

;; --------------------
;; Main typing layer
;; --------------------
(deflayer main
  ;; Mod-tap keys
  a (tap-hold-next-release 150 200 ctrl a)
  s (tap-hold-next-release 150 200 shift s)
  d (tap-hold-next-release 150 200 alt d)
  f (tap-hold-next-release 150 200 meta f)

  j (tap-hold-next-release 150 200 meta j)
  k (tap-hold-next-release 150 200 alt k)
  l (tap-hold-next-release 150 200 shift l)
  ";" (tap-hold-next-release 150 200 ctrl ";")

  left-shift shift
  capslock (tap-toggle editMode)
  space (tap-toggle editMode)
  "'" (tap-toggle quote)
)

;; --------------------
;; Edit Mode Layer
;; --------------------
(deflayer editMode
  ;; Movement
  j left
  i up
  k down
  l right

  g home
  h end
  u page-up
  o page-down

  ;; New line & delete
  n (macro [end enter])
  p (macro [end shift-home backspace backspace])
  (tap-hold-next-release 0 0 shift p) (macro [end shift-home backspace shift-home backspace backspace])

  ;; Copy/Paste/Cut
  c (cmd "C-c")
  v (cmd "C-v")
  x (cmd "C-x")

  ;; Undo/Redo
  z (cmd "C-z")
  y (cmd "C-y")

  ;; Modifiers with commands
  a (tap-hold-next-release 0 0 ctrl (cmd "C-a"))
  s (tap-hold-next-release 0 0 shift (cmd "C-s"))
  d (tap-hold-next-release 0 0 alt (cmd "C-d"))
  f (tap-hold-next-release 0 0 meta (cmd "C-f"))

  m (tap-toggle visualMode)

  q escape
  ";" (tap-hold-next-release 0 0 ctrl backspace)
  "'" delete

  ;; Symbols
  "1" "!"
  "2" "@"
  "3" "#"
  "4" "$"
  "5" "%"
  "6" "^"
  "7" "&"
  "8" "*"
  "9" "("
  "0" ")"
  "`" "~"
)

;; --------------------
;; Visual Mode Layer
;; --------------------
(deflayer visualMode
  ;; Copy/Cut/Paste and exit selection
  c (macro [ (cmd "C-c") left (layer-toggle editMode) ])
  x (macro [ (cmd "C-x") left (layer-toggle editMode) ])
  v (macro [ (cmd "C-v") left (layer-toggle editMode) ])
  ";" (macro [ (cmd "C-backspace") left (layer-toggle editMode) ])

  ;; Movement with selection
  i (tap-hold-next-release 0 0 shift up)
  k (tap-hold-next-release 0 0 shift down)
  j (tap-hold-next-release 0 0 shift left)
  l (tap-hold-next-release 0 0 shift right)
  g (tap-hold-next-release 0 0 shift home)
  h (tap-hold-next-release 0 0 shift end)

  capslock (tap-toggle editMode-clear)
)

;; --------------------
;; Quote Layer
;; --------------------
(deflayer quote
  e (macro [e '])
  E É
  i í
  I Í
)

;; Example quote+alt layer
(deflayer quote-alt
  e (macro [e "])
)



''