	TITLE	..\kernel\sched.c
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
_BSS	SEGMENT PARA USE32 PUBLIC 'BSS'
_BSS	ENDS
_TLS	SEGMENT DWORD USE32 PUBLIC 'TLS'
_TLS	ENDS
;	COMDAT __INC_PIPE
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _ltr
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _lldt
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
;	COMDAT __set_gate
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __set_tssldt_desc
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __outb
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __outb_p
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __inb_p
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
PUBLIC	_task
PUBLIC	_last_task_used_math
PUBLIC	_current
PUBLIC	_sys_getpid
PUBLIC	_sys_getuid
PUBLIC	_sys_alarm
PUBLIC	_sys_pause
PUBLIC	_sys_nice
PUBLIC	_sys_getgid
PUBLIC	_sys_geteuid
PUBLIC	_sys_getegid
PUBLIC	_sys_getppid
PUBLIC	_sys_call_table
PUBLIC	_stack_start
PUBLIC	_current_DOR
EXTRN	_pg_dir:BYTE
EXTRN	_sys_setup:NEAR
EXTRN	_sys_exit:NEAR
EXTRN	_sys_fork:NEAR
EXTRN	_sys_read:NEAR
EXTRN	_sys_write:NEAR
EXTRN	_sys_open:NEAR
EXTRN	_sys_close:NEAR
EXTRN	_sys_waitpid:NEAR
EXTRN	_sys_creat:NEAR
EXTRN	_sys_link:NEAR
EXTRN	_sys_unlink:NEAR
EXTRN	_sys_execve:NEAR
EXTRN	_sys_chdir:NEAR
EXTRN	_sys_time:NEAR
EXTRN	_sys_mknod:NEAR
EXTRN	_sys_chmod:NEAR
EXTRN	_sys_chown:NEAR
EXTRN	_sys_break:NEAR
EXTRN	_sys_stat:NEAR
EXTRN	_sys_lseek:NEAR
EXTRN	_sys_mount:NEAR
EXTRN	_sys_umount:NEAR
EXTRN	_sys_setuid:NEAR
EXTRN	_sys_stime:NEAR
EXTRN	_sys_ptrace:NEAR
EXTRN	_sys_fstat:NEAR
EXTRN	_sys_utime:NEAR
EXTRN	_sys_stty:NEAR
EXTRN	_sys_gtty:NEAR
EXTRN	_sys_access:NEAR
EXTRN	_sys_ftime:NEAR
EXTRN	_sys_sync:NEAR
EXTRN	_sys_kill:NEAR
EXTRN	_sys_rename:NEAR
EXTRN	_sys_mkdir:NEAR
EXTRN	_sys_rmdir:NEAR
EXTRN	_sys_dup:NEAR
EXTRN	_sys_pipe:NEAR
EXTRN	_sys_times:NEAR
EXTRN	_sys_prof:NEAR
EXTRN	_sys_brk:NEAR
EXTRN	_sys_setgid:NEAR
EXTRN	_sys_signal:NEAR
EXTRN	_sys_acct:NEAR
EXTRN	_sys_phys:NEAR
EXTRN	_sys_lock:NEAR
EXTRN	_sys_ioctl:NEAR
EXTRN	_sys_fcntl:NEAR
EXTRN	_sys_mpx:NEAR
EXTRN	_sys_setpgid:NEAR
EXTRN	_sys_ulimit:NEAR
EXTRN	_sys_uname:NEAR
EXTRN	_sys_umask:NEAR
EXTRN	_sys_chroot:NEAR
EXTRN	_sys_ustat:NEAR
EXTRN	_sys_dup2:NEAR
EXTRN	_sys_getpgrp:NEAR
EXTRN	_sys_setsid:NEAR
EXTRN	_sys_sigaction:NEAR
EXTRN	_sys_sgetmask:NEAR
EXTRN	_sys_ssetmask:NEAR
EXTRN	_sys_setreuid:NEAR
EXTRN	_sys_setregid:NEAR
_BSS	SEGMENT
_last_task_used_math DD 01H DUP (?)
_BSS	ENDS
_DATA	SEGMENT
COMM	_jiffies:DWORD
COMM	_startup_time:DWORD
COMM	_user_stack:DWORD:0400H
_DATA	ENDS
_BSS	SEGMENT
_wait_motor DD	04H DUP (?)
_mon_timer DD	04H DUP (?)
_moff_timer DD	04H DUP (?)
_next_timer DD	01H DUP (?)
_BSS	ENDS
_DATA	SEGMENT
_sys_call_table DD FLAT:_sys_setup
	DD	FLAT:_sys_exit
	DD	FLAT:_sys_fork
	DD	FLAT:_sys_read
	DD	FLAT:_sys_write
	DD	FLAT:_sys_open
	DD	FLAT:_sys_close
	DD	FLAT:_sys_waitpid
	DD	FLAT:_sys_creat
	DD	FLAT:_sys_link
	DD	FLAT:_sys_unlink
	DD	FLAT:_sys_execve
	DD	FLAT:_sys_chdir
	DD	FLAT:_sys_time
	DD	FLAT:_sys_mknod
	DD	FLAT:_sys_chmod
	DD	FLAT:_sys_chown
	DD	FLAT:_sys_break
	DD	FLAT:_sys_stat
	DD	FLAT:_sys_lseek
	DD	FLAT:_sys_getpid
	DD	FLAT:_sys_mount
	DD	FLAT:_sys_umount
	DD	FLAT:_sys_setuid
	DD	FLAT:_sys_getuid
	DD	FLAT:_sys_stime
	DD	FLAT:_sys_ptrace
	DD	FLAT:_sys_alarm
	DD	FLAT:_sys_fstat
	DD	FLAT:_sys_pause
	DD	FLAT:_sys_utime
	DD	FLAT:_sys_stty
	DD	FLAT:_sys_gtty
	DD	FLAT:_sys_access
	DD	FLAT:_sys_nice
	DD	FLAT:_sys_ftime
	DD	FLAT:_sys_sync
	DD	FLAT:_sys_kill
	DD	FLAT:_sys_rename
	DD	FLAT:_sys_mkdir
	DD	FLAT:_sys_rmdir
	DD	FLAT:_sys_dup
	DD	FLAT:_sys_pipe
	DD	FLAT:_sys_times
	DD	FLAT:_sys_prof
	DD	FLAT:_sys_brk
	DD	FLAT:_sys_setgid
	DD	FLAT:_sys_getgid
	DD	FLAT:_sys_signal
	DD	FLAT:_sys_geteuid
	DD	FLAT:_sys_getegid
	DD	FLAT:_sys_acct
	DD	FLAT:_sys_phys
	DD	FLAT:_sys_lock
	DD	FLAT:_sys_ioctl
	DD	FLAT:_sys_fcntl
	DD	FLAT:_sys_mpx
	DD	FLAT:_sys_setpgid
	DD	FLAT:_sys_ulimit
	DD	FLAT:_sys_uname
	DD	FLAT:_sys_umask
	DD	FLAT:_sys_chroot
	DD	FLAT:_sys_ustat
	DD	FLAT:_sys_dup2
	DD	FLAT:_sys_getppid
	DD	FLAT:_sys_getpgrp
	DD	FLAT:_sys_setsid
	DD	FLAT:_sys_sigaction
	DD	FLAT:_sys_sgetmask
	DD	FLAT:_sys_ssetmask
	DD	FLAT:_sys_setreuid
	DD	FLAT:_sys_setregid
_init_task DD	00H
	DD	0fH
	DD	0fH
	DD	00H
	DD	00H
	ORG $+12
	ORG $+496
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DD	0ffffffffH
	DD	00H
	DD	00H
	DD	00H
	DW	00H
	DW	00H
	DW	00H
	DW	00H
	DW	00H
	DW	00H
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DW	00H
	ORG $+2
	DD	0ffffffffH
	DW	012H
	ORG $+2
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	ORG $+76
	DD	00H
	DD	00H
	DD	09fH
	DD	0c0fa00H
	DD	09fH
	DD	0c0f200H
	DD	00H
	DD	FLAT:_init_task+4096
	DD	010H
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DD	FLAT:_pg_dir
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DD	017H
	DD	017H
	DD	017H
	DD	017H
	DD	017H
	DD	017H
	DD	028H
	DD	080000000H
	DD	00H
	ORG $+104
	ORG $+3140
