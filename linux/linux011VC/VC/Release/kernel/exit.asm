	TITLE	..\kernel\exit.c
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
PUBLIC	_release
EXTRN	_free_page:NEAR
EXTRN	_schedule:NEAR
EXTRN	_panic:NEAR
EXTRN	_task:BYTE
_DATA	SEGMENT
$SG730	DB	'trying to release non-existent task', 00H
_DATA	ENDS
_TEXT	SEGMENT
_p$ = 8
_release PROC NEAR

; 23   : {

	push	ebp
	mov	ebp, esp

; 24   :   int i;
; 25   : 
; 26   :   if (!p)

	mov	edx, DWORD PTR _p$[ebp]
	test	edx, edx
	je	SHORT $L722

; 27   :     return;
; 28   :   for (i = 1; i < NR_TASKS; i++)	// 扫描任务数组，寻找指定任务。

	mov	ecx, 1
	mov	eax, OFFSET FLAT:_task+4
$L725:

; 29   :     if (task[i] == p)

	cmp	DWORD PTR [eax], edx
	je	SHORT $L879
	add	eax, 4
	inc	ecx
	cmp	eax, OFFSET FLAT:_task+256
	jl	SHORT $L725

; 34   : 		return;
; 35   : 	}
; 36   :   panic ("trying to release non-existent task");	// 指定任务若不存在则死机。

	push	OFFSET FLAT:$SG730
	call	_panic
	add	esp, 4
$L722:

; 37   : }

	pop	ebp
	ret	0
$L879:

; 30   : 	{
; 31   : 		task[i] = NULL;		// 置空该任务项并释放相关内存页。
; 32   : 		free_page ((long) p);

	push	edx
	mov	DWORD PTR _task[ecx*4], 0
	call	_free_page
	add	esp, 4

; 33   : 		schedule ();		// 重新调度。

	call	_schedule

; 37   : }

	pop	ebp
	ret	0
_release ENDP
_TEXT	ENDS
PUBLIC	_sys_kill
EXTRN	_current:DWORD
_TEXT	SEGMENT
_pid$ = 8
_sig$ = 12
_retval$ = -4
_sys_kill PROC NEAR

; 78   : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 79   :   struct task_struct **p = NR_TASKS + task;
; 80   :   int err, retval = 0;
; 81   : 
; 82   :   if (!pid)

	mov	ecx, DWORD PTR _pid$[ebp]
	push	ebx
	xor	eax, eax
	push	esi
	test	ecx, ecx
	push	edi
	mov	DWORD PTR _retval$[ebp], eax
	jne	SHORT $L932

; 83   :     while (--p > &FIRST_TASK)

	mov	edi, DWORD PTR _sig$[ebp]
	mov	ebx, DWORD PTR _current
	mov	esi, OFFSET FLAT:_task+252
$L763:

; 84   : 	{
; 85   : 		if (*p && (*p)->pgrp == current->pid)

	mov	edx, DWORD PTR [esi]
	test	edx, edx
	je	SHORT $L766
	mov	ecx, DWORD PTR [edx+564]
	cmp	ecx, DWORD PTR [ebx+556]
	jne	SHORT $L766

; 86   : 		  if (err = send_sig (sig, *p, 1))

	test	edx, edx
	je	SHORT $L885
	cmp	edi, 1
	jl	SHORT $L885
	cmp	edi, 32					; 00000020H
	jg	SHORT $L885
	lea	ecx, DWORD PTR [edi-1]
	mov	eax, 1
	shl	eax, cl
	mov	ecx, DWORD PTR [edx+12]
	or	ecx, eax
	mov	eax, DWORD PTR _retval$[ebp]
	mov	DWORD PTR [edx+12], ecx
	jmp	SHORT $L766
$L885:

; 87   : 			retval = err;

	mov	eax, -22				; ffffffeaH
	mov	DWORD PTR _retval$[ebp], eax
$L766:
	sub	esi, 4
	cmp	esi, OFFSET FLAT:_task
	ja	SHORT $L763
	pop	edi
	pop	esi
	pop	ebx

; 104  : 			  retval = err;
; 105  :   return retval;
; 106  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L932:

; 88   : 	}
; 89   :   else if (pid > 0)

	jle	SHORT $L768

; 90   :     while (--p > &FIRST_TASK)

	mov	edi, DWORD PTR _sig$[ebp]
	mov	ebx, DWORD PTR _current
	mov	esi, OFFSET FLAT:_task+252
	jmp	SHORT $L770
