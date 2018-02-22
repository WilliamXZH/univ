	TITLE	..\kernel\chr_drv\tty_ioctl.c
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
;	COMDAT __outb
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __outb_p
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
;	COMDAT __set_tssldt_desc
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
_DATA	SEGMENT
_quotient DW	00H
	DW	0900H
	DW	0600H
	DW	0417H
	DW	0359H
	DW	0300H
	DW	0240H
	DW	0180H
	DW	0c0H
	DW	060H
	DW	040H
	DW	030H
	DW	018H
	DW	0cH
	DW	06H
	DW	03H
_DATA	ENDS
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
EXTRN	_task:BYTE
EXTRN	_last_task_used_math:DWORD
EXTRN	_current:DWORD
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

; 276  : 		cmp ecx, current/* ����n �ǵ�ǰ������?(current ==task[n]?) */ 

	cmp	ecx, DWORD PTR _current

; 277  : 		je l1 /* �ǣ���ʲô���������˳���*/ 

	je	SHORT $l1$568

; 278  : 		xchg ecx,current/* current = task[n]�� */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*ִ�г���ת����������л� (ͷ���˺ܳ�ʱ�䣬������)*/
; 280  : 		mov ax, __tmp

	mov	ax, WORD PTR ___tmp$[ebp]

; 281  : 		mov word ptr ds:[lcs],ax

	mov	WORD PTR ds:$lcs$569, ax

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
$lcs$569:

; 287  : lcs:	_emit 0		// cs

	DB	0

; 288  : 		_emit 0

	DB	0

; 289  : // �������л�������Ż����ִ���������䡣
; 290  : 		cmp last_task_used_math,ecx /* �������ϴ�ʹ�ù�Э��������*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$568

; 292  : 		clts/* �������ϴ�ʹ�ù�Э������������cr0 ��TS ��־��*/

	clts
$l1$568:

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
PUBLIC	_tty_ioctl
EXTRN	_panic:NEAR
EXTRN	_verify_area:NEAR
EXTRN	_tty_table:BYTE
_DATA	SEGMENT
$SG847	DB	'tty_ioctl: dev<0', 00H
_DATA	ENDS
_TEXT	SEGMENT
_dev$ = 8
_cmd$ = 12
_arg$ = 16
$T925 = 8
$T933 = 8
$T937 = 8
_tty_ioctl PROC NEAR

; 173  : {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi

; 177  : 	if (MAJOR (dev) == 5)

	mov	esi, DWORD PTR _dev$[ebp]
	mov	eax, esi
	and	al, 0
	cmp	eax, 1280				; 00000500H
	jne	SHORT $L845

; 179  : 		dev = current->tty;

	mov	ecx, DWORD PTR _current
	mov	esi, DWORD PTR [ecx+616]

; 180  : 		if (dev < 0)

	test	esi, esi
	jge	SHORT $L848

; 181  : 			panic ("tty_ioctl: dev<0");

	push	OFFSET FLAT:$SG847
	call	_panic
	add	esp, 4

; 182  : // ����ֱ�Ӵ��豸����ȡ�����豸�š�
; 183  : 	}
; 184  : 	else

	jmp	SHORT $L848
$L845:

; 185  : 		dev = MINOR (dev);

	and	esi, 255				; 000000ffH
$L848:

; 186  : // ���豸�ſ�����0(����̨�ն�)��1(����1 �ն�)��2(����2 �ն�)��
; 187  : // ��tty ָ���Ӧ���豸�ŵ�tty �ṹ��
; 188  : 	tty = dev + tty_table;
; 189  : // ����tty ��ioctl ������зֱ���
; 190  : 	switch (cmd)
; 191  : 	{

	mov	edx, DWORD PTR _cmd$[ebp]
	mov	eax, esi
	shl	eax, 5
	add	eax, esi
	lea	esi, DWORD PTR [eax+eax*2]
	lea	eax, DWORD PTR [edx-21505]
	shl	esi, 5
	add	esi, OFFSET FLAT:_tty_table
	cmp	eax, 26					; 0000001aH
	ja	$L867
	jmp	DWORD PTR $L939[eax*4]
$L853:

; 192  : 	case TCGETS:
; 193  : //ȡ��Ӧ�ն�termios �ṹ�е���Ϣ��
; 194  : 		return get_termios (tty, (struct termios *) arg);

	mov	eax, DWORD PTR _arg$[ebp]
	push	eax
	push	esi
	call	_get_termios
	add	esp, 8
	pop	esi
	pop	ebx

; 305  : 	}
; 306  : }

	pop	ebp
	ret	0
$L855:

; 195  : 	case TCSETSF:
; 196  : // ������termios ����Ϣ֮ǰ����Ҫ�ȵȴ�����������������ݴ����꣬����ˢ��(���)������С�
; 197  : // �����á�
; 198  : 		flush (&tty->read_q);	/* fallthrough */

	lea	ecx, DWORD PTR [esi+48]
	push	ecx
	call	_flush
	add	esp, 4
$L856:

