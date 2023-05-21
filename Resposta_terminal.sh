root@kalita-Lenovo-ideapad-320-15IKB:/home/kalita# vagrant up
Bringing machine 'default' up with 'libvirt' provider...
==> default: Creating domain with the following settings...
==> default:  -- Name:           ubuntu-focal64_default
==> default:  -- Domain type:    kvm
==> default:  -- Cpus:           2
==> default:  -- Memory:         1024M
==> default:  -- Management MAC: 
==> default:  -- Loader:         
==> default:  -- Base box:       ubuntu/focal64
==> default:  -- Storage pool:   default
==> default:  -- Image:          /var/lib/libvirt/images/ubuntu-focal64_default.qcow2
==> default:  -- Volume Cache:   default
==> default:  -- Kernel:         
==> default:  -- Initrd:         
==> default:  -- Graphics Type:  vnc
==> default:  -- Graphics Port:  5900
==> default:  -- Graphics IP:    127.0.0.1
==> default:  -- Graphics Password: Not defined
==> default:  -- Video Type:     cirrus
==> default:  -- Video VRAM:     9216
==> default:  -- Sound Type:     ac97
==> default:  -- Keymap:         en-us
==> default:  -- TPM Path:       
==> default:  -- INPUT:          type=mouse, bus=ps2
==> default: Creating shared folders metadata...
==> default: Starting domain.
==> default: Waiting for domain to get an IP address...
==> default: Waiting for SSH to become available...
==> default: 
==> default: Inserting generated public key within guest...
==> default: Removing insecure key from the guest if it's present...
==> default: Key inserted! Disconnecting and reconnecting using new SSH key...
==> default: 
==> default: Configuring and enabling network interfaces...
==> default: Running provisioner: shell...
    default: Running: script.sh
==> default: Blocked: IN=eth0 OUT= MAC=52:54:00:de:b8:c9:52:54:00:de:22:bd:08:00 SRC=192.168.1.1 DST=192.168.1.100 LEN=60 TOS=0x00 PREC=0x00 TTL=64 ID=2377 DF PROTO=TCP SPT=50388 DPT=80 WINDOW=29200 RES=0x00 SYN URGP=0 
==> default: Blocked: IN=eth0 OUT= MAC=52:54:00:de:b8:c9:52:54:00:de:22:bd:08:00 SRC=192.168.1.1 DST=192.168.1.100 LEN=60 TOS=0x00 PREC=0x00 TTL=64 ID=62514 DF PROTO=TCP SPT=53892 DPT=443 WINDOW=29200 RES=0x00 SYN URGP=0 
==> default: 
==> default: The VM is ready to use!
==> default: To access the machine, use `vagrant ssh`. To stop the machine, use
==> default: `vagrant halt`. To destroy the machine and delete all backups, use
==> default: `vagrant destroy`.