_current DD	FLAT:_init_task
_task	DD	FLAT:_init_task
	ORG $+252
	ORG $+4
_stack_start DD	FLAT:_user_stack+4096
	DW	010H
	ORG $+2
_current_DOR DB	0cH
_DATA	ENDS
PUBLIC	_show_task
EXTRN	_printk:NEAR
_DATA	SEGMENT
	ORG $+3
$SG727	DB	'%d: pid=%d, state=%d, ', 00H
	ORG $+1
$SG732	DB	'%d (of %d) chars free in kernel stack', 0aH, 0dH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_nr$ = 8
_p$ = 12
_show_task PROC NEAR

; 30   : {

	push	ebp
	mov	ebp, esp

; 31   : 	int i, j = 4096 - sizeof (struct task_struct);
; 32   : 
; 33   : 	printk ("%d: pid=%d, state=%d, ", nr, p->pid, p->state);

	mov	edx, DWORD PTR _nr$[ebp]
	push	esi
	mov	esi, DWORD PTR _p$[ebp]
	mov	eax, DWORD PTR [esi]
	mov	ecx, DWORD PTR [esi+556]
	push	eax
	push	ecx
	push	edx
	push	OFFSET FLAT:$SG727
	call	_printk
	add	esp, 16					; 00000010H

; 34   : 	i = 0;

	xor	eax, eax
$L730:

; 35   : 	while (i < j && !((char *) (p + 1))[i])	// 检测指定任务数据结构以后等于0 的字节数。

	mov	cl, BYTE PTR [esi+eax+956]
	test	cl, cl
	jne	SHORT $L731

; 36   : 		i++;

	inc	eax
	cmp	eax, 3140				; 00000c44H
	jl	SHORT $L730
$L731:

; 37   : 	printk ("%d (of %d) chars free in kernel stack\n\r", i, j);

	push	3140					; 00000c44H
	push	eax
	push	OFFSET FLAT:$SG732
	call	_printk
	add	esp, 12					; 0000000cH
	pop	esi

; 38   : }

	pop	ebp
	ret	0
_show_task ENDP
_TEXT	ENDS
PUBLIC	_show_stat
_TEXT	SEGMENT
_show_stat PROC NEAR

; 42   : {

	push	esi
	push	edi

; 43   : 	int i;
; 44   : 
; 45   : 	for (i = 0; i < NR_TASKS; i++)// NR_TASKS 是系统能容纳的最大进程（任务）数量（64 个），

	xor	edi, edi
	mov	esi, OFFSET FLAT:_task
$L737:

; 46   : 		if (task[i])		// 定义在include/kernel/sched.h 第4 行。

	mov	eax, DWORD PTR [esi]
	test	eax, eax
	je	SHORT $L738

; 47   : 			show_task (i, task[i]);

	push	eax
	push	edi
	call	_show_task
	add	esp, 8
$L738:
	add	esi, 4
	inc	edi
	cmp	esi, OFFSET FLAT:_task+256
	jl	SHORT $L737
	pop	edi
	pop	esi

; 48   : }

	ret	0
_show_stat ENDP
_TEXT	ENDS
PUBLIC	_math_state_restore
_TEXT	SEGMENT
_tmp$ = -4
_math_state_restore PROC NEAR

; 92   : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 93   : 	struct i387_struct *tmp;
; 94   : 
; 95   : 	if (last_task_used_math == current)	// 如果任务没变则返回(上一个任务就是当前任务)。

	mov	eax, DWORD PTR _last_task_used_math
	mov	ecx, DWORD PTR _current
	cmp	eax, ecx
	push	ebx
	je	SHORT $L765

; 96   : 		return;			// 这里所指的"上一个任务"是刚被交换出去的任务。
; 97   :  // __asm__ ("fwait");		// 在发送协处理器命令之前要先发WAIT 指令。
; 98   : 	_asm fwait;

	fwait

; 99   : 	if (last_task_used_math)

	mov	eax, DWORD PTR _last_task_used_math
	test	eax, eax
	je	SHORT $L763