; 199  : 	case TCSETSW:
; 200  : // �������ն�termios ����Ϣ֮ǰ����Ҫ�ȵȴ�����������������ݴ�����(�ľ�)�������޸Ĳ���
; 201  : // ��Ӱ����������������Ҫʹ��������ʽ��
; 202  : 		wait_until_sent (tty);	/* fallthrough */

	push	esi
	call	_wait_until_sent
	add	esp, 4
$L857:

; 203  : 	case TCSETS:
; 204  : // ������Ӧ�ն�termios �ṹ�е���Ϣ��
; 205  : 		return set_termios (tty, (struct termios *) arg);

	mov	edx, DWORD PTR _arg$[ebp]
	push	edx
	push	esi
	call	_set_termios
	add	esp, 8
	pop	esi
	pop	ebx

; 305  : 	}
; 306  : }

	pop	ebp
	ret	0
$L859:

; 206  : 	case TCGETA:
; 207  : // ȡ��Ӧ�ն�termio �ṹ�е���Ϣ��
; 208  : 		return get_termio (tty, (struct termio *) arg);

	mov	eax, DWORD PTR _arg$[ebp]
	push	eax
	push	esi
	call	_get_termio
	add	esp, 8
	pop	esi
	pop	ebx

; 305  : 	}
; 306  : }

	pop	ebp
	ret	0
$L861:

; 209  : 	case TCSETAF:
; 210  : // ������termio ����Ϣ֮ǰ����Ҫ�ȵȴ�����������������ݴ����꣬����ˢ��(���)������С�
; 211  : // �����á�
; 212  : 		flush (&tty->read_q);	/* fallthrough */

	lea	ecx, DWORD PTR [esi+48]
	push	ecx
	call	_flush
	add	esp, 4
$L862:

; 213  : 	case TCSETAW:
; 214  : // �������ն�termio ����Ϣ֮ǰ����Ҫ�ȵȴ�����������������ݴ�����(�ľ�)�������޸Ĳ���
; 215  : // ��Ӱ����������������Ҫʹ��������ʽ��
; 216  : 		wait_until_sent (tty);	/* fallthrough *//* ����ִ�� */

	push	esi
	call	_wait_until_sent
	add	esp, 4
$L863:

; 217  : 	case TCSETA:
; 218  : // ������Ӧ�ն�termio �ṹ�е���Ϣ��
; 219  : 		return set_termio (tty, (struct termio *) arg);

	mov	edx, DWORD PTR _arg$[ebp]
	push	edx
	push	esi
	call	_set_termio
	add	esp, 8
	pop	esi
	pop	ebx

; 305  : 	}
; 306  : }

	pop	ebp
	ret	0
$L865:

; 220  : 	case TCSBRK:
; 221  : // �ȴ�������д������(��)���������ֵ��0������һ��break��
; 222  : 		if (!arg)

	mov	eax, DWORD PTR _arg$[ebp]
	test	eax, eax
	jne	SHORT $L874

; 223  : 		{
; 224  : 			wait_until_sent (tty);

	push	esi
	call	_wait_until_sent

; 225  : 			send_break (tty);

	push	esi
	call	_send_break
	add	esp, 8
$L874:
	pop	esi

; 226  : 		}
; 227  : 		return 0;

	xor	eax, eax
	pop	ebx

; 305  : 	}
; 306  : }

	pop	ebp
	ret	0
$L868:

; 228  : 	case TCXONC:
; 229  : // ��ʼ/ֹͣ���ơ��������ֵ��0�����������������1�������¿������������������2�������
; 230  : // ���룻�����3�������¿�����������롣
; 231  : 		return -EINVAL;		/* not implemented *//* δʵ�� */
; 232  : 	case TCFLSH:
; 233  : //ˢ����д�������û���ͻ����յ���û�ж����ݡ����������0����ˢ��(���)������У������1��
; 234  : // ��ˢ��������У������2����ˢ�������������С�
; 235  : 		if (arg == 0)

	mov	eax, DWORD PTR _arg$[ebp]
	test	eax, eax
	jne	SHORT $L869

; 236  : 			flush (&tty->read_q);

	add	esi, 48					; 00000030H
	push	esi
	call	_flush
	add	esp, 4
	xor	eax, eax
	pop	esi
	pop	ebx

; 305  : 	}
; 306  : }

	pop	ebp
	ret	0
$L869:

; 237  : 		else if (arg == 1)

	cmp	eax, 1
	jne	SHORT $L871

; 238  : 			flush (&tty->write_q);

	add	esi, 1088				; 00000440H
	push	esi
	call	_flush
	add	esp, 4
	xor	eax, eax
	pop	esi
	pop	ebx

; 305  : 	}
; 306  : }

	pop	ebp
	ret	0
$L871:

; 239  : 		else if (arg == 2)

	cmp	eax, 2
	jne	$L867

; 240  : 		{
; 241  : 			flush (&tty->read_q);

	lea	eax, DWORD PTR [esi+48]
	push	eax
	call	_flush

; 242  : 			flush (&tty->write_q);

	add	esi, 1088				; 00000440H
	push	esi
	call	_flush
	add	esp, 8

; 243  : 		}
; 244  : 		else
; 245  : 			return -EINVAL;
; 246  : 		return 0;

	xor	eax, eax
	pop	esi
	pop	ebx

