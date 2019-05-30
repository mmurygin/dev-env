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

1. Install ansible
    ```bash
    {
        sudo apt install -y software-properties-common
        sudo apt-add-repository --yes --update ppa:ansible/ansible
        sudo apt install -y ansible
    }
    ```

1. Clone repo
    ```bash
    git clone https://github.com/muryginm/dev-env.git
    ```

1. Provision development pc
    ```bash
    {
        cd dev-env
        ansible-playbook -K destop.yml
    }
    ```
