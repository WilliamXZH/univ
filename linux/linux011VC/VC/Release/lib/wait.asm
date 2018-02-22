	TITLE	..\lib\wait.c
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
PUBLIC	_waitpid
EXTRN	_errno:DWORD
_TEXT	SEGMENT
_pid$ = 8
_wait_stat$ = 12
_options$ = 16
___res$ = -4
_waitpid PROC NEAR

; 30   : _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,options)

	push	ebp
	mov	ebp, esp
	push	ecx
	push	ebx
	mov	eax, 7
	mov	ebx, DWORD PTR _pid$[ebp]
	mov	ecx, DWORD PTR _wait_stat$[ebp]
	mov	edx, DWORD PTR _options$[ebp]
	int	-128					; ffffff80H
	mov	DWORD PTR ___res$[ebp], eax
	mov	eax, DWORD PTR ___res$[ebp]
	pop	ebx
	test	eax, eax
	mov	eax, DWORD PTR ___res$[ebp]
	jge	SHORT $L393
	neg	eax
	mov	DWORD PTR _errno, eax
	or	eax, -1
$L393:
	mov	esp, ebp
	pop	ebp
	ret	0
_waitpid ENDP
_TEXT	ENDS
PUBLIC	_wait
_TEXT	SEGMENT
_wait_stat$ = 8
_wait	PROC NEAR

; 34   : {

	push	ebp
	mov	ebp, esp

; 35   : 	return waitpid(-1,wait_stat,0);

	mov	eax, DWORD PTR _wait_stat$[ebp]
	push	0
	push	eax
	push	-1
	call	_waitpid
	add	esp, 12					; 0000000cH

; 36   : }

	pop	ebp
	ret	0
_wait	ENDP
_TEXT	ENDS
END
