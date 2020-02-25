#!/bin/bash

passwd
useradd -m -G wheel -s /bin/bash cordojd1
passwd cordojd1

#---[fix]---------------
visudo
#-----------------------

exit
