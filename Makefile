VCS_FLAGS = -f script/filelist -l readme.log +v2k -debug_acces -kdb +warn=all -sverilog -q \
	-lca -cm line+cond+fsm+tgl+path+assert+branch
SIM_FLAGS = -cm line+cond+fsm+tgl+assert+path+branch

test1:
	vcs $(VCS_FLAGS) test/game_test1.sv -o tb1 && \
    ./tb1 $(SIM_FLAGS)

test2:
	vcs $(VCS_FLAGS) test/game_test2.sv -o tb2  && \
	./tb2 $(SIM_FLAGS)

test3:
	vcs $(VCS_FLAGS) test/game_test3.sv -o tb3  && \
	./tb3 $(SIM_FLAGS)

test_all: test1 test2 test3

coverage: tb1.vdb tb2.vdb tb3.vdb
	urg -lca -dir tb1.vdb tb2.vdb tb3.vdb

verdi:
	verdi -ssf test.fsdb