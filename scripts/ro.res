resource r0 {
        net {
#on-congestion pull-ahead;
#congestion-fill 1G;
#congestion-extents 3000;
#sndbuf-size 1024k; 
                sndbuf-size 0;
                max-buffers 8000;
                max-epoch-size 8000;
        }
        disk {
#no-disk-barrier;
#no-disk-flushes;
                no-md-flushes;
        }
        syncer {
                c-plan-ahead 20;
                c-fill-target 50k;
                c-min-rate 10M;
                al-extents 3833;
                rate 100M;
                use-rle;
        }
        startup { become-primary-on master ; }
        protocol C;

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