; 100  : 	{				// 如果上个任务使用了协处理器，则保存其状态。
; 101  : //      __asm__ ("fnsave %0"::"m" (last_task_used_math->tss.i387));
; 102  : 		tmp = &last_task_used_math->tss.i387;

	add	eax, 848				; 00000350H
	mov	DWORD PTR _tmp$[ebp], eax

; 103  : 		_asm mov ebx,tmp

	mov	ebx, DWORD PTR _tmp$[ebp]

; 104  : 		_asm fnsave [ebx];

	fnsave	TBYTE PTR [ebx]

; 100  : 	{				// 如果上个任务使用了协处理器，则保存其状态。
; 101  : //      __asm__ ("fnsave %0"::"m" (last_task_used_math->tss.i387));
; 102  : 		tmp = &last_task_used_math->tss.i387;

$L763:

; 105  : 	}
; 106  : 	last_task_used_math = current;	// 现在，last_task_used_math 指向当前任务，

	mov	eax, DWORD PTR _current
	mov	DWORD PTR _last_task_used_math, eax

; 107  : 									// 以备当前任务被交换出去时使用。
; 108  : 	if (current->used_math)

	cmp	WORD PTR [eax+612], 0
	je	SHORT $L764

; 109  : 	{				// 如果当前任务用过协处理器，则恢复其状态。
; 110  : //      __asm__ ("frstor %0"::"m" (current->tss.i387));
; 111  : 		tmp = &current->tss.i387;

	add	eax, 848				; 00000350H
	mov	DWORD PTR _tmp$[ebp], eax

; 112  : 		_asm mov ebx,tmp

	mov	ebx, DWORD PTR _tmp$[ebp]

; 113  : 		_asm frstor [ebx];

	frstor	TBYTE PTR [ebx]

; 109  : 	{				// 如果当前任务用过协处理器，则恢复其状态。
; 110  : //      __asm__ ("frstor %0"::"m" (current->tss.i387));
; 111  : 		tmp = &current->tss.i387;

	pop	ebx

; 120  : 	}
; 121  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L764:

; 114  : 	}
; 115  : 	else
; 116  : 	{				// 否则的话说明是第一次使用，
; 117  : //      __asm__ ("fninit"::);	// 于是就向协处理器发初始化命令，
; 118  : 		_asm fninit;

	fninit

; 119  : 		current->used_math = 1;	// 并设置使用了协处理器标志。

	mov	ecx, DWORD PTR _current
	mov	WORD PTR [ecx+612], 1
$L765:
	pop	ebx

; 120  : 	}
; 121  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_math_state_restore ENDP
_TEXT	ENDS
PUBLIC	_schedule
PUBLIC	_switch_to
_TEXT	SEGMENT
_schedule PROC NEAR

; 131  : {

	push	esi
	push	edi

; 132  : 	int i, next, c;
; 133  : 	struct task_struct **p;	// 任务结构指针的指针。
; 134  : 
; 135  : /* 检测alarm（进程的报警定时值），唤醒任何已得到信号的可中断任务 */
; 136  : 
; 137  : // 从任务数组中最后一个任务开始检测alarm。
; 138  : 	for (p = &LAST_TASK; p > &FIRST_TASK; --p)

	mov	edx, OFFSET FLAT:_task+252
	mov	esi, 8192				; 00002000H
$L772:

; 139  : 		if (*p)

	mov	eax, DWORD PTR [edx]
	test	eax, eax
	je	SHORT $L773

; 140  : 		{
; 141  : // 如果任务的alarm 时间已经过期(alarm<jiffies),则在信号位图中置SIGALRM 信号，然后清alarm。
; 142  : // jiffies 是系统从开机开始算起的滴答数（10ms/滴答）。定义在sched.h 第139 行。
; 143  : 			if ((*p)->alarm && (*p)->alarm < jiffies)

	mov	ecx, DWORD PTR [eax+588]
	test	ecx, ecx
	je	SHORT $L776
	mov	edi, DWORD PTR _jiffies
	cmp	ecx, edi
	jge	SHORT $L776

; 144  : 			{
; 145  : 				(*p)->signal |= (1 << (SIGALRM - 1));

	mov	ecx, DWORD PTR [eax+12]
	or	ecx, esi
	mov	DWORD PTR [eax+12], ecx

; 146  : 				(*p)->alarm = 0;

	mov	DWORD PTR [eax+588], 0
$L776:

; 147  : 			}
; 148  : // 如果信号位图中除被阻塞的信号外还有其它信号，并且任务处于可中断状态，则置任务为就绪状态。
; 149  : // 其中'~(_BLOCKABLE & (*p)->blocked)'用于忽略被阻塞的信号，但SIGKILL 和SIGSTOP 不能被阻塞。
; 150  : 			if (((*p)->signal & ~(_BLOCKABLE & (*p)->blocked)) &&
; 151  : 					(*p)->state == TASK_INTERRUPTIBLE)

	mov	ecx, DWORD PTR [eax+528]
	mov	edi, DWORD PTR [eax+12]
	and	ecx, -262401				; fffbfeffH
	not	ecx
	test	ecx, edi
	je	SHORT $L773
	cmp	DWORD PTR [eax], 1
	jne	SHORT $L773

; 152  : 				(*p)->state = TASK_RUNNING;	//置为就绪（可执行）状态。

	mov	DWORD PTR [eax], 0
$L773:

; 132  : 	int i, next, c;
; 133  : 	struct task_struct **p;	// 任务结构指针的指针。
; 134  : 
; 135  : /* 检测alarm（进程的报警定时值），唤醒任何已得到信号的可中断任务 */
; 136  : 
; 137  : // 从任务数组中最后一个任务开始检测alarm。
; 138  : 	for (p = &LAST_TASK; p > &FIRST_TASK; --p)

	sub	edx, 4
	cmp	edx, OFFSET FLAT:_task
	ja	SHORT $L772
$L779:

; 158  : 	{
; 159  : 		c = -1;

	or	ecx, -1

; 160  : 		next = 0;

	xor	edi, edi

; 161  : 		i = NR_TASKS;
; 162  : 		p = &task[NR_TASKS];

	mov	edx, OFFSET FLAT:_task+256

; 163  : // 这段代码也是从任务数组的最后一个任务开始循环处理，并跳过不含任务的数组槽。比较每个就绪
; 164  : // 状态任务的counter（任务运行时间的递减滴答计数）值，哪一个值大，运行时间还不长，next 就
; 165  : // 指向哪个的任务号。
; 166  : 		while (--i)

	mov	esi, 63					; 0000003fH
$L782:

; 167  : 		{
; 168  : 			if (!*--p)

	mov	eax, DWORD PTR [edx-4]
	sub	edx, 4
	test	eax, eax
	je	SHORT $L785

; 169  : 				continue;
; 170  : 			if ((*p)->state == TASK_RUNNING && (*p)->counter > c)

	cmp	DWORD PTR [eax], 0
	jne	SHORT $L785
	mov	eax, DWORD PTR [eax+4]
	cmp	eax, ecx
	jle	SHORT $L785

; 171  : 				c = (*p)->counter, next = i;

	mov	ecx, eax
	mov	edi, esi
$L785:

; 163  : // 这段代码也是从任务数组的最后一个任务开始循环处理，并跳过不含任务的数组槽。比较每个就绪
; 164  : // 状态任务的counter（任务运行时间的递减滴答计数）值，哪一个值大，运行时间还不长，next 就
; 165  : // 指向哪个的任务号。
; 166  : 		while (--i)

	dec	esi
	jne	SHORT $L782

; 172  : 		}
; 173  :       // 如果比较得出有counter 值大于0 的结果，则退出124 行开始的循环，执行任务切换（141 行）。
; 174  : 		if (c)

	test	ecx, ecx
	jne	SHORT $L988

; 175  : 			break;
; 176  :       // 否则就根据每个任务的优先权值，更新每一个任务的counter 值，然后回到125 行重新比较。
; 177  :       // counter 值的计算方式为counter = counter /2 + priority。[右边counter=0??]
; 178  : 		for (p = &LAST_TASK; p > &FIRST_TASK; --p)

	mov	eax, OFFSET FLAT:_task+252
$L787:

; 179  : 			if (*p)

	mov	ecx, DWORD PTR [eax]
	test	ecx, ecx
	je	SHORT $L788

; 180  : 				(*p)->counter = ((*p)->counter >> 1) + (*p)->priority;

	mov	edx, DWORD PTR [ecx+4]
	mov	esi, DWORD PTR [ecx+8]
	sar	edx, 1
	add	edx, esi
	mov	DWORD PTR [ecx+4], edx
$L788:
	sub	eax, 4
	cmp	eax, OFFSET FLAT:_task
	ja	SHORT $L787

; 153  : 		}
; 154  : 
; 155  :   /* 这里是调度程序的主要部分 */
; 156  : 
; 157  : 	while (1)

	jmp	SHORT $L779
$L988:

; 181  : 	}
; 182  : 	switch_to (next);		// 切换到任务号为next 的任务，并运行之。

	push	edi
	call	_switch_to
	add	esp, 4
	pop	edi
	pop	esi

; 183  : }

	ret	0
_schedule ENDP
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

	je	SHORT $l1$497

; 278  : 		xchg ecx,current/* current = task[n]； */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*执行长跳转，造成任务切换 (头大了很长时间，多多包涵)*/
; 280  : 		mov ax, __tmp

	mov	ax, WORD PTR ___tmp$[ebp]

; 281  : 		mov word ptr ds:[lcs],ax

	mov	WORD PTR ds:$lcs$498, ax

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
$lcs$498:

; 287  : lcs:	_emit 0		// cs

	DB	0

; 288  : 		_emit 0

	DB	0

; 289  : // 在任务切换回来后才会继续执行下面的语句。
; 290  : 		cmp last_task_used_math,ecx /* 新任务上次使用过协处理器吗？*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$497

; 292  : 		clts/* 新任务上次使用过协处理器，则清cr0 的TS 标志。*/

	clts
$l1$497:

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
_TEXT	SEGMENT
_sys_pause PROC NEAR

; 191  : 	current->state = TASK_INTERRUPTIBLE;

	mov	eax, DWORD PTR _current
	mov	DWORD PTR [eax], 1

; 192  : 	schedule ();

	call	_schedule

; 193  : 	return 0;

	xor	eax, eax

; 194  : }

	ret	0
_sys_pause ENDP
_TEXT	ENDS
PUBLIC	_sleep_on
EXTRN	_panic:NEAR
_DATA	SEGMENT
$SG799	DB	'task[0] trying to sleep', 00H
_DATA	ENDS
_TEXT	SEGMENT
_p$ = 8
_sleep_on PROC NEAR

