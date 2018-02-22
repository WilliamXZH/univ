	TITLE	..\kernel\sys.c
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
_DATA	SEGMENT
_?thisname@?1??sys_uname@@9@9 DB 'linux .0', 00H
	DB	'nodename', 00H
	DB	'release ', 00H
	DB	'version ', 00H
	DB	'machine ', 00H
_DATA	ENDS
PUBLIC	_sys_ftime
_TEXT	SEGMENT
_sys_ftime PROC NEAR

; 21   : 	return -ENOSYS;

	mov	eax, -38				; ffffffdaH

; 22   : }

	ret	0
_sys_ftime ENDP
_TEXT	ENDS
PUBLIC	_sys_break
_TEXT	SEGMENT
_sys_break PROC NEAR

; 27   : 	return -ENOSYS;

	mov	eax, -38				; ffffffdaH

; 28   : }

	ret	0
_sys_break ENDP
_TEXT	ENDS
PUBLIC	_sys_ptrace
_TEXT	SEGMENT
_sys_ptrace PROC NEAR

; 33   : 	return -ENOSYS;

	mov	eax, -38				; ffffffdaH

; 34   : }

	ret	0
_sys_ptrace ENDP
_TEXT	ENDS
PUBLIC	_sys_stty
_TEXT	SEGMENT
_sys_stty PROC NEAR

; 39   : 	return -ENOSYS;

	mov	eax, -38				; ffffffdaH

; 40   : }

	ret	0
_sys_stty ENDP
_TEXT	ENDS
PUBLIC	_sys_gtty
_TEXT	SEGMENT
_sys_gtty PROC NEAR

; 45   : 	return -ENOSYS;

	mov	eax, -38				; ffffffdaH

; 46   : }

	ret	0
_sys_gtty ENDP
_TEXT	ENDS
PUBLIC	_sys_rename
_TEXT	SEGMENT
_sys_rename PROC NEAR

; 51   : 	return -ENOSYS;

	mov	eax, -38				; ffffffdaH

; 52   : }

	ret	0
_sys_rename ENDP
_TEXT	ENDS
PUBLIC	_sys_prof
_TEXT	SEGMENT
_sys_prof PROC NEAR

; 57   : 	return -ENOSYS;

	mov	eax, -38				; ffffffdaH

; 58   : }

	ret	0
_sys_prof ENDP
_TEXT	ENDS
PUBLIC	_sys_setregid
EXTRN	_current:DWORD
_TEXT	SEGMENT
_rgid$ = 8
_egid$ = 12
_sys_setregid PROC NEAR

; 64   : {

	push	ebp
	mov	ebp, esp

; 65   : 	if (rgid > 0)

	mov	ecx, DWORD PTR _rgid$[ebp]
	mov	eax, DWORD PTR _current
	test	ecx, ecx
	jle	SHORT $L745

; 66   : 	{
; 67   : 		if ((current->gid == rgid) || suser ())

	xor	edx, edx
	mov	dx, WORD PTR [eax+582]
	cmp	edx, ecx
	je	SHORT $L744
	cmp	WORD PTR [eax+578], 0
	je	SHORT $L744

; 69   : 		else
; 70   : 			return (-EPERM);

	or	eax, -1

; 81   : }

	pop	ebp
	ret	0
$L744:

; 68   : 			current->gid = rgid;

	mov	WORD PTR [eax+582], cx
$L745:

; 71   : 	}
; 72   : 	if (egid > 0)

	mov	ecx, DWORD PTR _egid$[ebp]
	test	ecx, ecx
	jle	SHORT $L749

; 73   : 	{
; 74   : 		if ((current->gid == egid) || (current->egid == egid) || 
; 75   : 								(current->sgid == egid) || suser ())

	xor	edx, edx
	mov	dx, WORD PTR [eax+582]
	cmp	edx, ecx
	je	SHORT $L748
	xor	edx, edx
	mov	dx, WORD PTR [eax+584]
	cmp	edx, ecx
	je	SHORT $L748
	xor	edx, edx
	mov	dx, WORD PTR [eax+586]
	cmp	edx, ecx
	je	SHORT $L748
	cmp	WORD PTR [eax+578], 0
	je	SHORT $L748

; 77   : 		else
; 78   : 			return (-EPERM);

	or	eax, -1

; 81   : }

	pop	ebp
	ret	0
$L748:

; 76   : 			current->egid = egid;

	mov	WORD PTR [eax+584], cx
