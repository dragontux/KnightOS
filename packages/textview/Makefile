OUTDIR:=bin
BINDIR:=$(OUTDIR)/bin
ETCDIR:=$(OUTDIR)/etc

all:
	mkdir -p $(BINDIR)
	mkdir -p $(ETCDIR)
	$(AS) $(ASFLAGS) --define "$(PLATFORM)" --include "$(INCLUDE);$(PACKAGEPATH)/demos/" textview.asm $(BINDIR)/textview
	cp texttest $(ETCDIR)/texttest
	
clean:
	-rm -rf $(OUTDIR)

.PHONY: all clean