; 305  : 	}
; 306  : }

	pop	ebp
	ret	0
$L878:

; 247  : 	case TIOCEXCL:
; 248  : // �����ն˴�����·ר��ģʽ��
; 249  : 		return -EINVAL;		/* not implemented *//* δʵ�� */
; 250  : 	case TIOCNXCL:
; 251  : // ��λ�ն˴�����·ר��ģʽ��
; 252  : 		return -EINVAL;		/* not implemented *//* δʵ�� */
; 253  : 	case TIOCSCTTY:
; 254  : // ����tty Ϊ�����նˡ�(TIOCNOTTY - ��ֹtty Ϊ�����ն�)��
; 255  : 		return -EINVAL;		/* set controlling term NI *//* ���ÿ����ն�NI */
; 256  : 	case TIOCGPGRP:		// NI - Not Implemented��
; 257  : // ��ȡָ���ն��豸���̵���id��������֤�û����������ȣ�Ȼ����tty ��pgrp �ֶε��û���������
; 258  : 		verify_area ((void *) arg, 4);

	mov	ecx, DWORD PTR _arg$[ebp]
	push	4
	push	ecx
	call	_verify_area

; 259  : 		put_fs_long (tty->pgrp, (unsigned long *) arg);

	mov	edx, DWORD PTR [esi+36]
	add	esp, 8
	mov	DWORD PTR $T925[ebp], edx

; 174  : 	struct tty_struct *tty;
; 175  : // ����ȡtty �����豸�š�������豸����5(tty �ն�)������̵�tty �ֶμ������豸�ţ��������

	mov	ebx, DWORD PTR _arg$[ebp]

; 176  : // ��tty ���豸���Ǹ����������ý���û�п����նˣ�Ҳ�����ܷ�����ioctl ���ã�����������

	mov	eax, DWORD PTR $T925[ebp]

; 177  : 	if (MAJOR (dev) == 5)

	mov	DWORD PTR fs:[ebx], eax

; 259  : 		put_fs_long (tty->pgrp, (unsigned long *) arg);

	pop	esi

; 260  : 		return 0;

	xor	eax, eax
	pop	ebx

; 305  : 	}
; 306  : }

	pop	ebp
	ret	0
$L881:

; 177  : 	if (MAJOR (dev) == 5)

	mov	ebx, DWORD PTR _arg$[ebp]

; 178  : 	{

	mov	eax, DWORD PTR fs:[ebx]

; 261  : 	case TIOCSPGRP:
; 262  : // ����ָ���ն��豸���̵���id��
; 263  : 		tty->pgrp = get_fs_long ((unsigned long *) arg);

	mov	DWORD PTR [esi+36], eax
	pop	esi

; 264  : 		return 0;

	xor	eax, eax
	pop	ebx

; 305  : 	}
; 306  : }

	pop	ebp
	ret	0
$L883:

; 265  : 	case TIOCOUTQ:
; 266  : // ������������л�δ�ͳ����ַ�����������֤�û����������ȣ�Ȼ���ƶ������ַ������û���
; 267  : 		verify_area ((void *) arg, 4);

	mov	eax, DWORD PTR _arg$[ebp]
	push	4
	push	eax
	call	_verify_area

; 268  : 		put_fs_long (CHARS (tty->write_q), (unsigned long *) arg);

	mov	ecx, DWORD PTR [esi+1092]
	mov	edx, DWORD PTR [esi+1096]
	sub	ecx, edx
	add	esp, 8
	and	ecx, 1023				; 000003ffH
	mov	DWORD PTR $T933[ebp], ecx

; 174  : 	struct tty_struct *tty;
; 175  : // ����ȡtty �����豸�š�������豸����5(tty �ն�)������̵�tty �ֶμ������豸�ţ��������

	mov	ebx, DWORD PTR _arg$[ebp]

; 176  : // ��tty ���豸���Ǹ����������ý���û�п����նˣ�Ҳ�����ܷ�����ioctl ���ã�����������

	mov	eax, DWORD PTR $T933[ebp]

; 177  : 	if (MAJOR (dev) == 5)

	mov	DWORD PTR fs:[ebx], eax

; 268  : 		put_fs_long (CHARS (tty->write_q), (unsigned long *) arg);

	pop	esi

; 269  : 		return 0;

	xor	eax, eax
	pop	ebx

; 305  : 	}
; 306  : }

	pop	ebp
	ret	0
$L886:

; 270  : 	case TIOCINQ:
; 271  : // ������������л�δ��ȡ���ַ�����������֤�û����������ȣ�Ȼ���ƶ������ַ������û���
; 272  : 		verify_area ((void *) arg, 4);

	mov	edx, DWORD PTR _arg$[ebp]
	push	4
	push	edx
	call	_verify_area