$L931:
	mov	ecx, DWORD PTR _pid$[ebp]
$L770:

; 91   :     {
; 92   : 	if (*p && (*p)->pid == pid)

	mov	edx, DWORD PTR [esi]
	test	edx, edx
	je	SHORT $L773
	cmp	DWORD PTR [edx+556], ecx
	jne	SHORT $L773

; 93   : 	  if (err = send_sig (sig, *p, 0))

	test	edx, edx
	je	SHORT $L894
	cmp	edi, 1
	jl	SHORT $L894
	cmp	edi, 32					; 00000020H
	jg	SHORT $L894
	mov	cx, WORD PTR [ebx+578]
	cmp	cx, WORD PTR [edx+578]
	je	SHORT $L896
	test	cx, cx
	je	SHORT $L896
	or	eax, -1
	jmp	SHORT $L923
$L896:
	lea	ecx, DWORD PTR [edi-1]
	mov	eax, 1
	shl	eax, cl
	mov	ecx, DWORD PTR [edx+12]
	or	ecx, eax
	mov	eax, DWORD PTR _retval$[ebp]
	mov	DWORD PTR [edx+12], ecx
	jmp	SHORT $L773
$L894:
	mov	eax, -22				; ffffffeaH
$L923:

; 94   : 	    retval = err;

	mov	DWORD PTR _retval$[ebp], eax
$L773:

; 90   :     while (--p > &FIRST_TASK)

	sub	esi, 4
	cmp	esi, OFFSET FLAT:_task
	ja	SHORT $L931
	pop	edi
	pop	esi
	pop	ebx

; 104  : 			  retval = err;
; 105  :   return retval;
; 106  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L768:

; 95   :     }
; 96   :   else if (pid == -1)

	cmp	ecx, -1
	jne	$L778

; 97   :     while (--p > &FIRST_TASK)

	mov	esi, OFFSET FLAT:_task+252
$L777:

; 98   :       if (err = send_sig (sig, *p, 0))

	mov	edx, DWORD PTR [esi]
	test	edx, edx
	je	SHORT $L903
	mov	ecx, DWORD PTR _sig$[ebp]
	cmp	ecx, 1
	jl	SHORT $L903
	cmp	ecx, 32					; 00000020H
	jg	SHORT $L903
	mov	edi, DWORD PTR _current
	mov	bx, WORD PTR [edi+578]
	cmp	bx, WORD PTR [edx+578]
	je	SHORT $L905
	test	bx, bx
	je	SHORT $L905
	or	eax, -1
	jmp	SHORT $L783
$L905:
	dec	ecx
	mov	edi, 1
	shl	edi, cl
	mov	ecx, DWORD PTR [edx+12]

; 101  : 		while (--p > &FIRST_TASK)

	sub	esi, 4
	or	ecx, edi
	cmp	esi, OFFSET FLAT:_task
	mov	DWORD PTR [edx+12], ecx
	jbe	SHORT $L783
$L782:

; 102  : 		  if (*p && (*p)->pgrp == -pid)

	mov	ecx, DWORD PTR [esi]
	test	ecx, ecx
	je	SHORT $L785
	cmp	DWORD PTR [ecx+564], 1
	jne	SHORT $L785

; 103  : 			if (err = send_sig (sig, *p, 0))

	test	ecx, ecx
	je	SHORT $L912
	cmp	bx, WORD PTR [ecx+578]
	je	SHORT $L914
	test	bx, bx
	je	SHORT $L914
	or	eax, -1
	jmp	SHORT $L785

; 98   :       if (err = send_sig (sig, *p, 0))

$L903:
	mov	eax, -22				; ffffffeaH

; 99   : 		retval = err;
; 100  :       else

	jmp	SHORT $L783

; 103  : 			if (err = send_sig (sig, *p, 0))

$L914:
	or	DWORD PTR [ecx+12], edi
	jmp	SHORT $L785
$L912:
	mov	eax, -22				; ffffffeaH
$L785:

; 101  : 		while (--p > &FIRST_TASK)

	sub	esi, 4
	cmp	esi, OFFSET FLAT:_task
	ja	SHORT $L782
$L783:

; 97   :     while (--p > &FIRST_TASK)

	sub	esi, 4
	cmp	esi, OFFSET FLAT:_task
	ja	$L777
$L778:
	pop	edi
	pop	esi
	pop	ebx