$L749:

; 79   :     }
; 80   : 	return 0;

	xor	eax, eax

; 81   : }

	pop	ebp
	ret	0
_sys_setregid ENDP
_TEXT	ENDS
PUBLIC	_sys_setgid
_TEXT	SEGMENT
_gid$ = 8
_sys_setgid PROC NEAR

; 87   : {

	push	ebp
	mov	ebp, esp

; 88   : 	return (sys_setregid (gid, gid));

	mov	eax, DWORD PTR _gid$[ebp]
	push	eax
	push	eax
	call	_sys_setregid
	add	esp, 8

; 89   : }

	pop	ebp
	ret	0
_sys_setgid ENDP
_TEXT	ENDS
PUBLIC	_sys_acct
_TEXT	SEGMENT
_sys_acct PROC NEAR

; 94   : 	return -ENOSYS;

	mov	eax, -38				; ffffffdaH

; 95   : }

	ret	0
_sys_acct ENDP
_TEXT	ENDS
PUBLIC	_sys_phys
_TEXT	SEGMENT
_sys_phys PROC NEAR

; 100  : 	return -ENOSYS;

	mov	eax, -38				; ffffffdaH

; 101  : }

	ret	0
_sys_phys ENDP
_TEXT	ENDS
PUBLIC	_sys_lock
_TEXT	SEGMENT
_sys_lock PROC NEAR

; 105  : 	return -ENOSYS;

	mov	eax, -38				; ffffffdaH

; 106  : }

	ret	0
_sys_lock ENDP
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
PUBLIC	_sys_mpx
_TEXT	SEGMENT
_sys_mpx PROC NEAR

; 110  : 	return -ENOSYS;

	mov	eax, -38				; ffffffdaH

; 111  : }

	ret	0
_sys_mpx ENDP
_TEXT	ENDS
PUBLIC	_sys_ulimit
_TEXT	SEGMENT
_sys_ulimit PROC NEAR

; 115  : 	return -ENOSYS;

	mov	eax, -38				; ffffffdaH

; 116  : }

	ret	0
_sys_ulimit ENDP
_TEXT	ENDS
PUBLIC	_sys_time
EXTRN	_jiffies:DWORD
EXTRN	_startup_time:DWORD
EXTRN	_verify_area:NEAR
_TEXT	SEGMENT
_tloc$ = 8
_i$ = -4
_sys_time PROC NEAR

; 121  : {

	push	ebp
	mov	ebp, esp
	push	ecx
	push	esi

; 124  : 	i = CURRENT_TIME;

	mov	ecx, DWORD PTR _jiffies
	mov	eax, 1374389535				; 51eb851fH
	mov	esi, DWORD PTR _startup_time
	imul	ecx
	sar	edx, 5
	mov	eax, edx
	shr	eax, 31					; 0000001fH
	add	edx, eax

; 125  : 	if (tloc)

	mov	eax, DWORD PTR _tloc$[ebp]
	add	edx, esi
	mov	esi, edx
	test	eax, eax
	mov	DWORD PTR _i$[ebp], esi
	je	SHORT $L886
	push	ebx

; 126  : 	{
; 127  : 		verify_area (tloc, 4);	// 验证内存容量是否够（这里是4 字节）。

	push	4
	push	eax
	call	_verify_area
	add	esp, 8

; 122  : 	int i;
; 123  : 

	mov	ebx, DWORD PTR _tloc$[ebp]

; 124  : 	i = CURRENT_TIME;

	mov	eax, DWORD PTR _i$[ebp]

; 125  : 	if (tloc)

	mov	DWORD PTR fs:[ebx], eax

; 128  : 		put_fs_long (i, (unsigned long *) tloc);	// 也放入用户数据段tloc 处。
; 129  : 	}
; 130  : 	return i;

	mov	eax, esi
	pop	ebx
	pop	esi

; 131  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L886:

; 128  : 		put_fs_long (i, (unsigned long *) tloc);	// 也放入用户数据段tloc 处。
; 129  : 	}
; 130  : 	return i;

	mov	eax, esi
	pop	esi

; 131  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_sys_time ENDP
_TEXT	ENDS
PUBLIC	_sys_setreuid
_TEXT	SEGMENT
_ruid$ = 8
_euid$ = 12
_sys_setreuid PROC NEAR