; 200  : {

	push	ebp
	mov	ebp, esp
	push	esi
	push	edi

; 201  : 	struct task_struct *tmp;
; 202  : 
; 203  : 	// 若指针无效，则退出。（指针所指的对象可以是NULL，但指针本身不会为0)。
; 204  : 	if (!p)

	mov	edi, DWORD PTR _p$[ebp]
	test	edi, edi
	je	SHORT $L800

; 205  : 		return;
; 206  : 	if (current == &(init_task.task))	// 如果当前任务是任务0，则死机(impossible!)。

	mov	eax, DWORD PTR _current
	cmp	eax, OFFSET FLAT:_init_task
	jne	SHORT $L798

; 207  : 		panic ("task[0] trying to sleep");

	push	OFFSET FLAT:$SG799
	call	_panic
	mov	eax, DWORD PTR _current
	add	esp, 4
$L798:

; 208  : 	tmp = *p;			// 让tmp 指向已经在等待队列上的任务(如果有的话)。

	mov	esi, DWORD PTR [edi]

; 209  : 	*p = current;			// 将睡眠队列头的等待指针指向当前任务。

	mov	DWORD PTR [edi], eax

; 210  : 	current->state = TASK_UNINTERRUPTIBLE;	// 将当前任务置为不可中断的等待状态。

	mov	DWORD PTR [eax], 2

; 211  : 	schedule ();			// 重新调度。

	call	_schedule

; 212  : // 只有当这个等待任务被唤醒时，调度程序才又返回到这里，则表示进程已被明确地唤醒。
; 213  : // 既然大家都在等待同样的资源，那么在资源可用时，就有必要唤醒所有等待该资源的进程。该函数
; 214  : // 嵌套调用，也会嵌套唤醒所有等待该资源的进程。然后系统会根据这些进程的优先条件，重新调度
; 215  : // 应该由哪个进程首先使用资源。也即让这些进程竞争上岗。
; 216  : 	if (tmp)			// 若还存在等待的任务，则也将其置为就绪状态（唤醒）。

	test	esi, esi
	je	SHORT $L800

; 217  : 		tmp->state = 0;

	mov	DWORD PTR [esi], 0
$L800:
	pop	edi
	pop	esi

; 218  : }

	pop	ebp
	ret	0
_sleep_on ENDP
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
PUBLIC	_interruptible_sleep_on
_DATA	SEGMENT
$SG807	DB	'task[0] trying to sleep', 00H
_DATA	ENDS
_TEXT	SEGMENT
_p$ = 8
_interruptible_sleep_on PROC NEAR

; 222  : {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	edi

; 223  : 	struct task_struct *tmp;
; 224  : 
; 225  : 	if (!p)

	mov	edi, DWORD PTR _p$[ebp]
	test	edi, edi
	je	SHORT $L810

; 226  : 		return;
; 227  : 	if (current == &(init_task.task))

	mov	eax, DWORD PTR _current
	cmp	eax, OFFSET FLAT:_init_task
	jne	SHORT $L806

; 228  : 		panic ("task[0] trying to sleep");

	push	OFFSET FLAT:$SG807
	call	_panic
	mov	eax, DWORD PTR _current
	add	esp, 4
$L806:

; 229  : 	tmp = *p;

	mov	ebx, DWORD PTR [edi]
	push	esi

; 230  : 	*p = current;

	mov	DWORD PTR [edi], eax

; 231  : repeat:
; 232  : 	current->state = TASK_INTERRUPTIBLE;

	mov	DWORD PTR [eax], 1

; 233  : 	schedule ();

	call	_schedule

; 234  : // 如果等待队列中还有等待任务，并且队列头指针所指向的任务不是当前任务时，则将该等待任务置为
; 235  : // 可运行的就绪状态，并重新执行调度程序。当指针*p 所指向的不是当前任务时，表示在当前任务被放
; 236  : // 入队列后，又有新的任务被插入等待队列中，因此，既然本任务是可中断的，就应该首先执行所有
; 237  : // 其它的等待任务。
; 238  : 	if (*p && *p != current)

	mov	esi, DWORD PTR [edi]
	test	esi, esi
	je	SHORT $L809
$repeat$808:
	mov	eax, DWORD PTR _current
	cmp	esi, eax
	je	SHORT $L809

; 239  : 	{
; 240  : 		(**p).state = 0;

	mov	DWORD PTR [esi], 0
	mov	DWORD PTR [eax], 1
	call	_schedule
	test	esi, esi
	jne	SHORT $repeat$808
$L809:

; 241  : 		goto repeat;
; 242  : 	}
; 243  : // 下面一句代码有误，应该是*p = tmp，让队列头指针指向其余等待任务，否则在当前任务之前插入
; 244  : // 等待队列的任务均被抹掉了。参见图4.3。
; 245  : 	*p = NULL;
; 246  : 	if (tmp)

	test	ebx, ebx
	mov	DWORD PTR [edi], 0
	pop	esi
	je	SHORT $L810

; 247  : 		tmp->state = 0;

	mov	DWORD PTR [ebx], 0
$L810:
	pop	edi
	pop	ebx

; 248  : }

	pop	ebp
	ret	0
_interruptible_sleep_on ENDP
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
PUBLIC	_wake_up
_TEXT	SEGMENT
_p$ = 8
_wake_up PROC NEAR

; 252  : {

	push	ebp
	mov	ebp, esp

; 253  : 	if (p && *p)

	mov	ecx, DWORD PTR _p$[ebp]
	test	ecx, ecx
	je	SHORT $L814
	mov	eax, DWORD PTR [ecx]
	test	eax, eax
	je	SHORT $L814

; 254  : 	{
; 255  : 		(**p).state = 0;		// 置为就绪（可运行）状态。

	mov	DWORD PTR [eax], 0

; 256  : 		*p = NULL;

	mov	DWORD PTR [ecx], 0
$L814:

; 257  : 	}
; 258  : }

	pop	ebp
	ret	0
_wake_up ENDP
_TEXT	ENDS
PUBLIC	_ticks_to_floppy_on
EXTRN	_selected:BYTE
_DATA	SEGMENT
$SG825	DB	'floppy_on: nr>3', 00H
_DATA	ENDS
_TEXT	SEGMENT
_nr$ = 8
_mask$ = -1
$T1019 = -8
_ticks_to_floppy_on PROC NEAR

; 272  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 8

; 274  : 	unsigned char mask = 0x10 << nr;	// 所选软驱对应数字输出寄存器中启动马达比特位。

	mov	ecx, DWORD PTR _nr$[ebp]
	push	ebx
	mov	bl, 16					; 00000010H
	shl	bl, cl

; 276  : 	if (nr > 3)

	cmp	ecx, 3
	jbe	SHORT $L824

; 277  : 		panic ("floppy_on: nr>3");	// 最多4 个软驱。

	push	OFFSET FLAT:$SG825
	call	_panic
	mov	ecx, DWORD PTR _nr$[ebp]
	add	esp, 4
$L824:

; 278  : 	moff_timer[nr] = 10000;	/* 100 s = very big :-) */

	mov	DWORD PTR _moff_timer[ecx*4], 10000	; 00002710H

; 279  : 	cli ();			/* use floppy_off to turn it off */

	cli

; 280  : 	mask |= current_DOR;

	mov	al, BYTE PTR _current_DOR

; 281  : // 如果不是当前软驱，则首先复位其它软驱的选择位，然后置对应软驱选择位。
; 282  : 	if (!selected)

	mov	dl, BYTE PTR _selected
	or	bl, al
	test	dl, dl
	mov	BYTE PTR _mask$[ebp], bl
	jne	SHORT $L826

; 283  : 	{
; 284  : 		mask &= 0xFC;

	and	bl, 252					; 000000fcH

; 285  : 		mask |= nr;

	or	bl, cl
	mov	BYTE PTR _mask$[ebp], bl
$L826:

; 286  : 	}
; 287  : // 如果数字输出寄存器的当前值与要求的值不同，则向FDC 数字输出端口输出新值(mask)。并且如果
; 288  : // 要求启动的马达还没有启动，则置相应软驱的马达启动定时器值(HZ/2 = 0.5 秒或50 个滴答)。
; 289  : // 此后更新当前数字输出寄存器值current_DOR。
; 290  : 	if (mask != current_DOR)

	cmp	bl, al
	je	SHORT $L827

