# busyservices
### Scripts that install various services.
#### Goals:
- [x] KVM on: 
    - [x]busypc:
        - [x] testing:
            - [x] with **f_update_software**
            - [x] with **f_config_kvm_sshd**
            - [x] with **f_config_kvm_group**
                - [x] define package managers not just for **apk (Alpine)** but also for:
                    - [x] **dnf** and **zypper** package managers;
                    - [x] and *else* at the end of the function, meaning it's meant for **apt (Debian/Ubuntu)**;
            - [x] with **f_config_kvm_libvirtd**
        - [x] simulating:
            - [x] KVM on a VM;
                - [x] with *busyalpinekvm*;
                - [x] with *busyubuntuvm*;
    - [ ] busydev:
- [x] Nginx service    
    - [x] Tested on:
        - [x] prod 
        - [x] dev
- [x] Transmission BitTorrent client;
    - [x] Tested on:
        - [x] prod 
        - [x] dev