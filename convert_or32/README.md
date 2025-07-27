# convert or32

This utility takes an OpenRISC elf file and converts it into:
1. A VHDL-ROM-file
2. A Verilog-ROM-file
3. A .cmem-file that can be uploaded to the virtual prototype
4. A .mem-file that is human readable

To compile this utility:
gcc -O2 -o convert_or32 read_elf.c convert_or32.c
