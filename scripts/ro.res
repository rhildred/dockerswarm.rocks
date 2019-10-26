resource r0 {
protocol C;
startup {
degr-wfc-timeout 60;
}
disk {
}
syncer {
rate 100M;
}
net {
cram-hmac-alg sha1;
shared-secret "aBcDeF";
}
        on master {
                device /dev/drbd0;
                disk /dev/nvme0n1;
                meta-disk internal;
                address NNN.NNN.NNN.NNN:7801;
        }

        on slave {
                device /dev/drbd0;
                disk /dev/nvme0n1;
                meta-disk internal;
                address NNN.NNN.NNN.NNN:7801;
        }
