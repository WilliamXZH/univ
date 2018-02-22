	TITLE	..\lib\_exit.c
	.386P
include listing.inc
if @Version gt 510
.model FLAT
else
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
_DATA	SEGMENT DWORD USE32 PUBLIC 'DATA'
_DATA	ENDS
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
_BSS	SEGMENT DWORD USE32 PUBLIC 'BSS'
_BSS	ENDS
_TLS	SEGMENT DWORD USE32 PUBLIC 'TLS'
_TLS	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	__exit
_TEXT	SEGMENT
_exit_code$ = 8
__exit	PROC NEAR

; 19   : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 20   : 	// %0 - eax(系统调用号__NR_exit)；%1 - ebx(退出码exit_code)。
; 21   : 	//__asm__("int $0x80"::"a" (__NR_exit),"b" (exit_code));
; 22   : 	_asm mov eax,__NR_exit

	mov	eax, 1

; 23   : 	_asm mov ebx,exit_code

	mov	ebx, DWORD PTR _exit_code$[ebp]

; 24   : 	_asm int 0x80

	int	-128					; ffffff80H
	pop	ebx

; 25   : }

	pop	ebp
	ret	0
__exit	ENDP
_TEXT	ENDS
END
