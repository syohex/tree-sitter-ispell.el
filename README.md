# tree-sitter-ispell.el

Run ispell on tree-sitter text nodes

## Installation

### Cloning the repo

Clone this repo somewhere, and add this to your config:

```elisp
(add-to-list 'load-path "path where the repo was cloned")

(require 'tree-sitter-ispell)
```

## Usage

`M-x tree-sitter-ispell-run-at-point` to use the node at the current position

It can also be attached to a keybinding, for example:

```emacs-lisp
(global-set-key (kbd "C-x C-s") 'tree-sitter-ispell-run-at-point)
```