; 291  : 	{
; 292  : 		outb (mask, FD_DOR);

	mov	DWORD PTR $T1019[ebp], 1010		; 000003f2H

; 273  : 	extern unsigned char selected;	// 当前选中的软盘号(kernel/blk_drv/floppy.c,122)。

	mov	dx, WORD PTR $T1019[ebp]

; 274  : 	unsigned char mask = 0x10 << nr;	// 所选软驱对应数字输出寄存器中启动马达比特位。

	mov	al, BYTE PTR _mask$[ebp]

; 275  : 

	out	dx, al

; 293  : 		if ((mask ^ current_DOR) & 0xf0)

	mov	al, BYTE PTR _current_DOR
	xor	al, bl
	test	al, 240					; 000000f0H
	je	SHORT $L830

; 294  : 			mon_timer[nr] = HZ / 2;

	mov	ecx, DWORD PTR _nr$[ebp]
	mov	DWORD PTR _mon_timer[ecx*4], 50		; 00000032H

; 295  : 		else if (mon_timer[nr] < 2)

	jmp	SHORT $L832
$L830:
	mov	edx, DWORD PTR _nr$[ebp]
	mov	eax, 2
	cmp	DWORD PTR _mon_timer[edx*4], eax
	jge	SHORT $L832

; 296  : 			mon_timer[nr] = 2;

	mov	ecx, edx
	mov	DWORD PTR _mon_timer[ecx*4], eax
$L832:

; 297  : 		current_DOR = mask;

	mov	ecx, DWORD PTR _nr$[ebp]
	mov	BYTE PTR _current_DOR, bl
$L827:

; 298  : 	}
; 299  : 	sti ();

	sti

; 300  : 	return mon_timer[nr];

	mov	eax, DWORD PTR _mon_timer[ecx*4]
	pop	ebx

; 301  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_ticks_to_floppy_on ENDP
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
PUBLIC	__set_tssldt_desc
;	COMDAT __set_tssldt_desc
_TEXT	SEGMENT
_n$ = 8
_addr$ = 12
_tp$ = 16
__set_tssldt_desc PROC NEAR				; COMDAT

; 105  : { 

	push	ebp
	mov	ebp, esp
	push	ebx

; 106  : /*	n[0] = 104;
; 107  : 	n[1] = addr;
; 108  : 	n[2] = addr >> 16;
; 109  : 	((char*)n)[7] = ((char*)n)[5];
; 110  : 	((char*)n)[5] = tp;
; 111  : 	((char*)n)[6] = 0;*/
; 112  : 	_asm mov ebx,n

	mov	ebx, DWORD PTR _n$[ebp]

; 113  : 	_asm mov ax,104 

	mov	ax, 104					; 00000068H

; 114  : 	_asm mov word ptr [ebx],ax // 将TSS 长度放入描述符长度域(第0-1 字节)。

	mov	WORD PTR [ebx], ax

; 115  : 	_asm mov eax,addr 

	mov	eax, DWORD PTR _addr$[ebp]

; 116  : 	_asm mov word ptr [ebx+2],ax // 将基地址的低字放入描述符第2-3 字节。

	mov	WORD PTR [ebx+2], ax

; 117  : 	_asm ror eax,16 // 将基地址高字移入ax 中。

	ror	eax, 16					; 00000010H

; 118  : 	_asm mov byte ptr [ebx+4],al // 将基地址高字中低字节移入描述符第4 字节。

	mov	BYTE PTR [ebx+4], al

; 119  : 	_asm mov al,tp

	mov	al, BYTE PTR _tp$[ebp]

; 120  : 	_asm mov byte ptr [ebx+5],al // 将标志类型字节移入描述符的第5 字节。

	mov	BYTE PTR [ebx+5], al

; 121  : 	_asm mov al,0 

	mov	al, 0

; 122  : 	_asm mov byte ptr [ebx+6],al // 描述符的第6 字节置0。

	mov	BYTE PTR [ebx+6], al

; 123  : 	_asm mov byte ptr [ebx+7],ah // 将基地址高字中高字节移入描述符第7 字节。

	mov	BYTE PTR [ebx+7], ah

; 124  : 	_asm ror eax,16 // eax 清零。

	ror	eax, 16					; 00000010H
	pop	ebx

; 125  : }

	pop	ebp
	ret	0
__set_tssldt_desc ENDP
_TEXT	ENDS
PUBLIC	_floppy_on
_TEXT	SEGMENT
_nr$ = 8
_floppy_on PROC NEAR

; 305  : {

	push	ebp
	mov	ebp, esp
	push	esi

; 306  : 	cli ();			// 关中断。

	cli

; 307  : 	while (ticks_to_floppy_on (nr))	// 如果马达启动定时还没到，就一直把当前进程置

	mov	esi, DWORD PTR _nr$[ebp]
	push	esi
	call	_ticks_to_floppy_on
	add	esp, 4
	test	eax, eax
	je	SHORT $L838
	push	edi

; 308  : 		sleep_on (nr + wait_motor);	// 为不可中断睡眠状态并放入等待马达运行的队列中。

	lea	edi, DWORD PTR _wait_motor[esi*4]
$L837:
	push	edi
	call	_sleep_on
	push	esi
	call	_ticks_to_floppy_on
	add	esp, 8
	test	eax, eax
	jne	SHORT $L837
	pop	edi
$L838:

; 309  : 	sti ();			// 开中断。

	sti
	pop	esi

; 310  : }

	pop	ebp
	ret	0
_floppy_on ENDP
_TEXT	ENDS
PUBLIC	_floppy_off
_TEXT	SEGMENT
_nr$ = 8
_floppy_off PROC NEAR

; 314  : {

	push	ebp
	mov	ebp, esp

; 315  : 	moff_timer[nr] = 3 * HZ;

	mov	eax, DWORD PTR _nr$[ebp]
	mov	DWORD PTR _moff_timer[eax*4], 300	; 0000012cH

; 316  : }

	pop	ebp
	ret	0
_floppy_off ENDP
_TEXT	ENDS
PUBLIC	_do_floppy_timer
_TEXT	SEGMENT
$T1030 = -4
_do_floppy_timer PROC NEAR