; 144  : {

	push	ebp
	mov	ebp, esp

; 145  : 	int old_ruid = current->uid;

	mov	eax, DWORD PTR _current

; 146  : 
; 147  : 	if (ruid > 0)

	mov	edx, DWORD PTR _ruid$[ebp]
	xor	ecx, ecx
	push	esi
	mov	cx, WORD PTR [eax+576]
	push	edi
	test	edx, edx
	jle	SHORT $L781

; 148  : 	{
; 149  : 		if ((current->euid == ruid) || (old_ruid == ruid) || suser ())

	mov	si, WORD PTR [eax+578]
	mov	edi, esi
	and	edi, 65535				; 0000ffffH
	cmp	edi, edx
	je	SHORT $L780
	cmp	ecx, edx
	je	SHORT $L780
	test	si, si
	je	SHORT $L780
	pop	edi

; 151  : 		else
; 152  : 			return (-EPERM);

	or	eax, -1
	pop	esi

; 165  : }

	pop	ebp
	ret	0
$L780:

; 150  : 			current->uid = ruid;

	mov	WORD PTR [eax+576], dx
$L781:

; 153  : 	}
; 154  : 	if (euid > 0)

	mov	esi, DWORD PTR _euid$[ebp]
	test	esi, esi
	jle	SHORT $L785

; 155  : 	{
; 156  : 		if ((old_ruid == euid) || (current->euid == euid) || suser ())

	cmp	ecx, esi
	je	SHORT $L784
	mov	dx, WORD PTR [eax+578]
	mov	edi, edx
	and	edi, 65535				; 0000ffffH
	cmp	edi, esi
	je	SHORT $L784
	test	dx, dx
	je	SHORT $L784

; 158  : 		else
; 159  : 		{
; 160  : 			current->uid = old_ruid;

	mov	WORD PTR [eax+576], cx
	pop	edi

; 161  : 			return (-EPERM);

	or	eax, -1
	pop	esi

; 165  : }

	pop	ebp
	ret	0
$L784:

; 157  : 			current->euid = euid;

	mov	WORD PTR [eax+578], si
$L785:
	pop	edi

; 162  : 		}
; 163  : 	}
; 164  : 	return 0;

	xor	eax, eax
	pop	esi

; 165  : }

	pop	ebp
	ret	0
_sys_setreuid ENDP
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

	je	SHORT $l1$501

; 278  : 		xchg ecx,current/* current = task[n]； */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*执行长跳转，造成任务切换 (头大了很长时间，多多包涵)*/
; 280  : 		mov ax, __tmp

	mov	ax, WORD PTR ___tmp$[ebp]

; 281  : 		mov word ptr ds:[lcs],ax

	mov	WORD PTR ds:$lcs$502, ax

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
$lcs$502:

; 287  : lcs:	_emit 0		// cs

	DB	0

; 288  : 		_emit 0

	DB	0

; 289  : // 在任务切换回来后才会继续执行下面的语句。
; 290  : 		cmp last_task_used_math,ecx /* 新任务上次使用过协处理器吗？*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$501

; 292  : 		clts/* 新任务上次使用过协处理器，则清cr0 的TS 标志。*/

	clts
$l1$501:

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
PUBLIC	_sys_setuid
_TEXT	SEGMENT
_uid$ = 8
_sys_setuid PROC NEAR

; 171  : {

	push	ebp
	mov	ebp, esp

; 172  : 	return (sys_setreuid (uid, uid));

	mov	eax, DWORD PTR _uid$[ebp]
	push	eax
	push	eax
	call	_sys_setreuid
	add	esp, 8

; 173  : }

	pop	ebp
	ret	0
_sys_setuid ENDP
_TEXT	ENDS
PUBLIC	_sys_stime
_TEXT	SEGMENT
_tptr$ = 8
_sys_stime PROC NEAR

; 178  : {

	push	ebp
	mov	ebp, esp

; 179  : 	if (!suser ())		// 如果不是超级用户则出错返回（许可）。

	mov	eax, DWORD PTR _current
	cmp	WORD PTR [eax+578], 0
	je	SHORT $L794

; 180  : 		return -EPERM;

	or	eax, -1

; 183  : }

	pop	ebp
	ret	0
$L794:
	push	ebx

; 182  : 	return 0;

	mov	ebx, DWORD PTR _tptr$[ebp]

; 183  : }

	mov	eax, DWORD PTR fs:[ebx]

