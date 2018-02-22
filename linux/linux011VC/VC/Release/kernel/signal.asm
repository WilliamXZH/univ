	TITLE	..\kernel\signal.c
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
;	COMDAT __INC_PIPE
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _switch_to
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __set_base
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __set_limit
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __get_base
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _get_limit
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _get_fs_byte
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _get_fs_word
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _get_fs_long
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _put_fs_byte
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _put_fs_word
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _put_fs_long
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _get_fs
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _get_ds
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _set_fs
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	_sys_sgetmask
EXTRN	_current:DWORD
_TEXT	SEGMENT
_sys_sgetmask PROC NEAR

; 25   : {

	push	ebp
	mov	ebp, esp

; 26   : 	return current->blocked;

	mov	eax, DWORD PTR _current
	mov	eax, DWORD PTR [eax+528]

; 27   : }

	pop	ebp
	ret	0
_sys_sgetmask ENDP
_TEXT	ENDS
PUBLIC	_sys_ssetmask
_TEXT	SEGMENT
_newmask$ = 8
_old$ = -4
_sys_ssetmask PROC NEAR

; 31   : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 32   : 	int old = current->blocked;

	mov	eax, DWORD PTR _current
	mov	ecx, DWORD PTR [eax+528]
	mov	DWORD PTR _old$[ebp], ecx

; 33   : 
; 34   : 	current->blocked = newmask & ~(1 << (SIGKILL - 1));

	mov	edx, DWORD PTR _newmask$[ebp]
	and	dh, -2					; fffffffeH
	mov	eax, DWORD PTR _current
	mov	DWORD PTR [eax+528], edx

; 35   : 	return old;

	mov	eax, DWORD PTR _old$[ebp]

; 36   : }

	mov	esp, ebp
	pop	ebp
	ret	0
_sys_ssetmask ENDP
_TEXT	ENDS
PUBLIC	_sys_signal
_TEXT	SEGMENT
_signum$ = 8
_handler$ = 12
_restorer$ = 16
_tmp$ = -16
_sys_signal PROC NEAR

; 66   : {

	push	ebp
	mov	ebp, esp
	sub	esp, 16					; 00000010H

; 67   : 	struct sigaction tmp;
; 68   : 
; 69   : 	if (signum < 1 || signum > 32 || signum == SIGKILL)	// 信号值要在（1-32）范围内，

	cmp	DWORD PTR _signum$[ebp], 1
	jl	SHORT $L631
	cmp	DWORD PTR _signum$[ebp], 32		; 00000020H
	jg	SHORT $L631
	cmp	DWORD PTR _signum$[ebp], 9
	jne	SHORT $L630
$L631:

; 70   : 		return -1;			// 并且不得是SIGKILL。

	or	eax, -1
	jmp	SHORT $L628
$L630:

; 71   : 	tmp.sa_handler = (void (*)(int)) handler;	// 指定的信号处理句柄。

	mov	eax, DWORD PTR _handler$[ebp]
	mov	DWORD PTR _tmp$[ebp], eax

; 72   : 	tmp.sa_mask = 0;		// 执行时的信号屏蔽码。

	mov	DWORD PTR _tmp$[ebp+4], 0

; 73   : 	tmp.sa_flags = SA_ONESHOT | SA_NOMASK;	// 该句柄只使用1 次后就恢复到默认值，

	mov	DWORD PTR _tmp$[ebp+8], -1073741824	; c0000000H

; 74   : // 并允许信号在自己的处理句柄中收到。
; 75   : 	tmp.sa_restorer = (void (*)(void)) restorer;	// 保存返回地址。

	mov	ecx, DWORD PTR _restorer$[ebp]
	mov	DWORD PTR _tmp$[ebp+12], ecx

; 76   : 	handler = (long) current->sigaction[signum - 1].sa_handler;

	mov	edx, DWORD PTR _signum$[ebp]
	sub	edx, 1
	shl	edx, 4
	mov	eax, DWORD PTR _current
	mov	ecx, DWORD PTR [eax+edx+16]
	mov	DWORD PTR _handler$[ebp], ecx

; 77   : 	current->sigaction[signum - 1] = tmp;

	mov	edx, DWORD PTR _signum$[ebp]
	sub	edx, 1
	shl	edx, 4
	mov	eax, DWORD PTR _current
	lea	ecx, DWORD PTR [eax+edx+16]
	mov	edx, DWORD PTR _tmp$[ebp]
	mov	DWORD PTR [ecx], edx
	mov	eax, DWORD PTR _tmp$[ebp+4]
	mov	DWORD PTR [ecx+4], eax
	mov	edx, DWORD PTR _tmp$[ebp+8]
	mov	DWORD PTR [ecx+8], edx
	mov	eax, DWORD PTR _tmp$[ebp+12]
	mov	DWORD PTR [ecx+12], eax

; 78   : 	return handler;

	mov	eax, DWORD PTR _handler$[ebp]
$L628:

; 79   : }

	mov	esp, ebp
	pop	ebp
	ret	0