; 322  : {

	push	ebp
	mov	ebp, esp
	push	ecx
	push	ebx
	push	esi

; 324  : 	unsigned char mask = 0x10;

	mov	bl, 16					; 00000010H

; 326  : 	for (i = 0; i < 4; i++, mask <<= 1)

	xor	esi, esi
$L847:

; 327  : 	{
; 328  : 		if (!(mask & current_DOR))	// 如果不是DOR 指定的马达则跳过。

	test	BYTE PTR _current_DOR, bl
	je	SHORT $L848

; 329  : 			continue;
; 330  : 		if (mon_timer[i])

	mov	eax, DWORD PTR _mon_timer[esi]
	test	eax, eax
	je	SHORT $L851

; 331  : 		{
; 332  : 			if (!--mon_timer[i])

	dec	eax
	test	eax, eax
	mov	DWORD PTR _mon_timer[esi], eax
	jne	SHORT $L848

; 333  : 				wake_up (i + wait_motor);	// 如果马达启动定时到则唤醒进程。

	lea	eax, DWORD PTR _wait_motor[esi]
	push	eax
	call	_wake_up
	add	esp, 4

; 334  : 		}
; 335  : 		else if (!moff_timer[i])

	jmp	SHORT $L848
$L851:
	mov	eax, DWORD PTR _moff_timer[esi]
	test	eax, eax
	jne	SHORT $L854

; 336  : 		{			// 如果马达停转定时到则
; 337  : 			current_DOR &= ~mask;	// 复位相应马达启动位，并

	mov	al, BYTE PTR _current_DOR
	mov	cl, bl
	not	cl
	and	al, cl

; 338  : 			outb (current_DOR, FD_DOR);	// 更新数字输出寄存器。

	mov	DWORD PTR $T1030[ebp], 1010		; 000003f2H
	mov	BYTE PTR _current_DOR, al

; 323  : 	int i;

	mov	dx, WORD PTR $T1030[ebp]

; 324  : 	unsigned char mask = 0x10;

	mov	al, BYTE PTR _current_DOR

; 325  : 

	out	dx, al

; 339  : 		}
; 340  : 		else

	jmp	SHORT $L848
$L854:

; 341  : 			moff_timer[i]--;	// 马达停转计时递减。

	dec	eax
	mov	DWORD PTR _moff_timer[esi], eax
$L848:
	add	esi, 4
	shl	bl, 1
	cmp	esi, 16					; 00000010H
	jl	SHORT $L847
	pop	esi
	pop	ebx

; 342  : 	}
; 343  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_do_floppy_timer ENDP
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
PUBLIC	_add_timer
_BSS	SEGMENT
_timer_list DB	0300H DUP (?)
_BSS	ENDS
_DATA	SEGMENT
$SG878	DB	'No more time requests free', 00H
_DATA	ENDS
_TEXT	SEGMENT
_jiffies$ = 8
_fn$ = 12
_add_timer PROC NEAR

; 359  : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 360  : 	struct timer_list *p;
; 361  : 
; 362  : 	// 如果定时处理程序指针为空，则退出。
; 363  : 	if (!fn)

	mov	ebx, DWORD PTR _fn$[ebp]
	test	ebx, ebx
	je	$L868
	push	esi
	push	edi

; 364  : 		return;
; 365  : 	cli ();

	cli

; 366  : 	// 如果定时值<=0，则立刻调用其处理程序。并且该定时器不加入链表中。
; 367  : 	if (jiffies <= 0)

	mov	edi, DWORD PTR _jiffies$[ebp]
	test	edi, edi
	jg	SHORT $L871

; 368  : 		(fn) ();

	call	ebx

; 369  : 	else

	jmp	SHORT $L881
$L871:

; 370  : 	{
; 371  : 		// 从定时器数组中，找一个空闲项。
; 372  : 		for (p = timer_list; p < timer_list + TIME_REQUESTS; p++)

	mov	esi, OFFSET FLAT:_timer_list
$L873:

; 373  : 			if (!p->fn)

	mov	eax, DWORD PTR [esi+4]
	test	eax, eax
	je	SHORT $L1038
	add	esi, 12					; 0000000cH
	cmp	esi, OFFSET FLAT:_timer_list+768
	jb	SHORT $L873

; 374  : 				break;
; 375  : 		// 如果已经用完了定时器数组，则系统崩溃?。
; 376  : 		if (p >= timer_list + TIME_REQUESTS)

	jmp	SHORT $L1041
$L1038:
	cmp	esi, OFFSET FLAT:_timer_list+768
	jb	SHORT $L877
$L1041:

; 377  : 			panic ("No more time requests free");

	push	OFFSET FLAT:$SG878
	call	_panic
	add	esp, 4
$L877:

; 378  : 		// 向定时器数据结构填入相应信息。并链入链表头
; 379  : 		p->fn = fn;
; 380  : 		p->jiffies = jiffies;
; 381  : 		p->next = next_timer;

	mov	eax, DWORD PTR _next_timer
	mov	DWORD PTR [esi+4], ebx
	mov	DWORD PTR [esi], edi
	mov	DWORD PTR [esi+8], eax

; 382  : 		next_timer = p;
; 383  : // 链表项按定时值从小到大排序。在排序时减去排在前面需要的滴答数，这样在处理定时器时只要
; 384  : // 查看链表头的第一项的定时是否到期即可。[[?? 这段程序好象没有考虑周全。如果新插入的定时
; 385  : // 器值 < 原来头一个定时器值时，也应该将所有后面的定时值均减去新的第1 个的定时值。]]
; 386  : 		while (p->next && p->next->jiffies < p->jiffies)

	test	eax, eax
	mov	DWORD PTR _next_timer, esi
	je	SHORT $L881
$L880:
	mov	ecx, DWORD PTR [eax]
	mov	eax, DWORD PTR [esi]
	cmp	ecx, eax
	jge	SHORT $L881

; 387  : 		{
; 388  : 			p->jiffies -= p->next->jiffies;

	sub	eax, ecx
	mov	DWORD PTR [esi], eax

; 389  : 			fn = p->fn;
; 390  : 			p->fn = p->next->fn;

	mov	ecx, DWORD PTR [esi+8]
	mov	eax, DWORD PTR [esi+4]
	mov	edx, DWORD PTR [ecx+4]
	mov	DWORD PTR [esi+4], edx

; 391  : 			p->next->fn = fn;

	mov	ecx, DWORD PTR [esi+8]
	mov	DWORD PTR [ecx+4], eax

; 392  : 			jiffies = p->jiffies;
; 393  : 			p->jiffies = p->next->jiffies;

	mov	edx, DWORD PTR [esi+8]
	mov	eax, DWORD PTR [esi]
	mov	ecx, DWORD PTR [edx]
	mov	DWORD PTR [esi], ecx

; 394  : 			p->next->jiffies = jiffies;

	mov	edx, DWORD PTR [esi+8]
	mov	DWORD PTR [edx], eax

; 395  : 			p = p->next;

	mov	esi, DWORD PTR [esi+8]
	mov	eax, DWORD PTR [esi+8]
	test	eax, eax
	jne	SHORT $L880
$L881:

; 396  : 		}
; 397  : 	}
; 398  : 	sti ();

	sti
	pop	edi
	pop	esi
$L868:
	pop	ebx

; 399  : }

	pop	ebp
	ret	0
_add_timer ENDP
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
PUBLIC	_do_timer
EXTRN	_sysbeepstop:NEAR
EXTRN	_beepcount:DWORD
_TEXT	SEGMENT
_cpl$ = 8
_do_timer PROC NEAR

; 405  : {

	push	ebp
	mov	ebp, esp

; 406  : 	extern int beepcount;		// 扬声器发声时间滴答数(kernel/chr_drv/console.c,697)
; 407  : 	extern void sysbeepstop (void);	// 关闭扬声器(kernel/chr_drv/console.c,691)
; 408  : 
; 409  :   // 如果发声计数次数到，则关闭发声。(向0x61 口发送命令，复位位0 和1。位0 控制8253
; 410  :   // 计数器2 的工作，位1 控制扬声器)。
; 411  : 	if (beepcount)

	mov	eax, DWORD PTR _beepcount
	test	eax, eax
	je	SHORT $L890

; 412  : 		if (!--beepcount)

	dec	eax
	mov	DWORD PTR _beepcount, eax
	jne	SHORT $L890

; 413  : 			sysbeepstop ();

	call	_sysbeepstop
$L890:

; 414  : 
; 415  :   // 如果当前特权级(cpl)为0（最高，表示是内核程序在工作），则将超级用户运行时间stime 递增；
; 416  :   // 如果cpl > 0，则表示是一般用户程序在工作，增加utime。
; 417  : 	if (cpl)
; 418  : 		current->utime++;

	mov	ecx, DWORD PTR _current
	push	edi
	mov	edi, DWORD PTR _cpl$[ebp]
	test	edi, edi
	je	SHORT $L891
	inc	DWORD PTR [ecx+592]

; 419  : 	else

	jmp	SHORT $L892
$L891:

; 420  : 		current->stime++;

	inc	DWORD PTR [ecx+596]
$L892:

; 421  : 
; 422  : // 如果有用户的定时器存在，则将链表第1 个定时器的值减1。如果已等于0，则调用相应的处理
; 423  : // 程序，并将该处理程序指针置为空。然后去掉该项定时器。
; 424  : 	if (next_timer)

	mov	eax, DWORD PTR _next_timer
	test	eax, eax
	je	SHORT $L896

; 425  : 	{				// next_timer 是定时器链表的头指针(见270 行)。
; 426  : 		next_timer->jiffies--;

	dec	DWORD PTR [eax]
$L895:

; 427  : 		while (next_timer && next_timer->jiffies <= 0)

	cmp	DWORD PTR [eax], 0
	jg	SHORT $L896

; 428  : 		{
; 429  : 			void (*fn) ();	// 这里插入了一个函数指针定义！！！??
; 430  : 
; 431  : 			fn = next_timer->fn;

	mov	ecx, DWORD PTR [eax+4]

; 432  : 			next_timer->fn = NULL;

	mov	DWORD PTR [eax+4], 0

; 433  : 			next_timer = next_timer->next;

	mov	eax, DWORD PTR [eax+8]
	mov	DWORD PTR _next_timer, eax

; 434  : 			(fn) ();		// 调用处理函数。

	call	ecx
	mov	eax, DWORD PTR _next_timer
	mov	ecx, DWORD PTR _current
	test	eax, eax
	jne	SHORT $L895
$L896:

; 435  : 		}
; 436  : 	}
; 437  : // 如果当前软盘控制器FDC 的数字输出寄存器中马达启动位有置位的，则执行软盘定时程序(245 行)。
; 438  : 	if (current_DOR & 0xf0)

	test	BYTE PTR _current_DOR, 240		; 000000f0H
	je	SHORT $L898

; 439  : 		do_floppy_timer ();

	call	_do_floppy_timer
	mov	ecx, DWORD PTR _current
$L898:

; 440  : 	if ((--current->counter) > 0)

	mov	edx, DWORD PTR [ecx+4]
	dec	edx
	mov	eax, edx
	mov	DWORD PTR [ecx+4], edx
	test	eax, eax
	jg	SHORT $L885

; 441  : 		return;			// 如果进程运行时间还没完，则退出。
; 442  : 	current->counter = 0;
; 443  : 	if (!cpl)

	test	edi, edi
	mov	DWORD PTR [ecx+4], 0
	je	SHORT $L885

; 444  : 		return;			// 对于超级用户程序，不依赖counter 值进行调度。
; 445  : 	schedule ();

	call	_schedule
$L885:
	pop	edi

; 446  : }

	pop	ebp
	ret	0