; 273  : 		put_fs_long (CHARS (tty->secondary), (unsigned long *) arg);

	mov	eax, DWORD PTR [esi+2132]
	mov	edx, DWORD PTR [esi+2136]
	sub	eax, edx
	add	esp, 8
	and	eax, 1023				; 000003ffH
	mov	DWORD PTR $T937[ebp], eax

; 174  : 	struct tty_struct *tty;
; 175  : // ����ȡtty �����豸�š�������豸����5(tty �ն�)������̵�tty �ֶμ������豸�ţ��������

	mov	ebx, DWORD PTR _arg$[ebp]

; 176  : // ��tty ���豸���Ǹ����������ý���û�п����նˣ�Ҳ�����ܷ�����ioctl ���ã�����������

	mov	eax, DWORD PTR $T937[ebp]

; 177  : 	if (MAJOR (dev) == 5)

	mov	DWORD PTR fs:[ebx], eax

; 273  : 		put_fs_long (CHARS (tty->secondary), (unsigned long *) arg);

	pop	esi

; 274  : 		return 0;

	xor	eax, eax
	pop	ebx

; 305  : 	}
; 306  : }

	pop	ebp
	ret	0
$L867:
	pop	esi

; 275  : 	case TIOCSTI:
; 276  : // ģ���ն����롣��������һ��ָ���ַ���ָ����Ϊ����������װ���ַ������ն��ϼ���ġ��û�����
; 277  : // �ڸÿ����ն��Ͼ��г����û�Ȩ�޻���ж����Ȩ�ޡ�
; 278  : 		return -EINVAL;		/* not implemented *//* δʵ�� */
; 279  : 	case TIOCGWINSZ:
; 280  : // ��ȡ�ն��豸���ڴ�С��Ϣ���μ�termios.h �е�winsize �ṹ����
; 281  : 		return -EINVAL;		/* not implemented *//* δʵ�� */
; 282  : 	case TIOCSWINSZ:
; 283  : // �����ն��豸���ڴ�С��Ϣ���μ�winsize �ṹ����
; 284  : 		return -EINVAL;		/* not implemented *//* δʵ�� */
; 285  : 	case TIOCMGET:
; 286  : // ����modem ״̬�������ߵĵ�ǰ״̬����λ��־�����μ�termios.h ��185-196 �У���
; 287  : 		return -EINVAL;		/* not implemented *//* δʵ�� */
; 288  : 	case TIOCMBIS:
; 289  : // ���õ���modem ״̬�������ߵ�״̬(true ��false)��
; 290  : 		return -EINVAL;		/* not implemented *//* δʵ�� */
; 291  : 	case TIOCMBIC:
; 292  : // ��λ����modem ״̬�������ߵ�״̬��
; 293  : 		return -EINVAL;		/* not implemented *//* δʵ�� */
; 294  : 	case TIOCMSET:
; 295  : // ����modem ״̬���ߵ�״̬�����ĳһ����λ��λ����modem ��Ӧ��״̬���߽���Ϊ��Ч��
; 296  : 		return -EINVAL;		/* not implemented *//* δʵ�� */
; 297  : 	case TIOCGSOFTCAR:
; 298  : // ��ȡ����ز�����־(1 - ������0 - �ر�)��
; 299  : 		return -EINVAL;		/* not implemented *//* δʵ�� */
; 300  : 	case TIOCSSOFTCAR:
; 301  : // ��������ز�����־(1 - ������0 - �ر�)��
; 302  : 		return -EINVAL;		/* not implemented *//* δʵ�� */
; 303  : 	default:
; 304  : 		return -EINVAL;

	mov	eax, -22				; ffffffeaH
	pop	ebx

; 305  : 	}
; 306  : }

	pop	ebp
	ret	0
	npad	2
$L939:
	DD	$L853
	DD	$L857
	DD	$L856
	DD	$L855
	DD	$L859
	DD	$L863
	DD	$L862
	DD	$L861
	DD	$L865
	DD	$L867
	DD	$L868
	DD	$L867
	DD	$L867
	DD	$L867
	DD	$L878
	DD	$L881
	DD	$L883
	DD	$L867
	DD	$L867
	DD	$L867
	DD	$L867
	DD	$L867
	DD	$L867
	DD	$L867
	DD	$L867
	DD	$L867
	DD	$L886
_tty_ioctl ENDP
_queue$ = 8
_flush	PROC NEAR

; 55   : {

	push	ebp
	mov	ebp, esp

; 56   : 	cli ();

	cli

; 57   : 	queue->head = queue->tail;

	mov	eax, DWORD PTR _queue$[ebp]
	mov	ecx, DWORD PTR [eax+8]
	mov	DWORD PTR [eax+4], ecx

; 58   : 	sti ();

	sti

; 59   : }

	pop	ebp
	ret	0
_flush	ENDP
_wait_until_sent PROC NEAR

; 65   : /* do nothing - not implemented *//* ʲô��û�� - ��δʵ�� */
; 66   : }

	ret	0
_wait_until_sent ENDP
_send_break PROC NEAR

; 72   : /* do nothing - not implemented *//* ʲô��û�� - ��δʵ�� */
; 73   : }

	ret	0
