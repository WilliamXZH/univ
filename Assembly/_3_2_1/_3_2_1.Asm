TITLE Add and Subtract
;This program adds subtracts 32-bits integers.
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO,dwExitCode:DWORD
DumpRegs PROTO
;INCLUDE Irvine32.inc
.code
main PROC
	
	mov eax,10000h
	add eax,40000h
	sub eax,20000h
	call DumpRegs
	INVOKE ExitProcess,0
	ret

main endp
end main