_sys_signal ENDP
_TEXT	ENDS
PUBLIC	_sys_sigaction
EXTRN	_verify_area:NEAR
_TEXT	SEGMENT
_signum$ = 8
_action$ = 12
_oldaction$ = 16
_tmp$ = -16
$T721 = -24
$T722 = -28
_i$724 = -20
$T731 = -32
$T732 = -36
$T737 = -44
_i$739 = -40
$T746 = -48
$T747 = -52
_sys_sigaction PROC NEAR

; 86   : {

	push	ebp
	mov	ebp, esp
	sub	esp, 52					; 00000034H
	push	ebx
	push	esi
	push	edi

; 90   : 	if (signum < 1 || signum > 32 || signum == SIGKILL)

	cmp	DWORD PTR _signum$[ebp], 1
	jl	SHORT $L647
	cmp	DWORD PTR _signum$[ebp], 32		; 00000020H
	jg	SHORT $L647
	cmp	DWORD PTR _signum$[ebp], 9
	jne	SHORT $L646
$L647:

; 91   : 		return -1;

	or	eax, -1
	jmp	$L644
$L646:

; 92   : // 在信号的sigaction 结构中设置新的操作（动作）。
; 93   : 	tmp = current->sigaction[signum - 1];

	mov	eax, DWORD PTR _signum$[ebp]
	sub	eax, 1
	shl	eax, 4
	mov	ecx, DWORD PTR _current
	lea	edx, DWORD PTR [ecx+eax+16]
	mov	eax, DWORD PTR [edx]
	mov	DWORD PTR _tmp$[ebp], eax
	mov	ecx, DWORD PTR [edx+4]
	mov	DWORD PTR _tmp$[ebp+4], ecx
	mov	eax, DWORD PTR [edx+8]
	mov	DWORD PTR _tmp$[ebp+8], eax
	mov	ecx, DWORD PTR [edx+12]
	mov	DWORD PTR _tmp$[ebp+12], ecx

; 94   : 	get_new ((char *) action, (char *) (signum - 1 + current->sigaction));

	mov	edx, DWORD PTR _signum$[ebp]
	sub	edx, 1
	shl	edx, 4
	mov	eax, DWORD PTR _current
	lea	ecx, DWORD PTR [eax+edx+16]
	mov	DWORD PTR $T732[ebp], ecx
	mov	edx, DWORD PTR _action$[ebp]
	mov	DWORD PTR $T731[ebp], edx
	mov	DWORD PTR _i$724[ebp], 0
	jmp	SHORT $L725
$L726:
	mov	eax, DWORD PTR _i$724[ebp]
	add	eax, 1
	mov	DWORD PTR _i$724[ebp], eax
$L725:
	cmp	DWORD PTR _i$724[ebp], 16		; 00000010H
	jae	SHORT $L727
	mov	ecx, DWORD PTR $T731[ebp]
	mov	DWORD PTR $T721[ebp], ecx
	mov	edx, DWORD PTR $T731[ebp]
	add	edx, 1
	mov	DWORD PTR $T731[ebp], edx

; 90   : 	if (signum < 1 || signum > 32 || signum == SIGKILL)

	mov	ebx, DWORD PTR $T721[ebp]

; 91   : 		return -1;

	mov	al, BYTE PTR fs:[ebx]

; 94   : 	get_new ((char *) action, (char *) (signum - 1 + current->sigaction));

	mov	BYTE PTR $T722[ebp], al
	mov	eax, DWORD PTR $T732[ebp]
	mov	cl, BYTE PTR $T722[ebp]
	mov	BYTE PTR [eax], cl
	mov	edx, DWORD PTR $T732[ebp]
	add	edx, 1
	mov	DWORD PTR $T732[ebp], edx
	jmp	SHORT $L726
$L727:

; 95   : // 如果oldaction 指针不为空的话，则将原操作指针保存到oldaction 所指的位置。
; 96   : 	if (oldaction)

	cmp	DWORD PTR _oldaction$[ebp], 0
	je	SHORT $L742

; 97   : 		save_old ((char *) &tmp, (char *) oldaction);

	mov	eax, DWORD PTR _oldaction$[ebp]
	mov	DWORD PTR $T747[ebp], eax
	lea	ecx, DWORD PTR _tmp$[ebp]
	mov	DWORD PTR $T746[ebp], ecx
	push	16					; 00000010H
	mov	edx, DWORD PTR $T747[ebp]
	push	edx
	call	_verify_area
	add	esp, 8
	mov	DWORD PTR _i$739[ebp], 0
	jmp	SHORT $L740
$L741:
	mov	eax, DWORD PTR _i$739[ebp]
	add	eax, 1
	mov	DWORD PTR _i$739[ebp], eax
$L740:
	cmp	DWORD PTR _i$739[ebp], 16		; 00000010H
	jae	SHORT $L742
	mov	ecx, DWORD PTR $T746[ebp]
	mov	dl, BYTE PTR [ecx]
	mov	BYTE PTR $T737[ebp], dl

; 87   : 	struct sigaction tmp;
; 88   : 

	mov	ebx, DWORD PTR $T747[ebp]

; 89   : // 信号值要在（1-32）范围内，并且信号SIGKILL 的处理句柄不能被改变。

	mov	al, BYTE PTR $T737[ebp]

; 90   : 	if (signum < 1 || signum > 32 || signum == SIGKILL)

	mov	BYTE PTR fs:[ebx], al

; 97   : 		save_old ((char *) &tmp, (char *) oldaction);

	mov	eax, DWORD PTR $T746[ebp]
	add	eax, 1
	mov	DWORD PTR $T746[ebp], eax
	mov	ecx, DWORD PTR $T747[ebp]
	add	ecx, 1
	mov	DWORD PTR $T747[ebp], ecx
	jmp	SHORT $L741
$L742:

; 98   : // 如果允许信号在自己的信号句柄中收到，则令屏蔽码为0，否则设置屏蔽本信号。
; 99   : 	if (current->sigaction[signum - 1].sa_flags & SA_NOMASK)

	mov	edx, DWORD PTR _signum$[ebp]
	sub	edx, 1
	shl	edx, 4
	mov	eax, DWORD PTR _current
	mov	ecx, DWORD PTR [eax+edx+24]
	and	ecx, 1073741824				; 40000000H
	test	ecx, ecx
	je	SHORT $L653

; 100  : 		current->sigaction[signum - 1].sa_mask = 0;

	mov	edx, DWORD PTR _signum$[ebp]
	sub	edx, 1
	shl	edx, 4
	mov	eax, DWORD PTR _current
	mov	DWORD PTR [eax+edx+20], 0

; 101  : 	else

	jmp	SHORT $L654
$L653:

; 102  : 		current->sigaction[signum - 1].sa_mask |= (1 << (signum - 1));

	mov	edx, DWORD PTR _signum$[ebp]
	sub	edx, 1
	shl	edx, 4
	mov	ecx, DWORD PTR _signum$[ebp]
	sub	ecx, 1
	mov	eax, 1
	shl	eax, cl
	mov	ecx, DWORD PTR _current
	mov	edx, DWORD PTR [ecx+edx+20]
	or	edx, eax
	mov	eax, DWORD PTR _signum$[ebp]
	sub	eax, 1
	shl	eax, 4
	mov	ecx, DWORD PTR _current
	mov	DWORD PTR [ecx+eax+20], edx
$L654:

; 103  : 	return 0;

	xor	eax, eax
$L644:

; 104  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
_sys_sigaction ENDP
_TEXT	ENDS
PUBLIC	__INC_PIPE
;	COMDAT __INC_PIPE
_TEXT	SEGMENT
_head$ = 8
__INC_PIPE PROC NEAR					; COMDAT

; 85   : extern _inline void _INC_PIPE(unsigned long *head) {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi
	push	edi

; 86   : 	_asm mov ebx,head

	mov	ebx, DWORD PTR _head$[ebp]

; 87   : 	_asm inc dword ptr [ebx]

	inc	DWORD PTR [ebx]

; 88   : 	_asm and dword ptr [ebx],4095

	and	DWORD PTR [ebx], 4095			; 00000fffH

; 89   : }

	pop	edi
	pop	esi
	pop	ebx
	pop	ebp
	ret	0
__INC_PIPE ENDP
_TEXT	ENDS
PUBLIC	_do_signal
EXTRN	_do_exit:NEAR
_TEXT	SEGMENT
_signr$ = 8
_eax$ = 12
_ecx$ = 20
_edx$ = 24
_eip$ = 40
_eflags$ = 48
_esp$ = 52
_sa_handler$ = -8
_old_eip$ = -16
_sa$ = -4
_longs$ = -20
_tmp_esp$ = -12
$T753 = -24
$T754 = -28
$T758 = -32
$T762 = -36
$T763 = -40
$T767 = -44
$T771 = -48
$T775 = -52
$T779 = -56
$T783 = -60
_do_signal PROC NEAR

; 112  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 60					; 0000003cH
	push	ebx
	push	esi
	push	edi

; 113  : 	unsigned long sa_handler;
; 114  : 	long old_eip = eip;

	mov	eax, DWORD PTR _eip$[ebp]
	mov	DWORD PTR _old_eip$[ebp], eax

; 115  : 	struct sigaction *sa = current->sigaction + signr - 1;	//current->sigaction[signu-1]。

	mov	ecx, DWORD PTR _signr$[ebp]
	shl	ecx, 4
	mov	edx, DWORD PTR _current
	add	edx, ecx
	mov	DWORD PTR _sa$[ebp], edx

; 117  : 	unsigned long *tmp_esp;
; 118  : 
; 119  : 	sa_handler = (unsigned long) sa->sa_handler;

	mov	eax, DWORD PTR _sa$[ebp]
	mov	ecx, DWORD PTR [eax]
	mov	DWORD PTR _sa_handler$[ebp], ecx

; 120  : // 如果信号句柄为SIG_IGN(忽略)，则返回；如果句柄为SIG_DFL(默认处理)，则如果信号是
; 121  : // SIGCHLD 则返回，否则终止进程的执行
; 122  : 	if (sa_handler == 1)

	cmp	DWORD PTR _sa_handler$[ebp], 1
	jne	SHORT $L689

; 123  : 		return;

	jmp	$L682
$L689:

; 124  : 	if (!sa_handler)

	cmp	DWORD PTR _sa_handler$[ebp], 0
	jne	SHORT $L692

; 126  : 		if (signr == SIGCHLD)

	cmp	DWORD PTR _signr$[ebp], 17		; 00000011H
	jne	SHORT $L691

; 127  : 			return;

	jmp	$L682
$L691:

; 128  : 		else
; 129  : // 这里应该是do_exit(1<<signr))。
; 130  : 			do_exit (1 << (signr - 1));	// [?? 为什么以信号位图为参数？不为什么!？?]

	mov	ecx, DWORD PTR _signr$[ebp]
	sub	ecx, 1
	mov	edx, 1
	shl	edx, cl
	push	edx
	call	_do_exit
	add	esp, 4
$L692:

; 132  : // 如果该信号句柄只需使用一次，则将该句柄置空(该信号句柄已经保存在sa_handler 指针中)。
; 133  : 	if (sa->sa_flags & SA_ONESHOT)

	mov	eax, DWORD PTR _sa$[ebp]
	mov	ecx, DWORD PTR [eax+8]
	and	ecx, -2147483648			; 80000000H
	test	ecx, ecx
	je	SHORT $L693

; 134  : 		sa->sa_handler = NULL;

	mov	edx, DWORD PTR _sa$[ebp]
	mov	DWORD PTR [edx], 0
$L693:

; 135  : // 下面这段代码将信号处理句柄插入到用户堆栈中，同时也将sa_restorer,signr,进程屏蔽码(如果
; 136  : // SA_NOMASK 没置位),eax,ecx,edx 作为参数以及原调用系统调用的程序返回指针及标志寄存器值
; 137  : // 压入堆栈。因此在本次系统调用中断(0x80)返回用户程序时会首先执行用户的信号句柄程序，然后
; 138  : // 再继续执行用户程序。
; 139  : // 将用户调用系统调用的代码指针eip 指向该信号处理句柄。
; 140  : 	*(&eip) = sa_handler;

	mov	eax, DWORD PTR _sa_handler$[ebp]
	mov	DWORD PTR _eip$[ebp], eax

; 141  : // 如果允许信号自己的处理句柄收到信号自己，则也需要将进程的阻塞码压入堆栈。
; 142  : 	longs = (sa->sa_flags & SA_NOMASK) ? 7 : 8;

	mov	ecx, DWORD PTR _sa$[ebp]
	mov	edx, DWORD PTR [ecx+8]
	and	edx, 1073741824				; 40000000H
	neg	edx
	sbb	edx, edx
	add	edx, 8
	mov	DWORD PTR _longs$[ebp], edx

; 143  : // 将原调用程序的用户的堆栈指针向下扩展7（或8）个长字（用来存放调用信号句柄的参数等），
; 144  : // 并检查内存使用情况（例如如果内存超界则分配新页等）。
; 145  : 	*(&esp) -= longs;

	mov	eax, DWORD PTR _longs$[ebp]
	shl	eax, 2
	mov	ecx, DWORD PTR _esp$[ebp]
	sub	ecx, eax
	mov	DWORD PTR _esp$[ebp], ecx

; 146  : 	verify_area (esp, longs * 4);

	mov	edx, DWORD PTR _longs$[ebp]
	shl	edx, 2
	push	edx
	mov	eax, DWORD PTR _esp$[ebp]
	push	eax
	call	_verify_area
	add	esp, 8

; 147  : // 在用户堆栈中从下到上存放sa_restorer, 信号signr, 屏蔽码blocked(如果SA_NOMASK 置位),
; 148  : // eax, ecx, edx, eflags 和用户程序原代码指针。
; 149  : 	tmp_esp = esp;

	mov	ecx, DWORD PTR _esp$[ebp]
	mov	DWORD PTR _tmp_esp$[ebp], ecx

; 150  : 	put_fs_long ((long) sa->sa_restorer, tmp_esp++);

	mov	edx, DWORD PTR _tmp_esp$[ebp]
	mov	DWORD PTR $T754[ebp], edx
	mov	eax, DWORD PTR _sa$[ebp]
	mov	ecx, DWORD PTR [eax+12]
	mov	DWORD PTR $T753[ebp], ecx
	mov	edx, DWORD PTR _tmp_esp$[ebp]
	add	edx, 4
	mov	DWORD PTR _tmp_esp$[ebp], edx

; 113  : 	unsigned long sa_handler;
; 114  : 	long old_eip = eip;

	mov	ebx, DWORD PTR $T754[ebp]

; 115  : 	struct sigaction *sa = current->sigaction + signr - 1;	//current->sigaction[signu-1]。

	mov	eax, DWORD PTR $T753[ebp]

; 116  : 	int longs;

	mov	DWORD PTR fs:[ebx], eax

; 151  : 	put_fs_long (signr, tmp_esp++);

	mov	eax, DWORD PTR _tmp_esp$[ebp]
	mov	DWORD PTR $T758[ebp], eax
	mov	ecx, DWORD PTR _tmp_esp$[ebp]
	add	ecx, 4
	mov	DWORD PTR _tmp_esp$[ebp], ecx

; 113  : 	unsigned long sa_handler;
; 114  : 	long old_eip = eip;

	mov	ebx, DWORD PTR $T758[ebp]

; 115  : 	struct sigaction *sa = current->sigaction + signr - 1;	//current->sigaction[signu-1]。

	mov	eax, DWORD PTR _signr$[ebp]

; 116  : 	int longs;

	mov	DWORD PTR fs:[ebx], eax

; 152  : 	if (!(sa->sa_flags & SA_NOMASK))

	mov	edx, DWORD PTR _sa$[ebp]
	mov	eax, DWORD PTR [edx+8]
	and	eax, 1073741824				; 40000000H
	test	eax, eax
	jne	SHORT $L760

; 153  : 		put_fs_long (current->blocked, tmp_esp++);

	mov	ecx, DWORD PTR _tmp_esp$[ebp]
	mov	DWORD PTR $T763[ebp], ecx
	mov	edx, DWORD PTR _current
	mov	eax, DWORD PTR [edx+528]
	mov	DWORD PTR $T762[ebp], eax
	mov	ecx, DWORD PTR _tmp_esp$[ebp]
	add	ecx, 4
	mov	DWORD PTR _tmp_esp$[ebp], ecx

; 113  : 	unsigned long sa_handler;
; 114  : 	long old_eip = eip;

	mov	ebx, DWORD PTR $T763[ebp]

; 115  : 	struct sigaction *sa = current->sigaction + signr - 1;	//current->sigaction[signu-1]。

	mov	eax, DWORD PTR $T762[ebp]

; 116  : 	int longs;

	mov	DWORD PTR fs:[ebx], eax

; 153  : 		put_fs_long (current->blocked, tmp_esp++);

$L760:

; 154  : 	put_fs_long (eax, tmp_esp++);

	mov	edx, DWORD PTR _tmp_esp$[ebp]
	mov	DWORD PTR $T767[ebp], edx
	mov	eax, DWORD PTR _tmp_esp$[ebp]
	add	eax, 4
	mov	DWORD PTR _tmp_esp$[ebp], eax

; 113  : 	unsigned long sa_handler;
; 114  : 	long old_eip = eip;

	mov	ebx, DWORD PTR $T767[ebp]

; 115  : 	struct sigaction *sa = current->sigaction + signr - 1;	//current->sigaction[signu-1]。

	mov	eax, DWORD PTR _eax$[ebp]

; 116  : 	int longs;

	mov	DWORD PTR fs:[ebx], eax

; 155  : 	put_fs_long (ecx, tmp_esp++);

	mov	ecx, DWORD PTR _tmp_esp$[ebp]
	mov	DWORD PTR $T771[ebp], ecx
	mov	edx, DWORD PTR _tmp_esp$[ebp]
	add	edx, 4
	mov	DWORD PTR _tmp_esp$[ebp], edx

; 113  : 	unsigned long sa_handler;
; 114  : 	long old_eip = eip;

	mov	ebx, DWORD PTR $T771[ebp]

; 115  : 	struct sigaction *sa = current->sigaction + signr - 1;	//current->sigaction[signu-1]。

	mov	eax, DWORD PTR _ecx$[ebp]

; 116  : 	int longs;

	mov	DWORD PTR fs:[ebx], eax

; 156  : 	put_fs_long (edx, tmp_esp++);

	mov	eax, DWORD PTR _tmp_esp$[ebp]
	mov	DWORD PTR $T775[ebp], eax
	mov	ecx, DWORD PTR _tmp_esp$[ebp]
	add	ecx, 4
	mov	DWORD PTR _tmp_esp$[ebp], ecx

; 113  : 	unsigned long sa_handler;
; 114  : 	long old_eip = eip;

	mov	ebx, DWORD PTR $T775[ebp]

; 115  : 	struct sigaction *sa = current->sigaction + signr - 1;	//current->sigaction[signu-1]。

	mov	eax, DWORD PTR _edx$[ebp]

; 116  : 	int longs;

	mov	DWORD PTR fs:[ebx], eax

; 157  : 	put_fs_long (eflags, tmp_esp++);

	mov	edx, DWORD PTR _tmp_esp$[ebp]
	mov	DWORD PTR $T779[ebp], edx
	mov	eax, DWORD PTR _tmp_esp$[ebp]
	add	eax, 4
	mov	DWORD PTR _tmp_esp$[ebp], eax

; 113  : 	unsigned long sa_handler;
; 114  : 	long old_eip = eip;

	mov	ebx, DWORD PTR $T779[ebp]

; 115  : 	struct sigaction *sa = current->sigaction + signr - 1;	//current->sigaction[signu-1]。

	mov	eax, DWORD PTR _eflags$[ebp]

; 116  : 	int longs;

	mov	DWORD PTR fs:[ebx], eax

; 158  : 	put_fs_long (old_eip, tmp_esp++);

	mov	ecx, DWORD PTR _tmp_esp$[ebp]
	mov	DWORD PTR $T783[ebp], ecx
	mov	edx, DWORD PTR _tmp_esp$[ebp]
	add	edx, 4
	mov	DWORD PTR _tmp_esp$[ebp], edx

; 113  : 	unsigned long sa_handler;
; 114  : 	long old_eip = eip;

	mov	ebx, DWORD PTR $T783[ebp]

; 115  : 	struct sigaction *sa = current->sigaction + signr - 1;	//current->sigaction[signu-1]。

	mov	eax, DWORD PTR _old_eip$[ebp]

; 116  : 	int longs;

	mov	DWORD PTR fs:[ebx], eax

; 159  : 	current->blocked |= sa->sa_mask;	// 进程阻塞码(屏蔽码)添上sa_mask 中的码位。

	mov	eax, DWORD PTR _current
	mov	ecx, DWORD PTR _sa$[ebp]
	mov	edx, DWORD PTR [eax+528]
	or	edx, DWORD PTR [ecx+4]
	mov	eax, DWORD PTR _current
	mov	DWORD PTR [eax+528], edx
$L682:

; 160  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
_do_signal ENDP
_TEXT	ENDS
PUBLIC	_switch_to
EXTRN	_task:BYTE
EXTRN	_last_task_used_math:DWORD
;	COMDAT _switch_to
_TEXT	SEGMENT
_n$ = 8
___tmp$ = -4
_switch_to PROC NEAR					; COMDAT

; 268  : {

	push	ebp
	mov	ebp, esp
	push	ecx
	push	ebx
	push	esi
	push	edi

; 269  : 	unsigned short __tmp;
; 270  : 	__tmp = (unsigned short)_TSS(n);

	mov	eax, DWORD PTR _n$[ebp]
	shl	eax, 4
	add	eax, 32					; 00000020H
	mov	WORD PTR ___tmp$[ebp], ax

; 271  : 
; 272  : 	_asm {
; 273  : 		mov ebx, offset task

	mov	ebx, OFFSET FLAT:_task

; 274  : 		mov eax, n

	mov	eax, DWORD PTR _n$[ebp]

; 275  : 		mov ecx, [ebx+eax*4]

	mov	ecx, DWORD PTR [ebx+eax*4]

; 276  : 		cmp ecx, current/* 任务n 是当前任务吗?(current ==task[n]?) */ 

	cmp	ecx, DWORD PTR _current

; 277  : 		je l1 /* 是，则什么都不做，退出。*/ 

	je	SHORT $l1$499

; 278  : 		xchg ecx,current/* current = task[n]； */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*执行长跳转，造成任务切换 (头大了很长时间，多多包涵)*/
; 280  : 		mov ax, __tmp

	mov	ax, WORD PTR ___tmp$[ebp]

; 281  : 		mov word ptr ds:[lcs],ax

	mov	WORD PTR ds:$lcs$500, ax

; 282  : 		_emit 0xea

	DB	-22					; ffffffeaH

; 283  : 		_emit 0		// ip

	DB	0

; 284  : 		_emit 0 

	DB	0

; 285  : 		_emit 0 

	DB	0

; 286  : 		_emit 0

	DB	0
$lcs$500:

; 287  : lcs:	_emit 0		// cs

	DB	0

; 288  : 		_emit 0

	DB	0

; 289  : // 在任务切换回来后才会继续执行下面的语句。
; 290  : 		cmp last_task_used_math,ecx /* 新任务上次使用过协处理器吗？*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$499

; 292  : 		clts/* 新任务上次使用过协处理器，则清cr0 的TS 标志。*/

	clts
$l1$499:

; 293  : 	}
; 294  : l1: ;
; 295  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
_switch_to ENDP
_TEXT	ENDS
PUBLIC	__set_base
;	COMDAT __set_base
_TEXT	SEGMENT
_addr$ = 8
_base$ = 12
__set_base PROC NEAR					; COMDAT

; 319  : { 

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi
	push	edi

; 320  : /*	addr[1] = base;
; 321  : 	((char*)addr)[4] = base >> 16;
; 322  : 	((char*)addr)[7] = base >> 8;*/
; 323  : 	_asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 324  : 	_asm mov edx,base 

	mov	edx, DWORD PTR _base$[ebp]

; 325  : 	_asm mov word ptr [ebx+2],dx // 基址base 低16 位(位15-0)->[addr+2]。

	mov	WORD PTR [ebx+2], dx

; 326  : 	_asm ror edx,16 // edx 中基址高16 位(位31-16) -> dx。 

	ror	edx, 16					; 00000010H

; 327  : 	_asm mov byte ptr [ebx+4],dl // 基址高16 位中的低8 位(位23-16)->[addr+4]。

	mov	BYTE PTR [ebx+4], dl

; 328  : 	_asm mov byte ptr [ebx+7],dh // 基址高16 位中的高8 位(位31-24)->[addr+7]。

	mov	BYTE PTR [ebx+7], dh

; 329  : }

	pop	edi
	pop	esi
	pop	ebx
	pop	ebp
	ret	0
__set_base ENDP
_TEXT	ENDS
PUBLIC	__set_limit
;	COMDAT __set_limit
_TEXT	SEGMENT
_addr$ = 8
_limit$ = 12
__set_limit PROC NEAR					; COMDAT

; 340  : {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi
	push	edi

; 341  : /*	addr[0] = limit;
; 342  : 	((char*)addr)[6] = ((char*)addr)[6] & 0xf0 + (limit >> 16) & 0x0f;*/
; 343  : 	_asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 344  : 	_asm mov edx,limit 

	mov	edx, DWORD PTR _limit$[ebp]

; 345  : 	_asm mov word ptr [ebx],dx // 段长limit 低16 位(位15-0)->[addr]。

	mov	WORD PTR [ebx], dx

; 346  : 	_asm ror edx,16 // edx 中的段长高4 位(位19-16)->dl。

	ror	edx, 16					; 00000010H

; 347  : 	_asm mov dh,byte ptr [ebx+6] // 取原[addr+6]字节->dh，其中高4 位是些标志。

	mov	dh, BYTE PTR [ebx+6]

; 348  : 	_asm and dh,0f0h // 清dh 的低4 位(将存放段长的位19-16)。

	and	dh, -16					; fffffff0H

; 349  : 	_asm or dl,dh // 将原高4 位标志和段长的高4 位(位19-16)合成1 字节，

	or	dl, dh

; 350  : 	_asm mov byte ptr [ebx+6],dl // 并放回[addr+6]处。

	mov	BYTE PTR [ebx+6], dl

; 351  : }

	pop	edi
	pop	esi
	pop	ebx
	pop	ebp
	ret	0
__set_limit ENDP
_TEXT	ENDS
PUBLIC	__get_base
;	COMDAT __get_base
_TEXT	SEGMENT
_addr$ = 8
__get_base PROC NEAR					; COMDAT

; 374  : {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi
	push	edi

; 375  : //	unsigned long __base; 
; 376  : 	_asm { 
; 377  : 		_asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 378  : 		_asm mov ah,byte ptr [ebx+7] // 取[addr+7]处基址高16 位的高8 位(位31-24)->dh。

	mov	ah, BYTE PTR [ebx+7]

; 379  : 		_asm mov al,byte ptr [ebx+4] // 取[addr+4]处基址高16 位的低8 位(位23-16)->dl。

	mov	al, BYTE PTR [ebx+4]

; 380  : 		_asm shl eax,16 // 基地址高16 位移到edx 中高16 位处。

	shl	eax, 16					; 00000010H

; 381  : 		_asm mov ax,word ptr [ebx+2] // 取[addr+2]处基址低16 位(位15-0)->dx。

	mov	ax, WORD PTR [ebx+2]

; 382  : //		_asm mov __base,eax 
; 383  : 		} 
; 384  : //	return __base; 
; 385  : }

	pop	edi
	pop	esi
	pop	ebx
	pop	ebp
	ret	0
__get_base ENDP
_TEXT	ENDS
PUBLIC	_get_limit
;	COMDAT _get_limit
_TEXT	SEGMENT
_segment$ = 8
_get_limit PROC NEAR					; COMDAT

; 400  : extern _inline unsigned long get_limit(unsigned long segment) { 

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi
	push	edi

; 401  : //	unsigned long __limit; 
; 402  : 	_asm { 
; 403  : 		mov eax,segment 

	mov	eax, DWORD PTR _segment$[ebp]

; 404  : 		lsl eax,eax 

	lsl	eax, eax

; 405  : //		mov __limit,eax 
; 406  : 	} 
; 407  : //	return __limit; 
; 408  : }

	pop	edi
	pop	esi
	pop	ebx
	pop	ebp
	ret	0
_get_limit ENDP
_TEXT	ENDS
PUBLIC	_get_fs_byte
;	COMDAT _get_fs_byte
_TEXT	SEGMENT
_addr$ = 8
_get_fs_byte PROC NEAR					; COMDAT

; 7    : {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi
	push	edi

; 8    : //  unsigned register char _v;
; 9    : 
; 10   : // __asm__ ("movb %%fs:%1,%0": "=r" (_v):"m" (*addr));
; 11   :   _asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 12   :   _asm mov al,byte ptr fs:[ebx];

	mov	al, BYTE PTR fs:[ebx]

; 13   : //  _asm mov _v,al;
; 14   : //  return _v;
; 15   : }

	pop	edi
	pop	esi
	pop	ebx
	pop	ebp
	ret	0
_get_fs_byte ENDP
_TEXT	ENDS
PUBLIC	_get_fs_word
;	COMDAT _get_fs_word
_TEXT	SEGMENT
_addr$ = 8
_get_fs_word PROC NEAR					; COMDAT

; 23   : {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi
	push	edi

; 24   : //  unsigned short _v;
; 25   : 
; 26   : //__asm__ ("movw %%fs:%1,%0": "=r" (_v):"m" (*addr));
; 27   :   _asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 28   :   _asm mov ax,word ptr fs:[ebx];

	mov	ax, WORD PTR fs:[ebx]

; 29   : //  _asm mov _v,ax;
; 30   : //  return _v;
; 31   : }

	pop	edi
	pop	esi
	pop	ebx
	pop	ebp
	ret	0
_get_fs_word ENDP
_TEXT	ENDS
PUBLIC	_get_fs_long
;	COMDAT _get_fs_long
_TEXT	SEGMENT
_addr$ = 8
_get_fs_long PROC NEAR					; COMDAT

; 39   : {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi
	push	edi

; 40   : //  unsigned long _v;
; 41   : 
; 42   : //__asm__ ("movl %%fs:%1,%0": "=r" (_v):"m" (*addr));
; 43   :   _asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 44   :   _asm mov eax,dword ptr fs:[ebx];

	mov	eax, DWORD PTR fs:[ebx]

; 45   : //  _asm mov _v,eax;
; 46   : //  return _v;
; 47   : }

	pop	edi
	pop	esi
	pop	ebx
	pop	ebp
	ret	0
_get_fs_long ENDP
_TEXT	ENDS
PUBLIC	_put_fs_byte
;	COMDAT _put_fs_byte
_TEXT	SEGMENT
_val$ = 8
_addr$ = 12
_put_fs_byte PROC NEAR					; COMDAT

; 54   : {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi
	push	edi

; 55   : //  __asm__ ("movb %0,%%fs:%1"::"r" (val), "m" (*addr));
; 56   : 	_asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 57   : 	_asm mov al,val;

	mov	al, BYTE PTR _val$[ebp]

; 58   : 	_asm mov byte ptr fs:[ebx],al;

	mov	BYTE PTR fs:[ebx], al

; 59   : }

	pop	edi
	pop	esi
	pop	ebx
	pop	ebp
	ret	0
_put_fs_byte ENDP
_TEXT	ENDS
PUBLIC	_put_fs_word
;	COMDAT _put_fs_word
_TEXT	SEGMENT
_val$ = 8
_addr$ = 12
_put_fs_word PROC NEAR					; COMDAT

; 66   : {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi
	push	edi

; 67   : //  __asm__ ("movw %0,%%fs:%1"::"r" (val), "m" (*addr));
; 68   : 	_asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 69   : 	_asm mov ax,val;

	mov	ax, WORD PTR _val$[ebp]

; 70   : 	_asm mov word ptr fs:[ebx],ax;

	mov	WORD PTR fs:[ebx], ax

; 71   : }

	pop	edi
	pop	esi
	pop	ebx
	pop	ebp
	ret	0
_put_fs_word ENDP
_TEXT	ENDS
PUBLIC	_put_fs_long
;	COMDAT _put_fs_long
_TEXT	SEGMENT
_val$ = 8
_addr$ = 12
_put_fs_long PROC NEAR					; COMDAT

; 78   : {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi
	push	edi

; 79   : //  __asm__ ("movl %0,%%fs:%1"::"r" (val), "m" (*addr));
; 80   : 	_asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 81   : 	_asm mov eax,val;

	mov	eax, DWORD PTR _val$[ebp]

; 82   : 	_asm mov dword ptr fs:[ebx],eax;

	mov	DWORD PTR fs:[ebx], eax

; 83   : }

	pop	edi
	pop	esi
	pop	ebx
	pop	ebp
	ret	0
_put_fs_long ENDP
_TEXT	ENDS
PUBLIC	_get_fs
;	COMDAT _get_fs
_TEXT	SEGMENT
_get_fs	PROC NEAR					; COMDAT

; 96   : {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi
	push	edi

; 97   : //  unsigned short _v;
; 98   : //__asm__ ("mov %%fs,%%ax": "=a" (_v):);
; 99   :   _asm mov ax,fs;

	mov	ax, fs

; 100  : //  _asm mov _v,ax;
; 101  : //  return _v;
; 102  : }

	pop	edi
	pop	esi
	pop	ebx
	pop	ebp
	ret	0
_get_fs	ENDP
_TEXT	ENDS
PUBLIC	_get_ds
;	COMDAT _get_ds
_TEXT	SEGMENT
_get_ds	PROC NEAR					; COMDAT

; 108  : {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi
	push	edi

; 109  : //  unsigned short _v;
; 110  : //__asm__ ("mov %%ds,%%ax": "=a" (_v):);
; 111  :   _asm mov ax,fs;

	mov	ax, fs

; 112  : //  _asm mov _v,ax;
; 113  : //  return _v;
; 114  : }

	pop	edi
	pop	esi
	pop	ebx
	pop	ebp
	ret	0
_get_ds	ENDP
_TEXT	ENDS
PUBLIC	_set_fs
;	COMDAT _set_fs
_TEXT	SEGMENT
_val$ = 8
_set_fs	PROC NEAR					; COMDAT

; 120  : {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi
	push	edi

; 121  : //  __asm__ ("mov %0,%%fs"::"a" ((unsigned short) val));
; 122  : 	_asm mov eax,val;

	mov	eax, DWORD PTR _val$[ebp]

; 123  : 	_asm mov fs,ax;

	mov	fs, ax

; 124  : }

	pop	edi
	pop	esi
	pop	ebx
	pop	ebp
	ret	0
_set_fs	ENDP
_TEXT	ENDS
END
