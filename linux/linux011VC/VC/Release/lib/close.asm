	TITLE	..\lib\close.c
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
PUBLIC	_close
EXTRN	_errno:DWORD
_TEXT	SEGMENT
_fd$ = 8
___res$ = -4
_close	PROC NEAR

; 16   : _syscall1(int,close,int,fd)

	push	ebp
	mov	ebp, esp
	push	ecx
	push	ebx
	mov	eax, 6
	mov	ebx, DWORD PTR _fd$[ebp]
	int	-128					; ffffff80H
	mov	DWORD PTR ___res$[ebp], eax
	mov	eax, DWORD PTR ___res$[ebp]
	pop	ebx
	test	eax, eax
	mov	eax, DWORD PTR ___res$[ebp]
	jge	SHORT $L380
	neg	eax
	mov	DWORD PTR _errno, eax
	or	eax, -1
$L380:
	mov	esp, ebp
	pop	ebp
	ret	0
_close	ENDP
_TEXT	ENDS
END