; 104  : 			  retval = err;
; 105  :   return retval;
; 106  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_sys_kill ENDP
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

; 86   : 	_asm mov ebx,head

	mov	ebx, DWORD PTR _head$[ebp]

; 87   : 	_asm inc dword ptr [ebx]

	inc	DWORD PTR [ebx]

; 88   : 	_asm and dword ptr [ebx],4095

	and	DWORD PTR [ebx], 4095			; 00000fffH
	pop	ebx

; 89   : }

	pop	ebp
	ret	0
__INC_PIPE ENDP
_TEXT	ENDS
PUBLIC	_switch_to
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

	je	SHORT $l1$512

; 278  : 		xchg ecx,current/* current = task[n]； */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*执行长跳转，造成任务切换 (头大了很长时间，多多包涵)*/
; 280  : 		mov ax, __tmp

	mov	ax, WORD PTR ___tmp$[ebp]

; 281  : 		mov word ptr ds:[lcs],ax

	mov	WORD PTR ds:$lcs$513, ax

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
$lcs$513:

; 287  : lcs:	_emit 0		// cs

	DB	0

; 288  : 		_emit 0

	DB	0

; 289  : // 在任务切换回来后才会继续执行下面的语句。
; 290  : 		cmp last_task_used_math,ecx /* 新任务上次使用过协处理器吗？*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$512

; 292  : 		clts/* 新任务上次使用过协处理器，则清cr0 的TS 标志。*/

	clts
$l1$512:

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
PUBLIC	_do_exit
EXTRN	_iput:NEAR
EXTRN	_free_page_tables:NEAR
EXTRN	_tty_table:BYTE
EXTRN	_sys_close:NEAR
_TEXT	SEGMENT
_code$ = 8
$T939 = -4
$T944 = -4
$T949 = -4
$T954 = -4
_do_exit PROC NEAR

