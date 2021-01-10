# spacevim
my sapcevim configuration

1. download spacevim

    ```bash
    git clone https://github.com/SpaceVim/SpaceVim.git
    ```

2. download configuration git repo

    ```bash
    git clone https://github.com/dr12730/spacevim.git
    ```
    
3. rename spacevim to .SpaceVim.d

   ```bash
   mv spacevim ~/.SpaceVim.d
   ```

4. copy coc-setting

    ```bash
    ln ~/.SpaceVim.d/coc-settings.json ~/.config/nvim/coc-settings.json
    ```

5. open neovim, wait for install

    ```bash
    nvim
    ```