_send_break ENDP
_tty$ = 8
_termios$ = 12
$T947 = 15
$T948 = 8
_get_termios PROC NEAR

; 80   : {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi

; 84   : 	verify_area (termios, sizeof (*termios));

	mov	esi, DWORD PTR _termios$[ebp]
	push	36					; 00000024H
	push	esi
	call	_verify_area
	mov	ecx, DWORD PTR _tty$[ebp]

; 85   : // ����ָ��tty �ṹ�е�termios �ṹ��Ϣ���û� termios �ṹ��������
; 86   : 	for (i = 0; i < (sizeof (*termios)); i++)

	mov	edx, esi
	add	esp, 8
	sub	edx, ecx
	mov	esi, 36					; 00000024H
$L782:
	lea	eax, DWORD PTR [edx+ecx]

; 87   : 		put_fs_byte (((char *) &tty->termios)[i], i + (char *) termios);

	mov	DWORD PTR $T948[ebp], eax
	mov	al, BYTE PTR [ecx]
	mov	BYTE PTR $T947[ebp], al

; 81   : 	int i;
; 82   : 

	mov	ebx, DWORD PTR $T948[ebp]

; 83   : // ������֤һ���û��Ļ�����ָ����ָ�ڴ����Ƿ��㹻���粻��������ڴ档

	mov	al, BYTE PTR $T947[ebp]

; 84   : 	verify_area (termios, sizeof (*termios));

	mov	BYTE PTR fs:[ebx], al

; 87   : 		put_fs_byte (((char *) &tty->termios)[i], i + (char *) termios);

	inc	ecx
	dec	esi
	jne	SHORT $L782
	pop	esi

; 88   : 	return 0;

	xor	eax, eax
	pop	ebx

; 89   : }

	pop	ebp
	ret	0
_get_termios ENDP
_tty$ = 8
_termios$ = 12
$T955 = 8
_set_termios PROC NEAR

; 96   : {

	push	ebp
	mov	ebp, esp

; 97   : 	int i;
; 98   : 
; 99   : // ���ȸ����û���������termios �ṹ��Ϣ��ָ��tty �ṹ�С�
; 100  : 	for (i = 0; i < (sizeof (*termios)); i++)

	mov	edx, DWORD PTR _termios$[ebp]
	push	ebx
	push	esi
	push	edi
	mov	edi, DWORD PTR _tty$[ebp]
	mov	esi, 36					; 00000024H
	mov	ecx, edi
	sub	edx, edi
$L794:
	lea	eax, DWORD PTR [edx+ecx]

; 101  : 		((char *) &tty->termios)[i] = get_fs_byte (i + (char *) termios);

	mov	DWORD PTR $T955[ebp], eax

; 97   : 	int i;
; 98   : 
; 99   : // ���ȸ����û���������termios �ṹ��Ϣ��ָ��tty �ṹ�С�
; 100  : 	for (i = 0; i < (sizeof (*termios)); i++)

	mov	ebx, DWORD PTR $T955[ebp]

; 101  : 		((char *) &tty->termios)[i] = get_fs_byte (i + (char *) termios);

	mov	al, BYTE PTR fs:[ebx]
	mov	BYTE PTR [ecx], al
	inc	ecx
	dec	esi
	jne	SHORT $L794

; 102  : // �û��п������޸���tty �Ĵ��пڴ��䲨���ʣ����Ը���termios �ṹ�еĿ���ģʽ��־c_cflag
; 103  : // �޸Ĵ���оƬUART �Ĵ��䲨���ʡ�
; 104  : 	change_speed (tty);

	push	edi
	call	_change_speed
	add	esp, 4

; 105  : 	return 0;

	xor	eax, eax
	pop	edi
	pop	esi
	pop	ebx

; 106  : }

	pop	ebp
	ret	0
_set_termios ENDP
_tty$ = 8
_port$ = -8
$T965 = 11
$T966 = -4
$T972 = 11
$T978 = 11
$T979 = -8
$T983 = 11
$T984 = -8
_change_speed PROC NEAR