; 132  : {

	push	ebp
	mov	ebp, esp
	push	ecx
	push	ebx
	push	esi
	push	edi

; 136  :   free_page_tables (get_base (current->ldt[1]), get_limit (0x0f));

	mov	DWORD PTR $T939[ebp], 15		; 0000000fH

; 133  :   int i;
; 134  : 
; 135  : // 释放当前进程代码段和数据段所占的内存页(free_page_tables()在mm/memory.c,105 行)。

	mov	eax, DWORD PTR $T939[ebp]

; 136  :   free_page_tables (get_base (current->ldt[1]), get_limit (0x0f));

	lsl	eax, eax
	mov	ecx, eax
	mov	eax, DWORD PTR _current
	add	eax, 728				; 000002d8H
	mov	DWORD PTR $T944[ebp], eax

; 133  :   int i;
; 134  : 
; 135  : // 释放当前进程代码段和数据段所占的内存页(free_page_tables()在mm/memory.c,105 行)。

	mov	ebx, DWORD PTR $T944[ebp]

; 136  :   free_page_tables (get_base (current->ldt[1]), get_limit (0x0f));

	mov	ah, BYTE PTR [ebx+7]

; 137  :   free_page_tables (get_base (current->ldt[2]), get_limit (0x17));

	mov	al, BYTE PTR [ebx+4]

; 138  : // 如果当前进程有子进程，就将子进程的father 置为1(其父进程改为进程1)。如果该子进程已经

	shl	eax, 16					; 00000010H

; 139  : // 处于僵死(ZOMBIE)状态，则向进程1 发送子进程终止信号SIGCHLD。

	mov	ax, WORD PTR [ebx+2]

; 136  :   free_page_tables (get_base (current->ldt[1]), get_limit (0x0f));

	push	ecx
	push	eax
	call	_free_page_tables

; 137  :   free_page_tables (get_base (current->ldt[2]), get_limit (0x17));

	mov	DWORD PTR $T949[ebp], 23		; 00000017H

; 133  :   int i;
; 134  : 
; 135  : // 释放当前进程代码段和数据段所占的内存页(free_page_tables()在mm/memory.c,105 行)。

	mov	eax, DWORD PTR $T949[ebp]

; 136  :   free_page_tables (get_base (current->ldt[1]), get_limit (0x0f));

	lsl	eax, eax

; 137  :   free_page_tables (get_base (current->ldt[2]), get_limit (0x17));

	mov	edx, DWORD PTR _current
	mov	ecx, eax
	add	edx, 736				; 000002e0H
	mov	DWORD PTR $T954[ebp], edx

; 133  :   int i;
; 134  : 
; 135  : // 释放当前进程代码段和数据段所占的内存页(free_page_tables()在mm/memory.c,105 行)。

	mov	ebx, DWORD PTR $T954[ebp]

; 136  :   free_page_tables (get_base (current->ldt[1]), get_limit (0x0f));

	mov	ah, BYTE PTR [ebx+7]

; 137  :   free_page_tables (get_base (current->ldt[2]), get_limit (0x17));

	mov	al, BYTE PTR [ebx+4]

; 138  : // 如果当前进程有子进程，就将子进程的father 置为1(其父进程改为进程1)。如果该子进程已经

	shl	eax, 16					; 00000010H

; 139  : // 处于僵死(ZOMBIE)状态，则向进程1 发送子进程终止信号SIGCHLD。

	mov	ax, WORD PTR [ebx+2]

; 137  :   free_page_tables (get_base (current->ldt[2]), get_limit (0x17));

	push	ecx
	push	eax
	call	_free_page_tables
	mov	ebx, DWORD PTR _current
	mov	edx, DWORD PTR _task+4
	add	esp, 16					; 00000010H
	mov	ecx, OFFSET FLAT:_task
	mov	esi, 1
$L805:

; 140  :   for (i = 0; i < NR_TASKS; i++)
; 141  :     if (task[i] && task[i]->father == current->pid)

	mov	eax, DWORD PTR [ecx]
	test	eax, eax
	je	SHORT $L806
	mov	edi, DWORD PTR [eax+560]
	cmp	edi, DWORD PTR [ebx+556]
	jne	SHORT $L806

; 142  :       {
; 143  : 	task[i]->father = 1;

	mov	DWORD PTR [eax+560], esi

; 144  : 	if (task[i]->state == TASK_ZOMBIE)

	mov	edi, DWORD PTR [eax]
	cmp	edi, 3
	jne	SHORT $L806

; 145  : /* assumption task[1] is always init */
; 146  : 	  (void) send_sig (SIGCHLD, task[1], 1);

	test	edx, edx
	je	SHORT $L806
	or	DWORD PTR [edx+12], 65536		; 00010000H
$L806:
	add	ecx, 4
	cmp	ecx, OFFSET FLAT:_task+256
	jl	SHORT $L805

; 147  :       }
; 148  : // 关闭当前进程打开着的所有文件。
; 149  :   for (i = 0; i < NR_OPEN; i++)

	xor	edi, edi
	mov	esi, 640				; 00000280H
$L811:

; 150  :     if (current->filp[i])

	cmp	DWORD PTR [esi+ebx], 0
	je	SHORT $L812

; 151  :       sys_close (i);

	push	edi
	call	_sys_close
	mov	ebx, DWORD PTR _current
	add	esp, 4
$L812:
	add	esi, 4
	inc	edi
	cmp	esi, 720				; 000002d0H
	jl	SHORT $L811

; 152  : // 对当前进程工作目录pwd、根目录root 以及运行程序的i 节点进行同步操作，并分别置空。
; 153  :   iput (current->pwd);

	mov	eax, DWORD PTR [ebx+624]
	push	eax
	call	_iput

; 154  :   current->pwd = NULL;

	mov	eax, DWORD PTR _current
	xor	edi, edi
	mov	DWORD PTR [eax+624], edi

; 155  :   iput (current->root);

	mov	ecx, DWORD PTR [eax+628]
	push	ecx
	call	_iput

; 156  :   current->root = NULL;

	mov	eax, DWORD PTR _current
	mov	DWORD PTR [eax+628], edi

; 157  :   iput (current->executable);

	mov	edx, DWORD PTR [eax+632]
	push	edx
	call	_iput

; 158  :   current->executable = NULL;

	mov	eax, DWORD PTR _current
	add	esp, 12					; 0000000cH
	mov	DWORD PTR [eax+632], edi

; 159  : // 如果当前进程是领头(leader)进程并且其有控制的终端，则释放该终端。
; 160  :   if (current->leader && current->tty >= 0)

	mov	esi, DWORD PTR [eax+572]
	cmp	esi, edi
	je	SHORT $L815
	mov	edx, DWORD PTR [eax+616]
	cmp	edx, edi
	jl	SHORT $L815

; 161  :     tty_table[current->tty].pgrp = 0;

	mov	ecx, edx
	shl	ecx, 5
	add	ecx, edx
	lea	ecx, DWORD PTR [ecx+ecx*2]
	shl	ecx, 5
	mov	DWORD PTR _tty_table[ecx+36], edi
$L815:

; 162  : // 如果当前进程上次使用过协处理器，则将last_task_used_math 置空。
; 163  :   if (last_task_used_math == current)

	cmp	DWORD PTR _last_task_used_math, eax
	jne	SHORT $L816

; 164  :     last_task_used_math = NULL;

	mov	DWORD PTR _last_task_used_math, edi
$L816:

; 165  : // 如果当前进程是leader 进程，则终止所有相关进程。
; 166  :   if (current->leader)

	cmp	esi, edi
	pop	edi
	pop	esi
	pop	ebx
	je	SHORT $L817

; 167  :     kill_session ();

	call	_kill_session
	mov	eax, DWORD PTR _current
$L817:

; 168  : // 把当前进程置为僵死状态，并设置退出码。
; 169  :   current->state = TASK_ZOMBIE;
; 170  :   current->exit_code = code;

	mov	edx, DWORD PTR _code$[ebp]
	mov	DWORD PTR [eax], 3
	mov	DWORD PTR [eax+532], edx

; 171  : // 通知父进程，也即向父进程发送信号SIGCHLD -- 子进程将停止或终止。
; 172  :   tell_father (current->father);

	mov	eax, DWORD PTR [eax+560]
	push	eax
	call	_tell_father
	add	esp, 4

; 173  :   schedule ();			// 重新调度进程的运行。

	call	_schedule

; 174  :   return (-1);			/* just to suppress warnings */

	or	eax, -1

; 175  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_do_exit ENDP
_kill_session PROC NEAR

; 58   :   struct task_struct **p = NR_TASKS + task;	// 指针*p 首先指向任务数组最末端。
; 59   : 
; 60   : // 对于所有的任务（除任务0 以外），如果其会话等于当前进程的会话就向它发送挂断进程信号。
; 61   :   while (--p > &FIRST_TASK)

	mov	edx, DWORD PTR _current
	push	ebx
	push	edi
	mov	ecx, OFFSET FLAT:_task+252
$L749:

; 62   :   {
; 63   :     if (*p && (*p)->session == current->session)

	mov	eax, DWORD PTR [ecx]
	test	eax, eax
	je	SHORT $L751
	mov	edi, DWORD PTR [eax+568]
	mov	ebx, DWORD PTR [edx+568]
	cmp	edi, ebx
	jne	SHORT $L751

; 64   : 	  (*p)->signal |= 1 << (SIGHUP - 1);	// 发送挂断进程信号。

	or	DWORD PTR [eax+12], 1
$L751:
	sub	ecx, 4
	cmp	ecx, OFFSET FLAT:_task
	ja	SHORT $L749
	pop	edi
	pop	ebx

; 65   :   }
; 66   : }

	ret	0
