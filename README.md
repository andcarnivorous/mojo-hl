Adds some syntax highlight for the mojo programming language.

Mojo should come included with a lsp server (it hsd been spotty in my
experiece so there are commented lines in the mode definition to limit
the noise from the lsp).

You can add the `mojo-lsp-server` to your eglot config like so:

    (use-package eglot                                                         
      :ensure t                                                                
        :defer t                                                                 
        :hook ((python-mode . eglot-ensure)                                      
               (go-mode . eglot-ensure)
               (go-ts-mode . eglot-ensure)
               (python-ts-mode . eglot-ensure)
               (mojo-mode . eglot-ensure))
        :config                                                                  
        (add-to-list 'eglot-server-programs '(mojo-mode . ("mojo-lsp-server"))))