; 33   : {

	push	ebp
	mov	ebp, esp
	sub	esp, 8

; 37   : 	if (!(port = tty->read_q.data))

	mov	eax, DWORD PTR _tty$[ebp]
	push	edi
	mov	di, WORD PTR [eax+48]
	test	di, di
	mov	DWORD PTR _port$[ebp], edi
	je	SHORT $L751

; 39   : // ��tty ��termios �ṹ����ģʽ��־����ȡ�����õĲ����������ţ��ݴ˴Ӳ���������������ȡ��
; 40   : // ��Ӧ�Ĳ���������ֵ��CBAUD �ǿ���ģʽ��־���в�����λ�����롣
; 41   : 	quot = quotient[tty->termios.c_cflag & CBAUD];

	mov	eax, DWORD PTR [eax+8]
	push	esi
	and	eax, 15					; 0000000fH
	mov	cx, WORD PTR _quotient[eax*2]

; 42   : 	cli ();			// ���жϡ�

	cli

; 43   : 	outb_p (0x80, port + 3);	/* set DLAB */// �������ó���������־DLAB��

	lea	esi, DWORD PTR [edi+3]
	mov	BYTE PTR $T965[ebp], 128		; 00000080H
	mov	DWORD PTR $T966[ebp], esi

; 34   : 	unsigned short port, quot;

	mov	al, BYTE PTR $T965[ebp]

; 35   : 

	mov	dx, WORD PTR $T966[ebp]

; 36   : // ���ڴ����նˣ���tty �ṹ�Ķ��������data �ֶδ�ŵ��Ǵ��ж˿ں�(0x3f8 ��0x2f8)��

	out	dx, al

; 37   : 	if (!(port = tty->read_q.data))

	jmp	SHORT $l1$962
$l1$962:

; 38   : 		return;

	jmp	SHORT $l2$963
$l2$963:

; 44   : 	outb_p (quot & 0xff, port);	/* LS of divisor */// ������ӵ��ֽڡ�

	mov	BYTE PTR $T972[ebp], cl

; 34   : 	unsigned short port, quot;

	mov	al, BYTE PTR $T972[ebp]

; 35   : 

	mov	dx, WORD PTR _port$[ebp]

; 36   : // ���ڴ����նˣ���tty �ṹ�Ķ��������data �ֶδ�ŵ��Ǵ��ж˿ں�(0x3f8 ��0x2f8)��

	out	dx, al

; 37   : 	if (!(port = tty->read_q.data))

	jmp	SHORT $l1$969
$l1$969:

; 38   : 		return;

	jmp	SHORT $l2$970
$l2$970:

; 45   : 	outb_p (quot >> 8, port + 1);	/* MS of divisor */// ������Ӹ��ֽڡ�

	inc	edi
	xor	edx, edx
	mov	dl, ch
	mov	DWORD PTR $T979[ebp], edi
	mov	BYTE PTR $T978[ebp], dl

; 34   : 	unsigned short port, quot;

	mov	al, BYTE PTR $T978[ebp]

; 35   : 

	mov	dx, WORD PTR $T979[ebp]

; 36   : // ���ڴ����նˣ���tty �ṹ�Ķ��������data �ֶδ�ŵ��Ǵ��ж˿ں�(0x3f8 ��0x2f8)��

	out	dx, al

; 37   : 	if (!(port = tty->read_q.data))

	jmp	SHORT $l1$975
$l1$975:

; 38   : 		return;

	jmp	SHORT $l2$976
$l2$976:

; 46   : 	outb (0x03, port + 3);	/* reset DLAB */// ��λDLAB��

	mov	DWORD PTR $T984[ebp], esi
	mov	BYTE PTR $T983[ebp], 3

; 34   : 	unsigned short port, quot;

	mov	dx, WORD PTR $T984[ebp]

; 35   : 

	mov	al, BYTE PTR $T983[ebp]

; 36   : // ���ڴ����նˣ���tty �ṹ�Ķ��������data �ֶδ�ŵ��Ǵ��ж˿ں�(0x3f8 ��0x2f8)��

	out	dx, al

; 47   : 	sti ();			// ���жϡ�

	sti

; 46   : 	outb (0x03, port + 3);	/* reset DLAB */// ��λDLAB��

	pop	esi
$L751:
	pop	edi

; 48   : }

	mov	esp, ebp
	pop	ebp
	ret	0
_change_speed ENDP
_tty$ = 8
_termio$ = 12
_tmp_termio$ = -20
$T989 = 15
$T990 = 8
_get_termio PROC NEAR

; 113  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 20					; 00000014H
	push	ebx
	push	esi

; 118  : 	verify_area (termio, sizeof (*termio));

	mov	esi, DWORD PTR _termio$[ebp]
	push	18					; 00000012H
	push	esi
	call	_verify_area

; 119  : // ��termios �ṹ����Ϣ���Ƶ�termio �ṹ�С�Ŀ����Ϊ������ģʽ��־�������ͽ���ת����Ҳ��
; 120  : // ��termios �ĳ���������ת��Ϊtermio �Ķ��������͡�
; 121  : 	tmp_termio.c_iflag = tty->termios.c_iflag;

	mov	eax, DWORD PTR _tty$[ebp]
	add	esp, 8
	mov	cx, WORD PTR [eax]

; 122  : 	tmp_termio.c_oflag = tty->termios.c_oflag;

	mov	dx, WORD PTR [eax+4]
	mov	WORD PTR _tmp_termio$[ebp], cx

; 123  : 	tmp_termio.c_cflag = tty->termios.c_cflag;

	mov	cx, WORD PTR [eax+8]
	mov	WORD PTR _tmp_termio$[ebp+2], dx

; 124  : 	tmp_termio.c_lflag = tty->termios.c_lflag;

	mov	dx, WORD PTR [eax+12]
	mov	WORD PTR _tmp_termio$[ebp+4], cx

; 125  : // ���ֽṹ��c_line ��c_cc[]�ֶ�����ȫ��ͬ�ġ�
; 126  : 	tmp_termio.c_line = tty->termios.c_line;

	mov	cl, BYTE PTR [eax+16]
	add	eax, 17					; 00000011H
	mov	WORD PTR _tmp_termio$[ebp+6], dx
	mov	BYTE PTR _tmp_termio$[ebp+8], cl