_kill_session ENDP
_TEXT	ENDS
EXTRN	_printk:NEAR
_DATA	SEGMENT
$SG797	DB	'BAD BAD - no father found', 0aH, 0dH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_pid$ = 8
_tell_father PROC NEAR

; 111  : {

	push	ebp
	mov	ebp, esp
	push	esi

; 112  :   int i;
; 113  : 
; 114  :   if (pid)

	mov	esi, DWORD PTR _pid$[ebp]
	test	esi, esi
	je	SHORT $L794

; 115  :     for (i = 0; i < NR_TASKS; i++)

	xor	edx, edx
	mov	eax, OFFSET FLAT:_task
$L792:

; 116  :     {
; 117  : 		if (!task[i])

	mov	ecx, DWORD PTR [eax]
	test	ecx, ecx
	je	SHORT $L793

; 118  : 		  continue;
; 119  : 		if (task[i]->pid != pid)

	cmp	DWORD PTR [ecx+556], esi
	je	SHORT $L796
$L793:

; 115  :     for (i = 0; i < NR_TASKS; i++)

	add	eax, 4
	inc	edx
	cmp	eax, OFFSET FLAT:_task+256
	jl	SHORT $L792
$L794:

; 122  : 		return;
; 123  :     }
; 124  : /* if we don't find any fathers, we just release ourselves */
; 125  : /* This is not really OK. Must change it to make father 1 */
; 126  :   printk ("BAD BAD - no father found\n\r");

	push	OFFSET FLAT:$SG797
	call	_printk

; 127  :   release (current);		// 如果没有找到父进程，则自己释放。

	mov	eax, DWORD PTR _current
	push	eax
	call	_release
	add	esp, 8
	pop	esi

; 128  : }

	pop	ebp
	ret	0
