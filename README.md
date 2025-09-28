# busyservices
### Scripts that install various services.
#### Goals:
- [x] KVM on: 
    - [x]busypc:
        - [x] testing:
            - [x] with **f_update_software**
            - [x] with **f_config_kvm_sshd**
            - [ ] with **f_config_kvm_group**
                - [ ] define package managers not just for **apk (Alpine)** but also for:
                    - [ ] apt/dnf/zypper
                    - [ ] and *else*
            - [x] with **f_config_kvm_libvirtd**
        - [ ] simulating:
            - [ ] KVM on a VM;
    - [ ] busydev:
- [x] Nginx service    
    - [x] Tested on:
        - [x] prod 
        - [x] dev
- [x] Transmission BitTorrent client;
    - [x] Tested on:
        - [x] prod 
        - [x] dev