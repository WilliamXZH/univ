	TITLE	..\lib\setsid.c
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
PUBLIC	_setsid
EXTRN	_errno:DWORD
_TEXT	SEGMENT
___res$ = -4
_setsid	PROC NEAR

; 19   : _syscall0(pid_t,setsid)

	push	ebp
	mov	ebp, esp
	push	ecx
	mov	eax, 66					; 00000042H
	int	-128					; ffffff80H
	mov	DWORD PTR ___res$[ebp], eax
	mov	eax, DWORD PTR ___res$[ebp]
	test	eax, eax
	mov	eax, DWORD PTR ___res$[ebp]
	jge	SHORT $L378
	neg	eax
	mov	DWORD PTR _errno, eax
	or	eax, -1
$L378:
	mov	esp, ebp
	pop	ebp
	ret	0
_setsid	ENDP
_TEXT	ENDS
END