$L796:

; 120  : 		  continue;
; 121  : 		task[i]->signal |= (1 << (SIGCHLD - 1));

	mov	edx, DWORD PTR _task[edx*4]
	pop	esi
	or	DWORD PTR [edx+12], 65536		; 00010000H

; 128  : }

	pop	ebp
	ret	0
_tell_father ENDP
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
	pop	ebx

; 329  : }

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
	pop	ebx

; 351  : }

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
	pop	ebx

; 382  : //		_asm mov __base,eax 
; 383  : 		} 
; 384  : //	return __base; 
; 385  : }

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

; 8    : //  unsigned register char _v;
; 9    : 
; 10   : // __asm__ ("movb %%fs:%1,%0": "=r" (_v):"m" (*addr));
; 11   :   _asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 12   :   _asm mov al,byte ptr fs:[ebx];

	mov	al, BYTE PTR fs:[ebx]
	pop	ebx

; 13   : //  _asm mov _v,al;
; 14   : //  return _v;
; 15   : }

	pop	ebp
	ret	0
_get_fs_byte ENDP
_TEXT	ENDS
PUBLIC	_sys_exit
_TEXT	SEGMENT
_error_code$ = 8
_sys_exit PROC NEAR

; 179  : {

	push	ebp
	mov	ebp, esp

; 180  :   return do_exit ((error_code & 0xff) << 8);

	xor	eax, eax
	mov	ah, BYTE PTR _error_code$[ebp]
	push	eax
	call	_do_exit
	add	esp, 4

; 181  : }

	pop	ebp
	ret	0
_sys_exit ENDP
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

; 24   : //  unsigned short _v;
; 25   : 
; 26   : //__asm__ ("movw %%fs:%1,%0": "=r" (_v):"m" (*addr));
; 27   :   _asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 28   :   _asm mov ax,word ptr fs:[ebx];

	mov	ax, WORD PTR fs:[ebx]
	pop	ebx

; 29   : //  _asm mov _v,ax;
; 30   : //  return _v;
; 31   : }

	pop	ebp
	ret	0
_get_fs_word ENDP
_TEXT	ENDS
PUBLIC	_sys_waitpid
EXTRN	_verify_area:NEAR
_TEXT	SEGMENT
_pid$ = 8
_stat_addr$ = 12
_options$ = 16
_code$ = 16
_sys_waitpid PROC NEAR

