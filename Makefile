test1:
	vcs -f script/filelist -l readme.log +v2k -debug_acces -kdb +warn=all -sverilog \
    -lca -cm line+cond+fsm+tgl+path+assert && \
    ./simv -cm line+cond+fsm+tgl+assert+path && \
    urg -lca -dir simv.vdb

verdi:
	verdi -ssf test.fsdb