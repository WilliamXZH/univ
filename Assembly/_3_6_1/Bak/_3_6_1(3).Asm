
include Irvine32.inc
.data
val1 DWORD 10000h
val2 DWORD 40000h
val3 DWORD 20000h
finalval DWORD ?
.code
main PROC
	
	mov ax,&data
	mov ds,ax
	mov eax,val1
	add eax,val2
	sub eax,val3
	mov finalval,eax
	call DumpRegs
	ret

main endp
end main