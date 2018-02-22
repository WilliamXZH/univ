	TITLE	..\lib\write.c
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
PUBLIC	_write
EXTRN	_errno:DWORD
_TEXT	SEGMENT
_fd$ = 8
_buf$ = 12
_count$ = 16
___res$ = -4
_write	PROC NEAR

; 20   : _syscall3(int,write,int,fd,const char *,buf,off_t,count)

	push	ebp
	mov	ebp, esp
	push	ecx
	push	ebx
	mov	eax, 4
	mov	ebx, DWORD PTR _fd$[ebp]
	mov	ecx, DWORD PTR _buf$[ebp]
	mov	edx, DWORD PTR _count$[ebp]
	int	-128					; ffffff80H
	mov	DWORD PTR ___res$[ebp], eax
	mov	eax, DWORD PTR ___res$[ebp]
	pop	ebx
	test	eax, eax
	mov	eax, DWORD PTR ___res$[ebp]
	jge	SHORT $L383
	neg	eax
	mov	DWORD PTR _errno, eax
	or	eax, -1
$L383:
	mov	esp, ebp
	pop	ebp
	ret	0
_write	ENDP
_TEXT	ENDS
END
