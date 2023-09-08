GETH_EVM=go-ethereum/build/bin/evm
ERIGON_EVM=erigon/build/bin/evm
RETH_EVM=revm/target/release/revme

FUZZTESTS_DIR=FuzzyVM/out/

fuzzyvm-clean:
	@cd FuzzyVM && \
	rm -rf out corpus crashers crashes suppressions

fuzzyvm-build:
	@cd FuzzyVM && \
	rm ./FuzzyVM && \
	go build && \
	./FuzzyVM build && \
	./FuzzyVM corpus --count 100 && \
	./FuzzyVM run

geth-build:
	@cd go-ethereum && \
	make all

geth-evm-tests:
	find $(FUZZTESTS_DIR) -type f -exec $(GETH_EVM) --nomemory --json statetest {} \;

erigon-build:
	@cd erigon && \
	make all

erigon-evm-tests:
	find $(FUZZTESTS_DIR) -type f -exec $(ERIGON_EVM) --nomemory --json statetest {} \;

reth-build:
	@cd reth && \
	cargo build --release

reth-evm-build:
	@cd revm/bins/revme && \
	cargo build --release

reth-evm-tests:
	find $(FUZZTESTS_DIR) -type f -exec $(RETH_EVM) statetest --json {} \;