; 127  : 	for (i = 0; i < NCC; i++)
; 128  : 		tmp_termio.c_cc[i] = tty->termios.c_cc[i];
; 129  : // �����ָ��tty �ṹ�е�termio �ṹ��Ϣ���û� termio �ṹ��������
; 130  : 	for (i = 0; i < (sizeof (*termio)); i++)

	xor	ecx, ecx
	mov	edx, DWORD PTR [eax]
	mov	eax, DWORD PTR [eax+4]
	mov	DWORD PTR _tmp_termio$[ebp+9], edx
	mov	DWORD PTR _tmp_termio$[ebp+13], eax
	mov	edx, esi
	lea	eax, DWORD PTR _tmp_termio$[ebp]
	sub	edx, eax
$L810:

; 131  : 		put_fs_byte (((char *) &tmp_termio)[i], i + (char *) termio);

	lea	eax, DWORD PTR _tmp_termio$[ebp+ecx]
	lea	esi, DWORD PTR [edx+eax]
	mov	al, BYTE PTR [eax]
	mov	DWORD PTR $T990[ebp], esi
	mov	BYTE PTR $T989[ebp], al

; 114  : 	int i;
; 115  : 	struct termio tmp_termio;

	mov	ebx, DWORD PTR $T990[ebp]

; 116  : 

	mov	al, BYTE PTR $T989[ebp]

; 117  : // ������֤һ���û��Ļ�����ָ����ָ�ڴ����Ƿ��㹻���粻��������ڴ档

	mov	BYTE PTR fs:[ebx], al

; 131  : 		put_fs_byte (((char *) &tmp_termio)[i], i + (char *) termio);

	inc	ecx
	cmp	ecx, 18					; 00000012H
	jb	SHORT $L810
	pop	esi

; 132  : 	return 0;

	xor	eax, eax
	pop	ebx

; 133  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_get_termio ENDP
_tty$ = 8
_termio$ = 12
_tmp_termio$ = -20
$T999 = 12
_set_termio PROC NEAR

; 146  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 20					; 00000014H
	push	ebx
	push	esi

; 151  : 	for (i = 0; i < (sizeof (*termio)); i++)

	mov	esi, DWORD PTR _termio$[ebp]
	lea	eax, DWORD PTR _tmp_termio$[ebp]
	xor	ecx, ecx
	sub	esi, eax
$L823:

; 152  : 		((char *) &tmp_termio)[i] = get_fs_byte (i + (char *) termio);

	lea	edx, DWORD PTR _tmp_termio$[ebp+ecx]
	lea	eax, DWORD PTR [esi+edx]
	mov	DWORD PTR $T999[ebp], eax

; 147  : 	int i;
; 148  : 	struct termio tmp_termio;
; 149  : 
; 150  : // ���ȸ����û���������termio �ṹ��Ϣ����ʱtermio �ṹ�С�

	mov	ebx, DWORD PTR $T999[ebp]

; 151  : 	for (i = 0; i < (sizeof (*termio)); i++)

	mov	al, BYTE PTR fs:[ebx]

; 152  : 		((char *) &tmp_termio)[i] = get_fs_byte (i + (char *) termio);

	inc	ecx
	mov	BYTE PTR [edx], al
	cmp	ecx, 18					; 00000012H
	jb	SHORT $L823

; 153  : // �ٽ�termio �ṹ����Ϣ���Ƶ�tty ��termios �ṹ�С�Ŀ����Ϊ������ģʽ��־�������ͽ���ת����
; 154  : // Ҳ����termio �Ķ���������ת����termios �ĳ��������͡�
; 155  : 	*(unsigned short *) &tty->termios.c_iflag = tmp_termio.c_iflag;

	mov	eax, DWORD PTR _tty$[ebp]
	mov	cx, WORD PTR _tmp_termio$[ebp]

; 156  : 	*(unsigned short *) &tty->termios.c_oflag = tmp_termio.c_oflag;

	mov	dx, WORD PTR _tmp_termio$[ebp+2]

; 157  : 	*(unsigned short *) &tty->termios.c_cflag = tmp_termio.c_cflag;
; 158  : 	*(unsigned short *) &tty->termios.c_lflag = tmp_termio.c_lflag;
; 159  : // ���ֽṹ��c_line ��c_cc[]�ֶ�����ȫ��ͬ�ġ�
; 160  : 	tty->termios.c_line = tmp_termio.c_line;
; 161  : 	for (i = 0; i < NCC; i++)
; 162  : 		tty->termios.c_cc[i] = tmp_termio.c_cc[i];
; 163  : // �û��������޸���tty �Ĵ��пڴ��䲨���ʣ����Ը���termios �ṹ�еĿ���ģʽ��־��c_cflag
; 164  : // �޸Ĵ���оƬUART �Ĵ��䲨���ʡ�
; 165  : 	change_speed (tty);

	push	eax
	mov	WORD PTR [eax], cx
	mov	cx, WORD PTR _tmp_termio$[ebp+4]
	mov	WORD PTR [eax+4], dx
	mov	dx, WORD PTR _tmp_termio$[ebp+6]
	mov	WORD PTR [eax+8], cx
	mov	cl, BYTE PTR _tmp_termio$[ebp+8]
	mov	WORD PTR [eax+12], dx
	mov	edx, DWORD PTR _tmp_termio$[ebp+9]
	mov	BYTE PTR [eax+16], cl
	mov	ecx, DWORD PTR _tmp_termio$[ebp+13]
	mov	DWORD PTR [eax+17], edx
	mov	DWORD PTR [eax+21], ecx
	call	_change_speed
	add	esp, 4