; 194  : {

	push	ebp
	mov	ebp, esp

; 198  :   verify_area (stat_addr, 4);

	mov	eax, DWORD PTR _stat_addr$[ebp]
	push	ebx
	push	esi
	push	edi
	push	4
	push	eax
	call	_verify_area
	mov	esi, DWORD PTR _pid$[ebp]
	mov	ecx, DWORD PTR _current
	add	esp, 8
$repeat$833:

; 199  : repeat:
; 200  :   flag = 0;

	xor	edi, edi

; 201  :   for (p = &LAST_TASK; p > &FIRST_TASK; --p)

	mov	edx, OFFSET FLAT:_task+252
$L993:

; 202  :   {				// 从任务数组末端开始扫描所有任务。
; 203  :       if (!*p || *p == current)	// 跳过空项和本进程项。

	mov	eax, DWORD PTR [edx]
	test	eax, eax
	je	SHORT $L835
	cmp	eax, ecx
	je	SHORT $L835

; 204  : 		continue;
; 205  :       if ((*p)->father != current->pid)	// 如果不是当前进程的子进程则跳过。

	mov	ebx, DWORD PTR [eax+560]
	cmp	ebx, DWORD PTR [ecx+556]
	jne	SHORT $L835

; 206  : 		continue;
; 207  :       if (pid > 0)

	test	esi, esi
	jle	SHORT $L1000

; 208  : 		{			// 如果指定的pid>0，但扫描的进程pid
; 209  : 		  if ((*p)->pid != pid)	// 与之不等，则跳过。

	cmp	DWORD PTR [eax+556], esi
	jne	SHORT $L835

; 210  : 			continue;
; 211  : 		}
; 212  :       else if (!pid)

	jmp	SHORT $L847
$L1000:
	jne	SHORT $L843

; 213  : 		{			// 如果指定的pid=0，但扫描的进程组号
; 214  : 		  if ((*p)->pgrp != current->pgrp)	// 与当前进程的组号不等，则跳过。

	mov	ebx, DWORD PTR [eax+564]
	cmp	ebx, DWORD PTR [ecx+564]
	jne	SHORT $L835

; 215  : 			continue;
; 216  : 		}
; 217  :       else if (pid != -1)

	jmp	SHORT $L847
$L843:
	cmp	esi, -1
	je	SHORT $L847

; 218  : 		{			// 如果指定的pid<-1，但扫描的进程组号
; 219  : 		  if ((*p)->pgrp != -pid)	// 与其绝对值不等，则跳过。

	mov	ebx, esi
	neg	ebx
	cmp	DWORD PTR [eax+564], ebx
	jne	SHORT $L835
$L847:

; 220  : 			continue;
; 221  : 		}
; 222  :     switch ((*p)->state)
; 223  : 	{

	mov	eax, DWORD PTR [eax]
	sub	eax, 3
	je	SHORT $L854
	dec	eax
	je	SHORT $L852

; 237  : 	default:
; 238  : 	  flag = 1;		// 如果子进程不在停止或僵死状态，则flag=1。

	mov	edi, 1

; 239  : 	  continue;

	jmp	SHORT $L835
$L852:

; 224  : 	case TASK_STOPPED:
; 225  : 	  if (!(options & WUNTRACED))

	test	BYTE PTR _options$[ebp], 2
	jne	SHORT $L853
$L835:

; 201  :   for (p = &LAST_TASK; p > &FIRST_TASK; --p)

	sub	edx, 4
	cmp	edx, OFFSET FLAT:_task
	ja	SHORT $L993

; 240  : 	}
; 241  :   }
; 242  :   if (flag)

	test	edi, edi
	je	$L859

; 243  :   {				// 如果子进程没有处于退出或僵死状态，
; 244  : 	  if (options & WNOHANG)	// 并且options = WNOHANG，则立刻返回。

	test	BYTE PTR _options$[ebp], 1
	jne	$L991

; 246  : 	  current->state = TASK_INTERRUPTIBLE;	// 置当前进程为可中断等待状态。

	mov	DWORD PTR [ecx], 1

; 247  : 	  schedule ();		// 重新调度。

	call	_schedule

; 248  : 	  if (!(current->signal &= ~(1 << (SIGCHLD - 1))))	// 又开始执行本进程时，

	mov	ecx, DWORD PTR _current
	mov	eax, DWORD PTR [ecx+12]
	and	eax, -65537				; fffeffffH
	mov	DWORD PTR [ecx+12], eax
	jne	SHORT $L858

; 249  : 		goto repeat;		// 如果进程没有收到除SIGCHLD 的信号，则还是重复处理。

	jmp	$repeat$833
$L853:

; 195  :   int flag, code;
; 196  :   struct task_struct **p;

	mov	ebx, DWORD PTR _stat_addr$[ebp]

; 197  : 

	mov	eax, 127				; 0000007fH

; 198  :   verify_area (stat_addr, 4);

	mov	DWORD PTR fs:[ebx], eax

; 226  : 	    continue;
; 227  : 	  put_fs_long (0x7f, stat_addr);	// 置状态信息为0x7f。
; 228  : 	  return (*p)->pid;	// 退出，返回子进程的进程号。

	mov	ecx, DWORD PTR [edx]
	pop	edi
	pop	esi
	pop	ebx
	mov	eax, DWORD PTR [ecx+556]

; 254  : }

	pop	ebp
	ret	0
$L854:

; 229  : 	case TASK_ZOMBIE:
; 230  : 	  current->cutime += (*p)->utime;	// 更新当前进程的子进程用户

	mov	eax, DWORD PTR [edx]
	mov	edi, DWORD PTR [ecx+600]

; 231  : 	  current->cstime += (*p)->stime;	// 态和核心态运行时间。
; 232  : 	  flag = (*p)->pid;
; 233  : 	  code = (*p)->exit_code;	// 取子进程的退出码。
; 234  : 	  release (*p);		// 释放该子进程。

	push	eax
	mov	edx, DWORD PTR [eax+592]
	add	edi, edx
	mov	edx, DWORD PTR [eax+596]
	mov	DWORD PTR [ecx+600], edi
	mov	esi, DWORD PTR [ecx+604]
	add	esi, edx
	mov	DWORD PTR [ecx+604], esi
	mov	ecx, DWORD PTR [eax+532]
	mov	esi, DWORD PTR [eax+556]
	mov	DWORD PTR _code$[ebp], ecx
	call	_release
	add	esp, 4

; 195  :   int flag, code;
; 196  :   struct task_struct **p;

	mov	ebx, DWORD PTR _stat_addr$[ebp]

; 197  : 

	mov	eax, DWORD PTR _code$[ebp]

; 198  :   verify_area (stat_addr, 4);

	mov	DWORD PTR fs:[ebx], eax

; 235  : 	  put_fs_long (code, stat_addr);	// 置状态信息为退出码值。
; 236  : 	  return flag;		// 退出，返回子进程的pid.

	mov	eax, esi
	pop	edi
	pop	esi
	pop	ebx

; 254  : }

	pop	ebp
	ret	0
