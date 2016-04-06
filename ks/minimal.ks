install
cdrom
text

lang ru_RU.UTF-8
keyboard ru
timezone --utc Asia/Novosibirsk

rootpw  --iscrypted $6$S4S5LQWY/ioyKjfH$WPFylLlpfysh.v9GF0CtEOFf6fu0Cz.CdM.TRmtwufmpFjX0gbfTlWAVagZaHVAwcUF.x6G2MkaiPhvsG5WNh.
authconfig --enableshadow --passalgo=sha512

firewall --service=ssh
selinux --disabled

network --onboot yes --hostname centos-6.local --bootproto dhcp --noipv6

bootloader --location=mbr --driveorder=sda --append="crashkernel=auto rhgb quiet"
clearpart --all --drives=sda

part /boot --fstype=ext4 --size=512
part pv.01 --grow --size=1

volgroup vg_main --pesize=4096 pv.01
logvol / --fstype=ext4 --name=lv_root --vgname=vg_main --size=1024
logvol /home --fstype=ext4 --name=lv_usr --vgname=vg_main --size=1024
logvol /opt --fstype=ext4 --name=lv_usr --vgname=vg_main --size=1024
logvol /usr --fstype=ext4 --name=lv_usr --vgname=vg_main --size=2048
logvol /var --fstype=ext4 --name=lv_var --vgname=vg_main --grow --size=1024 --maxsize=51200
logvol swap --name=lv_swap --vgname=vg_main --recommended

repo --name="CentOS DVD"  --baseurl=cdrom:sr0 --cost=100

%packages --nobase
@core
%end