_do_timer ENDP
_seconds$ = 8
_sys_alarm PROC NEAR

; 451  : {

	push	ebp
	mov	ebp, esp
	push	esi

; 452  : 	int old = current->alarm;

	mov	esi, DWORD PTR _current
	mov	eax, DWORD PTR [esi+588]

; 453  : 
; 454  : 	if (old)

	test	eax, eax
	je	SHORT $L905

; 455  : 		old = (old - jiffies) / HZ;

	mov	edx, DWORD PTR _jiffies
	mov	ecx, eax
	sub	ecx, edx
	mov	eax, 1374389535				; 51eb851fH
	imul	ecx
	sar	edx, 5
	mov	eax, edx
	shr	eax, 31					; 0000001fH
	add	edx, eax
	mov	eax, edx
$L905:

; 456  : 	current->alarm = (seconds > 0) ? (jiffies + HZ * seconds) : 0;

	mov	ecx, DWORD PTR _seconds$[ebp]
	test	ecx, ecx
	jle	SHORT $L1057
	lea	ecx, DWORD PTR [ecx+ecx*4]
	lea	ecx, DWORD PTR [ecx+ecx*4]
	mov	edx, DWORD PTR _jiffies
	lea	ecx, DWORD PTR [edx+ecx*4]
	mov	DWORD PTR [esi+588], ecx
	pop	esi

; 457  : 	return (old);
; 458  : }

	pop	ebp
	ret	0
$L1057:

; 456  : 	current->alarm = (seconds > 0) ? (jiffies + HZ * seconds) : 0;

	xor	ecx, ecx
	mov	DWORD PTR [esi+588], ecx
	pop	esi

; 457  : 	return (old);
; 458  : }

	pop	ebp
	ret	0
_sys_alarm ENDP
_sys_getpid PROC NEAR

; 463  : 	return current->pid;

	mov	eax, DWORD PTR _current
	mov	eax, DWORD PTR [eax+556]

; 464  : }

	ret	0
_sys_getpid ENDP
_sys_getppid PROC NEAR

; 469  : 	return current->father;

	mov	eax, DWORD PTR _current
	mov	eax, DWORD PTR [eax+560]

; 470  : }

	ret	0
_sys_getppid ENDP
_sys_getuid PROC NEAR

; 475  : 	return current->uid;

	mov	ecx, DWORD PTR _current
	xor	eax, eax
	mov	ax, WORD PTR [ecx+576]

; 476  : }

	ret	0
_sys_getuid ENDP
_sys_geteuid PROC NEAR

; 481  : 	return current->euid;

	mov	ecx, DWORD PTR _current
	xor	eax, eax
	mov	ax, WORD PTR [ecx+578]

; 482  : }

	ret	0
_sys_geteuid ENDP
_sys_getgid PROC NEAR

; 487  : 	return current->gid;

	mov	ecx, DWORD PTR _current
	xor	eax, eax
	mov	ax, WORD PTR [ecx+582]

; 488  : }

	ret	0
_sys_getgid ENDP
_sys_getegid PROC NEAR

; 493  : 	return current->egid;

	mov	ecx, DWORD PTR _current
	xor	eax, eax
	mov	ax, WORD PTR [ecx+584]

; 494  : }

	ret	0
_sys_getegid ENDP
_increment$ = 8
_sys_nice PROC NEAR

; 499  : {

	push	ebp
	mov	ebp, esp

; 500  : 	if (current->priority - increment > 0)

	mov	ecx, DWORD PTR _current
	mov	edx, DWORD PTR _increment$[ebp]
	mov	eax, DWORD PTR [ecx+8]
	sub	eax, edx
	test	eax, eax
	jle	SHORT $L1067

; 501  : 		current->priority -= increment;

	mov	DWORD PTR [ecx+8], eax
$L1067:

; 502  : 	return 0;

	xor	eax, eax

; 503  : }

	pop	ebp
	ret	0
_sys_nice ENDP
_TEXT	ENDS
PUBLIC	_sched_init
EXTRN	_idt:BYTE
EXTRN	_gdt:BYTE
EXTRN	_timer_interrupt:NEAR
EXTRN	_system_call:NEAR
_DATA	SEGMENT
	ORG $+1
$SG928	DB	'Struct sigaction MUST be 16 bytes', 00H
_DATA	ENDS
_TEXT	SEGMENT
$T1072 = -8
$T1076 = -8
$T1080 = -8
$T1084 = -8
$T1090 = -1
$T1091 = -8
$T1097 = -1
$T1098 = -8
$T1102 = -1
$T1103 = -8
$T1113 = -8
$T1118 = -1
$T1119 = -8
_sched_init PROC NEAR

; 507  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 8
	push	ebx
	push	edi

; 514  : 	set_tss_desc (gdt + FIRST_TSS_ENTRY, &(init_task.task.tss));

	mov	DWORD PTR $T1072[ebp], OFFSET FLAT:_gdt+32
	mov	ebx, DWORD PTR $T1072[ebp]

; 515  : 	set_ldt_desc (gdt + FIRST_LDT_ENTRY, &(init_task.task.ldt));

	mov	ax, 104					; 00000068H

; 516  : // 清任务数组和描述符表项（注意i=1 开始，所以初始任务的描述符还在）。

	mov	WORD PTR [ebx], ax

; 517  : 	p = gdt + 2 + FIRST_TSS_ENTRY;

	mov	eax, OFFSET FLAT:_init_task+744

; 518  : 	for (i = 1; i < NR_TASKS; i++)

	mov	WORD PTR [ebx+2], ax

; 519  : 	{

	ror	eax, 16					; 00000010H

; 520  : 		task[i] = NULL;

	mov	BYTE PTR [ebx+4], al

; 521  : 		p->a = p->b = 0;

	mov	al, -119				; ffffff89H

; 522  : 		p++;

	mov	BYTE PTR [ebx+5], al

; 523  : 		p->a = p->b = 0;

	mov	al, 0

; 524  : 		p++;

	mov	BYTE PTR [ebx+6], al

; 525  : 	}

	mov	BYTE PTR [ebx+7], ah

; 526  : /* 清除标志寄存器中的位NT，这样以后就不会有麻烦 */

	ror	eax, 16					; 00000010H

; 515  : 	set_ldt_desc (gdt + FIRST_LDT_ENTRY, &(init_task.task.ldt));

	mov	DWORD PTR $T1076[ebp], OFFSET FLAT:_gdt+40

; 514  : 	set_tss_desc (gdt + FIRST_TSS_ENTRY, &(init_task.task.tss));

	mov	ebx, DWORD PTR $T1076[ebp]

