# if no packages, shows nothing

    Code
      cat(ojoverse_attach_message(character()))

# message lists all core ojoverse packages

    Code
      cat(ojoverse_attach_message(core))
    Output
      -- Attaching core ojoverse packages -------------------------- ojoverse 1.0.0 --
      v ojodb     1.0.0     v ojoslackr 1.0.0
      v ojoregex  1.0.0     v ojoutils  1.0.0

# highlights dev versions in red

    Code
      highlight_version(c("1.0.0", "1.0.0.9000", "0.9000.0.9000", "1.0.0-rc"))
    Output
      [1] "1.0.0"                                        
      [2] "1.0.0.\033[31m9000\033[39m"                   
      [3] "0.\033[31m9000\033[39m.0.\033[31m9000\033[39m"
      [4] "1.0.0-rc"                                     

