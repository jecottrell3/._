#! /bin/sh

BOOT=/boot/grub/menu.lst

grep MBR-0 $BOOT || cat <<EOF >>$BOOT
title	MBR-0
	root (hd0)
	chainloader +1
title	MBR-1
	root (hd1)
	chainloader +1
title	MBR-2
	root (hd2)
	chainloader +1
title	MBR-3
	root (hd3)
	chainloader +1
EOF