; 181  : 	startup_time = get_fs_long ((unsigned long *) tptr) - jiffies / HZ;

	mov	ecx, eax
	mov	edx, DWORD PTR _jiffies
	mov	eax, 1374389535				; 51eb851fH
	pop	ebx
	imul	edx
	sar	edx, 5
	mov	eax, edx
	shr	eax, 31					; 0000001fH
	add	edx, eax
	sub	ecx, edx

; 182  : 	return 0;

	xor	eax, eax
	mov	DWORD PTR _startup_time, ecx

; 183  : }

	pop	ebp
	ret	0
_sys_stime ENDP
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
PUBLIC	_sys_times
_TEXT	SEGMENT
_tbuf$ = 8
$T900 = -4
$T904 = 8
$T905 = -4
$T909 = 8
$T910 = -4
$T914 = 8
$T915 = -4
_sys_times PROC NEAR

; 187  : {

	push	ebp
	mov	ebp, esp
	push	ecx
	push	esi

; 188  : 	if (tbuf)

	mov	esi, DWORD PTR _tbuf$[ebp]
	test	esi, esi
	je	$L916
	push	ebx

; 190  : 		verify_area (tbuf, sizeof *tbuf);

	push	16					; 00000010H
	push	esi
	call	_verify_area

; 191  : 		put_fs_long (current->utime, (unsigned long *) &tbuf->tms_utime);

	mov	eax, DWORD PTR _current
	add	esp, 8
	mov	ecx, DWORD PTR [eax+592]
	mov	DWORD PTR $T900[ebp], ecx

; 189  : 	{

	mov	ebx, DWORD PTR _tbuf$[ebp]

; 190  : 		verify_area (tbuf, sizeof *tbuf);

	mov	eax, DWORD PTR $T900[ebp]

; 191  : 		put_fs_long (current->utime, (unsigned long *) &tbuf->tms_utime);

	mov	DWORD PTR fs:[ebx], eax

; 192  : 		put_fs_long (current->stime, (unsigned long *) &tbuf->tms_stime);

	mov	eax, DWORD PTR _current
	lea	edx, DWORD PTR [esi+4]
	mov	DWORD PTR $T905[ebp], edx
	mov	ecx, DWORD PTR [eax+596]
	mov	DWORD PTR $T904[ebp], ecx

; 189  : 	{

	mov	ebx, DWORD PTR $T905[ebp]

; 190  : 		verify_area (tbuf, sizeof *tbuf);

	mov	eax, DWORD PTR $T904[ebp]

; 191  : 		put_fs_long (current->utime, (unsigned long *) &tbuf->tms_utime);

	mov	DWORD PTR fs:[ebx], eax

; 193  : 		put_fs_long (current->cutime, (unsigned long *) &tbuf->tms_cutime);

	mov	eax, DWORD PTR _current
	lea	edx, DWORD PTR [esi+8]
	mov	DWORD PTR $T910[ebp], edx
	mov	ecx, DWORD PTR [eax+600]
	mov	DWORD PTR $T909[ebp], ecx

; 189  : 	{

	mov	ebx, DWORD PTR $T910[ebp]

; 190  : 		verify_area (tbuf, sizeof *tbuf);

	mov	eax, DWORD PTR $T909[ebp]

; 191  : 		put_fs_long (current->utime, (unsigned long *) &tbuf->tms_utime);

	mov	DWORD PTR fs:[ebx], eax

; 194  : 		put_fs_long (current->cstime, (unsigned long *) &tbuf->tms_cstime);

	mov	edx, DWORD PTR _current
	add	esi, 12					; 0000000cH
	mov	DWORD PTR $T915[ebp], esi
	mov	eax, DWORD PTR [edx+604]
	mov	DWORD PTR $T914[ebp], eax

; 189  : 	{

	mov	ebx, DWORD PTR $T915[ebp]

; 190  : 		verify_area (tbuf, sizeof *tbuf);

	mov	eax, DWORD PTR $T914[ebp]

; 191  : 		put_fs_long (current->utime, (unsigned long *) &tbuf->tms_utime);

	mov	DWORD PTR fs:[ebx], eax

; 195  : 	}
; 196  : 	return jiffies;

	mov	eax, DWORD PTR _jiffies
	pop	ebx
	pop	esi

; 197  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L916:

; 195  : 	}
; 196  : 	return jiffies;

	mov	eax, DWORD PTR _jiffies
	pop	esi

; 197  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_sys_times ENDP
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
PUBLIC	_sys_brk
_TEXT	SEGMENT
_end_data_seg$ = 8
_sys_brk PROC NEAR

; 204  : {

	push	ebp
	mov	ebp, esp

; 205  : 	if (end_data_seg >= current->end_code &&	// 如果参数>代码结尾，并且
; 206  : 	end_data_seg < current->start_stack - 16384)	// 小于堆栈-16KB，

	mov	eax, DWORD PTR _current
	mov	ecx, DWORD PTR _end_data_seg$[ebp]
	cmp	ecx, DWORD PTR [eax+540]
	jb	SHORT $L919
	mov	edx, DWORD PTR [eax+552]
	sub	edx, 16384				; 00004000H
	cmp	ecx, edx
	jae	SHORT $L919

; 207  : 		current->brk = end_data_seg;	// 则设置新数据段结尾值。

	mov	DWORD PTR [eax+548], ecx
$L919:

; 208  : 	return current->brk;		// 返回进程当前的数据段结尾值。

	mov	eax, DWORD PTR [eax+548]

; 209  : }

	pop	ebp
	ret	0
_sys_brk ENDP
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
PUBLIC	_sys_setpgid
_TEXT	SEGMENT
_pid$ = 8
_pgid$ = 12
_sys_setpgid PROC NEAR

; 225  : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 226  : 	int i;
; 227  : 
; 228  : 	if (!pid)			// 如果参数pid=0，则使用当前进程号。

	mov	ebx, DWORD PTR _current
	push	esi
	mov	esi, DWORD PTR _pid$[ebp]
	test	esi, esi
	push	edi
	jne	SHORT $L817

; 229  : 		pid = current->pid;

	mov	esi, DWORD PTR [ebx+556]
$L817:

; 230  : 	if (!pgid)			// 如果pgid 为0，则使用当前进程pid 作为pgid。

	mov	edi, DWORD PTR _pgid$[ebp]
	test	edi, edi
	jne	SHORT $L818

; 231  : 		pgid = current->pid;	// [??这里与POSIX 的描述有出入]

	mov	edi, DWORD PTR [ebx+556]
$L818:

; 232  : 	for (i = 0; i < NR_TASKS; i++)	// 扫描任务数组，查找指定进程号的任务。

	xor	edx, edx
	mov	eax, OFFSET FLAT:_task
$L819:

; 233  : 	if (task[i] && task[i]->pid == pid)

	mov	ecx, DWORD PTR [eax]
	test	ecx, ecx
	je	SHORT $L820
	cmp	DWORD PTR [ecx+556], esi
	je	SHORT $L924
$L820:

; 232  : 	for (i = 0; i < NR_TASKS; i++)	// 扫描任务数组，查找指定进程号的任务。

	add	eax, 4
	inc	edx
	cmp	eax, OFFSET FLAT:_task+256
	jl	SHORT $L819
	pop	edi
	pop	esi

; 241  : 	}
; 242  : 	return -ESRCH;

	mov	eax, -3					; fffffffdH
	pop	ebx

; 243  : }

	pop	ebp
	ret	0
$L924:

; 234  : 	{
; 235  : 		if (task[i]->leader)	// 如果该任务已经是首领，则出错返回。

	mov	eax, DWORD PTR _task[edx*4]
	mov	ecx, DWORD PTR [eax+572]
	test	ecx, ecx
	je	SHORT $L823
	pop	edi
	pop	esi

; 236  : 			return -EPERM;

	or	eax, -1
	pop	ebx

; 243  : }

	pop	ebp
	ret	0
$L823:

; 237  : 		if (task[i]->session != current->session)	// 如果该任务的会话ID

	mov	ecx, DWORD PTR [eax+568]
	mov	edx, DWORD PTR [ebx+568]
	cmp	ecx, edx
	je	SHORT $L824
	pop	edi
	pop	esi

; 238  : 			return -EPERM;	// 与当前进程的不同，则出错返回。

	or	eax, -1
	pop	ebx

; 243  : }

	pop	ebp
	ret	0
