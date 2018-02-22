	TITLE	..\lib\execve.c
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
PUBLIC	_execve
EXTRN	_errno:DWORD
_TEXT	SEGMENT
_file$ = 8
_argv$ = 12
_envp$ = 16
___res$ = -4
_execve	PROC NEAR

; 17   : _syscall3(int,execve,const char *,file,char **,argv,char **,envp)

	push	ebp
	mov	ebp, esp
	push	ecx
	push	ebx
	mov	eax, 11					; 0000000bH
	mov	ebx, DWORD PTR _file$[ebp]
	mov	ecx, DWORD PTR _argv$[ebp]
	mov	edx, DWORD PTR _envp$[ebp]
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
_execve	ENDP
_TEXT	ENDS
END
