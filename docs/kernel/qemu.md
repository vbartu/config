# QEMU

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