$L991:
	pop	edi
	pop	esi

; 245  : 		return 0;

	xor	eax, eax
	pop	ebx

; 254  : }

	pop	ebp
	ret	0
$L858:
	pop	edi
	pop	esi

; 250  : 	  else
; 251  : 		return -EINTR;		// 退出，返回出错码。

	mov	eax, -4					; fffffffcH
	pop	ebx

; 254  : }

	pop	ebp
	ret	0
$L859:
	pop	edi
	pop	esi

; 252  :   }
; 253  :   return -ECHILD;

	mov	eax, -10				; fffffff6H
	pop	ebx

; 254  : }

	pop	ebp
	ret	0
_sys_waitpid ENDP
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

; 40   : //  unsigned long _v;
; 41   : 
; 42   : //__asm__ ("movl %%fs:%1,%0": "=r" (_v):"m" (*addr));
; 43   :   _asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 44   :   _asm mov eax,dword ptr fs:[ebx];

	mov	eax, DWORD PTR fs:[ebx]
	pop	ebx

; 45   : //  _asm mov _v,eax;
; 46   : //  return _v;
; 47   : }

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

; 55   : //  __asm__ ("movb %0,%%fs:%1"::"r" (val), "m" (*addr));
; 56   : 	_asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 57   : 	_asm mov al,val;

	mov	al, BYTE PTR _val$[ebp]

; 58   : 	_asm mov byte ptr fs:[ebx],al;

	mov	BYTE PTR fs:[ebx], al
	pop	ebx

; 59   : }

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

; 67   : //  __asm__ ("movw %0,%%fs:%1"::"r" (val), "m" (*addr));
; 68   : 	_asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 69   : 	_asm mov ax,val;

	mov	ax, WORD PTR _val$[ebp]

; 70   : 	_asm mov word ptr fs:[ebx],ax;

	mov	WORD PTR fs:[ebx], ax
	pop	ebx

; 71   : }

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

; 79   : //  __asm__ ("movl %0,%%fs:%1"::"r" (val), "m" (*addr));
; 80   : 	_asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 81   : 	_asm mov eax,val;

	mov	eax, DWORD PTR _val$[ebp]

; 82   : 	_asm mov dword ptr fs:[ebx],eax;

	mov	DWORD PTR fs:[ebx], eax
	pop	ebx

; 83   : }

	pop	ebp
	ret	0
_put_fs_long ENDP
_TEXT	ENDS
PUBLIC	_get_fs
;	COMDAT _get_fs
_TEXT	SEGMENT
_get_fs	PROC NEAR					; COMDAT

; 97   : //  unsigned short _v;
; 98   : //__asm__ ("mov %%fs,%%ax": "=a" (_v):);
; 99   :   _asm mov ax,fs;

	mov	ax, fs

; 100  : //  _asm mov _v,ax;
; 101  : //  return _v;
; 102  : }

	ret	0
_get_fs	ENDP
_TEXT	ENDS
PUBLIC	_get_ds
;	COMDAT _get_ds
_TEXT	SEGMENT
_get_ds	PROC NEAR					; COMDAT

; 109  : //  unsigned short _v;
; 110  : //__asm__ ("mov %%ds,%%ax": "=a" (_v):);
; 111  :   _asm mov ax,fs;

	mov	ax, fs

; 112  : //  _asm mov _v,ax;
; 113  : //  return _v;
; 114  : }

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

; 121  : //  __asm__ ("mov %0,%%fs"::"a" ((unsigned short) val));
; 122  : 	_asm mov eax,val;

	mov	eax, DWORD PTR _val$[ebp]

; 123  : 	_asm mov fs,ax;

	mov	fs, ax

; 124  : }

	pop	ebp
	ret	0
_set_fs	ENDP
_TEXT	ENDS
END