; 166  : 	return 0;

	xor	eax, eax
	pop	esi
	pop	ebx

; 167  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_set_termio ENDP
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

; 325  : 	_asm mov word ptr [ebx+2],dx // ��ַbase ��16 λ(λ15-0)->[addr+2]��

	mov	WORD PTR [ebx+2], dx

; 326  : 	_asm ror edx,16 // edx �л�ַ��16 λ(λ31-16) -> dx�� 

	ror	edx, 16					; 00000010H

; 327  : 	_asm mov byte ptr [ebx+4],dl // ��ַ��16 λ�еĵ�8 λ(λ23-16)->[addr+4]��

	mov	BYTE PTR [ebx+4], dl

; 328  : 	_asm mov byte ptr [ebx+7],dh // ��ַ��16 λ�еĸ�8 λ(λ31-24)->[addr+7]��

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

; 345  : 	_asm mov word ptr [ebx],dx // �γ�limit ��16 λ(λ15-0)->[addr]��

	mov	WORD PTR [ebx], dx

; 346  : 	_asm ror edx,16 // edx �еĶγ���4 λ(λ19-16)->dl��

	ror	edx, 16					; 00000010H

; 347  : 	_asm mov dh,byte ptr [ebx+6] // ȡԭ[addr+6]�ֽ�->dh�����и�4 λ��Щ��־��

	mov	dh, BYTE PTR [ebx+6]

; 348  : 	_asm and dh,0f0h // ��dh �ĵ�4 λ(����Ŷγ���λ19-16)��

	and	dh, -16					; fffffff0H

; 349  : 	_asm or dl,dh // ��ԭ��4 λ��־�Ͷγ��ĸ�4 λ(λ19-16)�ϳ�1 �ֽڣ�

	or	dl, dh

; 350  : 	_asm mov byte ptr [ebx+6],dl // ���Ż�[addr+6]����

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

; 378  : 		_asm mov ah,byte ptr [ebx+7] // ȡ[addr+7]����ַ��16 λ�ĸ�8 λ(λ31-24)->dh��

	mov	ah, BYTE PTR [ebx+7]

; 379  : 		_asm mov al,byte ptr [ebx+4] // ȡ[addr+4]����ַ��16 λ�ĵ�8 λ(λ23-16)->dl��

	mov	al, BYTE PTR [ebx+4]

; 380  : 		_asm shl eax,16 // ����ַ��16 λ�Ƶ�edx �и�16 λ����

	shl	eax, 16					; 00000010H

; 381  : 		_asm mov ax,word ptr [ebx+2] // ȡ[addr+2]����ַ��16 λ(λ15-0)->dx��

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

; 114  : 	_asm mov word ptr [ebx],ax // ��TSS ���ȷ���������������(��0-1 �ֽ�)��

	mov	WORD PTR [ebx], ax

; 115  : 	_asm mov eax,addr 

	mov	eax, DWORD PTR _addr$[ebp]

; 116  : 	_asm mov word ptr [ebx+2],ax // ������ַ�ĵ��ַ�����������2-3 �ֽڡ�

	mov	WORD PTR [ebx+2], ax

; 117  : 	_asm ror eax,16 // ������ַ��������ax �С�

	ror	eax, 16					; 00000010H

; 118  : 	_asm mov byte ptr [ebx+4],al // ������ַ�����е��ֽ�������������4 �ֽڡ�

	mov	BYTE PTR [ebx+4], al

; 119  : 	_asm mov al,tp

	mov	al, BYTE PTR _tp$[ebp]

; 120  : 	_asm mov byte ptr [ebx+5],al // ����־�����ֽ������������ĵ�5 �ֽڡ�

	mov	BYTE PTR [ebx+5], al

; 121  : 	_asm mov al,0 

	mov	al, 0

; 122  : 	_asm mov byte ptr [ebx+6],al // �������ĵ�6 �ֽ���0��

	mov	BYTE PTR [ebx+6], al

; 123  : 	_asm mov byte ptr [ebx+7],ah // ������ַ�����и��ֽ�������������7 �ֽڡ�

	mov	BYTE PTR [ebx+7], ah

; 124  : 	_asm ror eax,16 // eax ���㡣

	ror	eax, 16					; 00000010H
	pop	ebx

; 125  : }

	pop	ebp
	ret	0
__set_tssldt_desc ENDP
_TEXT	ENDS
END
