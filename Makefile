test1:
	vcs -f script/filelist -l readme.log +v2k \
    -LDFLAGS -Wl,--no-as-needed -timescale=1ns/1ns +vcs+flush+all +warn=all -sverilog \
    -cm line+tgl+fsm+cond+branch+assert