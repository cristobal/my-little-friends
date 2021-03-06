;; logging & setting idle
(require 'erc-log)
(require 'erc-autoaway)

(setq erc-default-server "localhost"
      erc-log-channels-directory "~/.erc/logs"
      erc-log-write-after-send t
      erc-autoaway-idle-seconds 600
      erc-enable-logging t
      erc-save-buffer-on-part t)

;; general options
(setq erc-default-server "localhost")

;; connect to these IRC servers
(defun tkj-load-chat()
  (interactive)
  (erc :server "localhost" :port 6667 :nick "torstein"))

;; Spell checking
(add-hook 'erc-mode-hook 'flyspell-mode)
