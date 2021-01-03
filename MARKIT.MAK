# nmake makefile to create both a tkernel and a system manager compliant
# version of markit.  The tkernel version is called markit.exe and the
# system manager version is called markit.exm.

all: markit.exe markit.exm

######## system manager compliant version

tempmark.obj: markit.c
    cl /c /AS /Gs /Fotempmark.obj markit.c

tempmark.exe: tempmark.obj
    link @<<tempmark.lnk
/M /NOE /NOI tempmark.obj+..\tools\csvc.obj+..\tools\crt0.obj
tempmark.exe
tempmark.map;
<<NOKEEP

markit.exm: tempmark.exe
    e2m tempmark
    copy tempmark.exm markit.exm
    del tempmark.exm



######## tkernel version

markit.obj: markit.c
    cl /c /AS /Zi /Fomarkit.obj markit.c

markit.exe: markit.obj
    link @<<markit.lnk
/CO /M /NOE /NOI markit.obj+..\tools\csvc.obj
markit.exe
markit.map;
<<NOKEEP
