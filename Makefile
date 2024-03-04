VCS_FLAGS = src/rtl/game.sv src/rtl/game_if.sv src/test/game_tb.sv -l readme.log +v2k -debug_acces -kdb +warn=all -sverilog -q \
	-lca -cm line+cond+fsm+tgl+assert+branch
SIM_FLAGS = -cm line+cond+fsm+tgl+assert+branch

test1:
	vcs $(VCS_FLAGS) src/test/game_harness1.sv -o tb1 && \
    ./tb1 $(SIM_FLAGS)

test2:
	vcs $(VCS_FLAGS) src/test/game_harness2.sv -o tb2  && \
	./tb2 $(SIM_FLAGS)

test3:
	vcs $(VCS_FLAGS) src/test/game_harness3.sv -o tb3  && \
	./tb3 $(SIM_FLAGS)

test4:
	vcs $(VCS_FLAGS) src/test/game_harness.sv -o tb4  && \
	./tb4 $(SIM_FLAGS)

test_all: clean test1 test2 test3

coverage: tb1.vdb tb2.vdb tb3.vdb
	urg -lca -dir tb1.vdb tb2.vdb tb3.vdb

verdi:
	verdi -ssf test.fsdb

clean:
	rm -rf *.vdb *.daidir novas.* *.log tb1 tb2 tb3 *.fsdb ucli.key