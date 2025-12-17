# Ubuntu Local Development

## Postinstall
1. Update packages
    ```bash
    {
        sudo apt update
        sudo apt upgrade --yes
        sudo apt autoremove --yes
    }
    ```

1. Install git
    ```bash
    {
        sudo apt-add-repository --yes --update ppa:git-core/ppa
        sudo apt-get install --yes git
    }
    ```


1. Clone repo
    ```bash
    {
        git clone https://github.com/muryginm/dev-env.git
        cd dev-env
    }
    ```

1. Install dependencies
    ```bash
    {
        python3 -m venv .venv
        source .venv/bin/activate
        pip install -r requirements.txt
    }
    ```

1. Provision development pc
    ```bash
        ansible-playbook -K desktop.yml
    ```