$L824:

; 239  : 		task[i]->pgrp = pgid;	// 设置该任务的pgrp。

	mov	DWORD PTR [eax+564], edi
	pop	edi
	pop	esi

; 240  : 		return 0;

	xor	eax, eax
	pop	ebx

; 243  : }

	pop	ebp
	ret	0
_sys_setpgid ENDP
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
PUBLIC	_sys_getpgrp
_TEXT	SEGMENT
_sys_getpgrp PROC NEAR

; 248  : 	return current->pgrp;

	mov	eax, DWORD PTR _current
	mov	eax, DWORD PTR [eax+564]

; 249  : }

	ret	0
_sys_getpgrp ENDP
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
PUBLIC	_sys_setsid
_TEXT	SEGMENT
_sys_setsid PROC NEAR

; 254  : 	if (current->leader && !suser ())	// 如果当前进程已是会话首领并且不是超级用户

	mov	eax, DWORD PTR _current
	mov	ecx, DWORD PTR [eax+572]
	test	ecx, ecx
	je	SHORT $L831
	cmp	WORD PTR [eax+578], 0
	je	SHORT $L831

; 255  : 		return -EPERM;		// 则出错返回。

	or	eax, -1

; 260  : }

	ret	0
$L831:

; 256  : 	current->leader = 1;		// 设置当前进程为新会话首领。

	mov	DWORD PTR [eax+572], 1

