;;; tree-sitter-ispell.el --- Run ispell on tree-sitter text nodes

;; Copyright © 2022 Erick Navarro
;; Author: Erick Navarro <erick@navarro.io>
;; URL: https://github.com/erickgnavar/tree-sitter-ispell.el
;; Version: 0.1.0
;; SPDX-License-Identifier: GNU General Public License v3.0 or later

;;; Commentary:
;; Run spell check against tree-sitter text nodes

;;; Code:

(require 'tree-sitter)

;TODO: Add more languages, inspect their grammars and define their text elements
(defcustom tree-sitter-ispell-grammar-text-mapping '((python-mode . (string comment))
                                                     (go-mode . (interpreted_string_literal comment))
                                                     (js-mode . (string template_string comment))
                                                     (elixir-mode . (string comment)))
  "Mapping of tree-sitter grammars, define all the text elements by language
 used to select a text node where run ispell"
  :type 'list
  :group 'tree-sitter-ispell)

(defun tree-sitter-ispell--get-text-node-at-point ()
  "Get valid node for the current major mode using `tree-sitter-ispell-grammar-text-mapping'
list of elements."
  (let* ((types (alist-get major-mode tree-sitter-ispell-grammar-text-mapping))
         (matches (seq-map (lambda (x) (tree-sitter-node-at-pos x (point) t)) types))
         (filtered-matches (remove-if (lambda (x) (eq nil x)) matches)))
    (if filtered-matches
        (car filtered-matches))))

(defun tree-sitter-ispell--run-ispell-on-node (node)
  "Run ispell over the text of the received `node'"
  (ispell-region (tsc-node-start-position node) (tsc-node-end-position node)))

;;;###autoload
(defun tree-sitter-ispell-run-at-point ()
  "Run ispell at current point if there is a text node."
  (interactive)
  (let ((node (tree-sitter-ispell--get-text-node-at-point)))
    (if node
        (tree-sitter-ispell--run-ispell-on-node node))))

(provide 'tree-sitter-ispell)

;;; tree-sitter-ispell.el ends here