; 515  : 	set_ldt_desc (gdt + FIRST_LDT_ENTRY, &(init_task.task.ldt));

	mov	ax, 104					; 00000068H

; 516  : // 清任务数组和描述符表项（注意i=1 开始，所以初始任务的描述符还在）。

	mov	WORD PTR [ebx], ax

; 517  : 	p = gdt + 2 + FIRST_TSS_ENTRY;

	mov	eax, OFFSET FLAT:_init_task+720

; 518  : 	for (i = 1; i < NR_TASKS; i++)

	mov	WORD PTR [ebx+2], ax

; 519  : 	{

	ror	eax, 16					; 00000010H

; 520  : 		task[i] = NULL;

	mov	BYTE PTR [ebx+4], al

; 521  : 		p->a = p->b = 0;

	mov	al, -126				; ffffff82H

; 522  : 		p++;

	mov	BYTE PTR [ebx+5], al

; 523  : 		p->a = p->b = 0;

	mov	al, 0

; 524  : 		p++;

	mov	BYTE PTR [ebx+6], al

; 525  : 	}

	mov	BYTE PTR [ebx+7], ah

; 526  : /* 清除标志寄存器中的位NT，这样以后就不会有麻烦 */

	ror	eax, 16					; 00000010H

; 520  : 		task[i] = NULL;

	mov	ecx, 63					; 0000003fH
	xor	eax, eax
	mov	edi, OFFSET FLAT:_task+4
	mov	edx, OFFSET FLAT:_gdt+48
	rep stosd
	mov	eax, 63					; 0000003fH
	xor	ecx, ecx
$L935:

; 521  : 		p->a = p->b = 0;

	mov	DWORD PTR [edx+4], ecx
	mov	DWORD PTR [edx], ecx

; 522  : 		p++;

	add	edx, 8

; 523  : 		p->a = p->b = 0;

	mov	DWORD PTR [edx+4], ecx
	mov	DWORD PTR [edx], ecx

; 524  : 		p++;

	add	edx, 8
	dec	eax
	jne	SHORT $L935

; 527  : // NT 标志用于控制程序的递归调用(Nested Task)。当NT 置位时，那么当前中断任务执行
; 528  : // iret 指令时就会引起任务切换。NT 指出TSS 中的back_link 字段是否有效。
; 529  : //  __asm__ ("pushfl ; andl $0xffffbfff,(%esp) ; popfl");	// 复位NT 标志。
; 530  : 	_asm pushfd; _asm and dword ptr ss:[esp],0xffffbfff; _asm popfd;

	pushfd

; 531  : 	ltr (0);			// 将任务0 的TSS 加载到任务寄存器tr。

	mov	DWORD PTR $T1080[ebp], 32		; 00000020H

; 510  : 

	ltr	WORD PTR $T1080[ebp]

; 532  : 	lldt (0);			// 将局部描述符表加载到局部描述符表寄存器。

	mov	DWORD PTR $T1084[ebp], 40		; 00000028H

; 510  : 

	lldt	WORD PTR $T1084[ebp]

; 533  : // 注意！！是将GDT 中相应LDT 描述符的选择符加载到ldtr。只明确加载这一次，以后新任务
; 534  : // LDT 的加载，是CPU 根据TSS 中的LDT 项自动加载。
; 535  : // 下面代码用于初始化8253 定时器。
; 536  : 	outb_p (0x36, 0x43);		/* binary, mode 3, LSB/MSB, ch 0 */

	mov	DWORD PTR $T1091[ebp], 67		; 00000043H
	mov	BYTE PTR $T1090[ebp], 54		; 00000036H

; 508  : 	int i;

	mov	al, BYTE PTR $T1090[ebp]

; 509  : 	struct desc_struct *p;	// 描述符表结构指针。

	mov	dx, WORD PTR $T1091[ebp]

; 510  : 

	out	dx, al

; 511  : 	if (sizeof (struct sigaction) != 16)	// sigaction 是存放有关信号状态的结构。

	jmp	SHORT $l1$1088
$l1$1088:

; 512  : 		panic ("Struct sigaction MUST be 16 bytes");

	jmp	SHORT $l2$1089
$l2$1089:

; 537  : 	outb_p (LATCH & 0xff, 0x40);	/* LSB */// 定时值低字节。

	mov	ecx, 64					; 00000040H
	mov	BYTE PTR $T1097[ebp], 155		; 0000009bH
	mov	DWORD PTR $T1098[ebp], ecx

; 508  : 	int i;

	mov	al, BYTE PTR $T1097[ebp]

; 509  : 	struct desc_struct *p;	// 描述符表结构指针。

	mov	dx, WORD PTR $T1098[ebp]

; 510  : 

	out	dx, al

; 511  : 	if (sizeof (struct sigaction) != 16)	// sigaction 是存放有关信号状态的结构。

	jmp	SHORT $l1$1095
$l1$1095:

; 512  : 		panic ("Struct sigaction MUST be 16 bytes");

	jmp	SHORT $l2$1096
$l2$1096:

; 538  : 	outb (LATCH >> 8, 0x40);	/* MSB */// 定时值高字节。

	mov	DWORD PTR $T1103[ebp], ecx
	mov	BYTE PTR $T1102[ebp], 46		; 0000002eH

; 508  : 	int i;

	mov	dx, WORD PTR $T1103[ebp]

; 509  : 	struct desc_struct *p;	// 描述符表结构指针。

	mov	al, BYTE PTR $T1102[ebp]

; 510  : 

	out	dx, al

; 539  :   // 设置时钟中断处理程序句柄（设置时钟中断门）。
; 540  : 	set_intr_gate (0x20, &timer_interrupt);

	mov	ecx, OFFSET FLAT:_timer_interrupt
	mov	eax, OFFSET FLAT:_timer_interrupt
	and	ecx, -65536				; ffff0000H
	and	eax, 65535				; 0000ffffH
	add	ecx, 36352				; 00008e00H
	add	eax, 524288				; 00080000H
	mov	DWORD PTR _idt+260, ecx

; 541  :   // 修改中断控制器屏蔽码，允许时钟中断。
; 542  : 	outb (inb_p (0x21) & ~0x01, 0x21);

	mov	ecx, 33					; 00000021H
	mov	DWORD PTR _idt+256, eax
	mov	DWORD PTR $T1113[ebp], ecx

; 510  : 

	mov	dx, WORD PTR $T1113[ebp]

; 511  : 	if (sizeof (struct sigaction) != 16)	// sigaction 是存放有关信号状态的结构。

	in	al, dx

; 513  : // 设置初始任务（任务0）的任务状态段描述符和局部数据表描述符(include/asm/system.h,65)。

	jmp	SHORT $l1$1111
$l1$1111:

; 514  : 	set_tss_desc (gdt + FIRST_TSS_ENTRY, &(init_task.task.tss));

	jmp	SHORT $l2$1112
$l2$1112:

; 541  :   // 修改中断控制器屏蔽码，允许时钟中断。
; 542  : 	outb (inb_p (0x21) & ~0x01, 0x21);

	and	al, 254					; 000000feH
	mov	DWORD PTR $T1119[ebp], ecx
	mov	BYTE PTR $T1118[ebp], al

; 508  : 	int i;

	mov	dx, WORD PTR $T1119[ebp]

; 509  : 	struct desc_struct *p;	// 描述符表结构指针。

	mov	al, BYTE PTR $T1118[ebp]

; 510  : 

	out	dx, al

; 543  :   // 设置系统调用中断门。
; 544  : 	set_system_gate (0x80, &system_call);

	mov	edx, OFFSET FLAT:_system_call
	mov	eax, OFFSET FLAT:_system_call
	and	edx, 65535				; 0000ffffH
	and	eax, -65536				; ffff0000H
	add	edx, 524288				; 00080000H
	add	eax, 61184				; 0000ef00H

; 545  : }

	pop	edi
	mov	DWORD PTR _idt+1024, edx
	mov	DWORD PTR _idt+1028, eax
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
_sched_init ENDP
_TEXT	ENDS
END