; 257  : 	current->session = current->pgrp = current->pid;	// 设置本进程session = pid。

	mov	ecx, DWORD PTR [eax+556]
	mov	DWORD PTR [eax+564], ecx
	mov	DWORD PTR [eax+568], ecx

; 258  : 	current->tty = -1;		// 表示当前进程没有控制终端。

	mov	DWORD PTR [eax+616], -1

; 259  : 	return current->pgrp;		// 返回会话ID。

	mov	eax, DWORD PTR [eax+564]

; 260  : }

	ret	0
_sys_setsid ENDP
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
PUBLIC	_sys_uname
_TEXT	SEGMENT
_name$ = 8
$T943 = 11
$T944 = -4
_sys_uname PROC NEAR

; 265  : {

	push	ebp
	mov	ebp, esp
	push	ecx
	push	esi

; 270  : 
; 271  : 	if (!name)

	mov	esi, DWORD PTR _name$[ebp]
	test	esi, esi
	jne	SHORT $L839

; 272  : 		return -ERROR;		// 如果存放信息的缓冲区指针为空则出错返回。

	mov	eax, -99				; ffffff9dH
	pop	esi

; 277  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L839:
	push	ebx

; 273  : 	verify_area (name, sizeof *name);	// 验证缓冲区大小是否超限（超出已分配的内存等）。

	push	45					; 0000002dH
	push	esi
	call	_verify_area

; 274  : 	for (i = 0; i < sizeof *name; i++)	// 将utsname 中的信息逐字节复制到用户缓冲区中。

	mov	edx, esi
	add	esp, 8
	xor	ecx, ecx
	sub	edx, OFFSET FLAT:_?thisname@?1??sys_uname@@9@9
$L840:

; 275  : 		put_fs_byte (((char *) &thisname)[i], i + (char *) name);

	lea	eax, DWORD PTR _?thisname@?1??sys_uname@@9@9[edx+ecx]
	mov	DWORD PTR $T944[ebp], eax
	mov	al, BYTE PTR _?thisname@?1??sys_uname@@9@9[ecx]
	mov	BYTE PTR $T943[ebp], al

; 266  : 	static struct utsname thisname = {	// 这里给出了结构中的信息，这种编码肯定会改变。
; 267  : 		"linux .0", "nodename", "release ", "version ", "machine "

	mov	ebx, DWORD PTR $T944[ebp]

; 268  : 	};

	mov	al, BYTE PTR $T943[ebp]

; 269  : 	int i;

	mov	BYTE PTR fs:[ebx], al

; 275  : 		put_fs_byte (((char *) &thisname)[i], i + (char *) name);

	inc	ecx
	cmp	ecx, 45					; 0000002dH
	jb	SHORT $L840
	pop	ebx

; 276  : 	return 0;

	xor	eax, eax
	pop	esi

; 277  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_sys_uname ENDP
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
PUBLIC	_sys_umask
_TEXT	SEGMENT
_mask$ = 8
_sys_umask PROC NEAR

; 281  : {

	push	ebp
	mov	ebp, esp

; 282  : 	int old = current->umask;

	mov	ecx, DWORD PTR _current

; 283  : 
; 284  : 	current->umask = mask & 0777;

	mov	edx, DWORD PTR _mask$[ebp]
	xor	eax, eax
	and	edx, 511				; 000001ffH
	mov	ax, WORD PTR [ecx+620]
	mov	WORD PTR [ecx+620], dx

; 285  : 	return (old);
; 286  : }

	pop	ebp
	ret	0
_sys_umask ENDP
_TEXT	ENDS
END
