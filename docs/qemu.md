# QEMU

### Shortcuts:
(Remeber ypur TMUX prefix is also Ctrl-a)
Prefix: Ctrl-a + ...
* Exit: x
* Command: c

### Command line options
* -M, -machine: raspi3b, virt
* -cpu: cortex-a53 (Usually with *virt* machine)
* -accel: tcg (cross emu, by default), kvm
* -boot: TODO
* -m: 2G (RAM)
* -device: driver\[,prop=val\] (Add device driver to guest system)
* -blockdev: opt=val (See man) (Disk backend - how it is implemented in the host)
* -drive: opt=val (Accepts every blockdev opt + some) (-device + -blockdev)
    * if=: ide, scsi, sd, mtd, floppy, pflash, virtio, none
* -netdev: user,id=id,options (net backend)
* -nic: user,model,mac (-device + -netdev)
* -chardev: backend,id=id


### Boot the system
Ways to boot:
* Specify a firmware and let it control finding a kernel
* Specify a firmware and pass a hint to the kernel to boot
* Direct kernel image boot
* Manually load files into the guest's address space

Options:
* -bios: bios file
* -pflash: platform/motherboard/parallel flash image file
* -kernel: bzImage kernel file
    * -append: kernel cmd options
    * -initrd: file

#### About booting and UEFI
This [post](https://joonas.fi/2021/02/uefi-pc-boot-process-and-uefi-with-qemu/) explains a bit of BIOS, UEFI and QEMU booting using UEFI

And [this one](https://futurewei-cloud.github.io/ARM-Datacenter/qemu/how-to-launch-aarch64-vm/) describe how to set up an aarch64 qemu instance.

[This one](https://interrupt.memfault.com/blog/emulating-raspberry-pi-in-qemu#getting-the-raspberry-pi-image) is even better: RPI 3b+.


### Sample configurations
#### RPI
qemu-system-aarch64 -M raspi3b \
                    -cpu cortex-a53 \
                    -smp 4 \
                    -m 1G \
                    -nographic \
                    -dtb bcm2710-rpi-3-b.dtb \
                    -kernel kernel8.img \
                    -append "rw earlyprintk loglevel=8 console=ttyAMA0,115200 dwc_otg.lpm_enable=0 root=/dev/mmcblk0p2 rootdelay=1" \
                    -sd 2023-05-03-raspios-bullseye-arm64-lite.img \
                    -device usb-net,netdev=net0 \
                    -netdev user,id=net0,hostfwd=tcp::2222-:22

#### AARCH64 virtual system
IMAGE="../images/debian-12.0.0-arm64-netinst.iso"
#IMAGE="../images/mini.iso"

qemu-system-aarch64 -machine virt -cpu max -m 8G \
    -nic user,model=virtio-net-pci \
    -nographic \
    -drive file=main_disk.qcow2,if=none,id=drive0,cache=writeback \
    -device virtio-blk,drive=drive0,bootindex=0 \
    -drive file=$IMAGE,format=raw,if=none,id=drive1,readonly=on \
    -device virtio-blk,drive=drive1,bootindex=1 \
    -drive file=QEMU_CODE.fd,format=raw,if=pflash,readonly=on \
    -drive file=QEMU_VARS.fd,format=raw,if=pflash \
    #-nic none \
    #-netdev user,id=vnet,hostfwd=:127.0.0.1:0-:22 -device virtio-net-pci,netdev=vnet \
