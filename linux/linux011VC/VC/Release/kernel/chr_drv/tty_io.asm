	TITLE	..\kernel\chr_drv\tty_io.c
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
;	COMDAT __set_tssldt_desc
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	_tty_table
PUBLIC	_table_list
EXTRN	_rs_write:NEAR
EXTRN	_con_write:NEAR
_BSS	SEGMENT
_?cr_flag@?1??tty_write@@9@9 DD 01H DUP (?)
_BSS	ENDS
_DATA	SEGMENT
_tty_table DD	0100H
	DD	05H
	DD	00H
	DD	0a0bH
	DB	00H
	DB	03H, 01cH, 07fH, 015H, 04H, 00H, 01H, 00H, 011H, 013H, 01aH
	DB	00H, 012H, 0fH, 017H, 016H, 00H
	ORG $+2
	DD	00H
	DD	00H
	DD	FLAT:_con_write
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DB	00H
	ORG $+1023
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DB	00H
	ORG $+1023
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DB	00H
	ORG $+1023
	DD	00H
	DD	00H
	DD	03bH
	DD	00H
	DB	00H
	DB	03H, 01cH, 07fH, 015H, 04H, 00H, 01H, 00H, 011H, 013H, 01aH
	DB	00H, 012H, 0fH, 017H, 016H, 00H
	ORG $+2
	DD	00H
	DD	00H
	DD	FLAT:_rs_write
	DD	03f8H
	DD	00H
	DD	00H
	DD	00H
	DB	00H
	ORG $+1023
	DD	03f8H
	DD	00H
	DD	00H
	DD	00H
	DB	00H
	ORG $+1023
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DB	00H
	ORG $+1023
	DD	00H
	DD	00H
	DD	03bH
	DD	00H
	DB	00H
	DB	03H, 01cH, 07fH, 015H, 04H, 00H, 01H, 00H, 011H, 013H, 01aH
	DB	00H, 012H, 0fH, 017H, 016H, 00H
	ORG $+2
	DD	00H
	DD	00H
	DD	FLAT:_rs_write
	DD	02f8H
	DD	00H
	DD	00H
	DD	00H
	DB	00H
	ORG $+1023
	DD	02f8H
	DD	00H
	DD	00H
	DD	00H
	DB	00H
	ORG $+1023
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DB	00H
	ORG $+1023
_table_list DD	FLAT:_tty_table+48
	DD	FLAT:_tty_table+1088
	DD	FLAT:_tty_table+3216
	DD	FLAT:_tty_table+4256
	DD	FLAT:_tty_table+6384
	DD	FLAT:_tty_table+7424
_DATA	ENDS
PUBLIC	_tty_init
EXTRN	_rs_init:NEAR
EXTRN	_con_init:NEAR
_TEXT	SEGMENT
_tty_init PROC NEAR

; 123  : 	rs_init ();			// ��ʼ�������жϳ���ʹ��нӿ�1 ��2��(serial.c, 37)

	call	_rs_init

; 124  : 	con_init ();			// ��ʼ������̨�նˡ�(console.c, 617)

	jmp	_con_init
_tty_init ENDP
_TEXT	ENDS
PUBLIC	_tty_intr
EXTRN	_task:BYTE
_TEXT	SEGMENT
_tty$ = 8
_mask$ = 12
_tty_intr PROC NEAR

; 130  : {

	push	ebp
	mov	ebp, esp

; 131  : 	int i;
; 132  : 
; 133  : // ���tty �������С�ڵ���0�����˳���
; 134  : 	if (tty->pgrp <= 0)

	mov	eax, DWORD PTR _tty$[ebp]
	mov	edx, DWORD PTR [eax+36]
	test	edx, edx
	jle	SHORT $L710
	push	esi

; 135  : 		return;
; 136  : // ɨ���������飬��tty ��Ӧ�������������ָ�����źš�
; 137  : 	for (i = 0; i < NR_TASKS; i++) {

	mov	esi, DWORD PTR _mask$[ebp]
	mov	ecx, OFFSET FLAT:_task
$L708:

; 138  : 		// �����������ָ�벻Ϊ�գ���������ŵ���tty ��ţ������ø�����ָ�����ź�mask��
; 139  : 		if (task[i] && task[i]->pgrp == tty->pgrp)

	mov	eax, DWORD PTR [ecx]
	test	eax, eax
	je	SHORT $L709
	cmp	DWORD PTR [eax+564], edx
	jne	SHORT $L709

; 140  : 			task[i]->signal |= mask;

	or	DWORD PTR [eax+12], esi
$L709:
	add	ecx, 4
	cmp	ecx, OFFSET FLAT:_task+256
	jl	SHORT $L708
	pop	esi
$L710:

; 141  : 	}
; 142  : }

	pop	ebp
	ret	0
_tty_intr ENDP
_TEXT	ENDS
PUBLIC	_wait_for_keypress
_TEXT	SEGMENT
_wait_for_keypress PROC NEAR

; 179  : 	sleep_if_empty (&tty_table[0].secondary);

	push	OFFSET FLAT:_tty_table+2128
	call	_sleep_if_empty
	pop	ecx

; 180  : }

	ret	0
_wait_for_keypress ENDP
_TEXT	ENDS
EXTRN	_current:DWORD
EXTRN	_interruptible_sleep_on:NEAR
_TEXT	SEGMENT
_queue$ = 8
_sleep_if_empty PROC NEAR

; 149  : {

	push	ebp
	mov	ebp, esp
	push	esi

; 150  : 	cli ();			// ���жϡ�

	cli

; 151  : // ����ǰ����û���ź�Ҫ������ָ���Ķ��л������գ����ý��̽�����ж�˯��״̬������
; 152  : // ���еĽ��̵ȴ�ָ��ָ��ý��̡�
; 153  : 	while (!current->signal && EMPTY (*queue))

	mov	eax, DWORD PTR _current
	mov	ecx, DWORD PTR [eax+12]
	test	ecx, ecx
	jne	SHORT $L718
	mov	esi, DWORD PTR _queue$[ebp]
$L717:
	mov	ecx, DWORD PTR [esi+4]
	mov	eax, DWORD PTR [esi+8]
	cmp	ecx, eax
	jne	SHORT $L718

; 154  : 		interruptible_sleep_on (&queue->proc_list);

	lea	edx, DWORD PTR [esi+12]
	push	edx
	call	_interruptible_sleep_on
	mov	eax, DWORD PTR _current
	add	esp, 4
	mov	ecx, DWORD PTR [eax+12]
	test	ecx, ecx
	je	SHORT $L717
$L718:

; 155  : 	sti ();			// ���жϡ�

	sti
	pop	esi

; 156  : }

	pop	ebp
	ret	0
_sleep_if_empty ENDP
_TEXT	ENDS
PUBLIC	_copy_to_cooked
EXTRN	__ctype:BYTE
EXTRN	__ctmp:BYTE
EXTRN	_wake_up:NEAR
_TEXT	SEGMENT
_tty$ = 8
_copy_to_cooked PROC NEAR

; 186  : {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi

; 187  : 	signed char c;
; 188  : 
; 189  : // ���tty �Ķ����л��������ղ��Ҹ������л�����Ϊ�գ���ѭ��ִ�����д��롣
; 190  : 	while (!EMPTY (tty->read_q) && !FULL (tty->secondary))

	mov	esi, DWORD PTR _tty$[ebp]
	push	edi
	mov	eax, DWORD PTR [esi+56]
	mov	ecx, DWORD PTR [esi+52]
	cmp	ecx, eax
	je	$L736
$L735:
	mov	ecx, DWORD PTR [esi+2136]
	mov	edi, DWORD PTR [esi+2132]
	sub	ecx, edi
	dec	ecx
	test	ecx, 1023				; 000003ffH
	je	$L736

; 191  : 	{
; 192  : // �Ӷ���β��ȡһ�ַ���c����ǰ��βָ�롣
; 193  : 		GETCH (tty->read_q, c);

	mov	bl, BYTE PTR [eax+esi+64]
	inc	eax
	and	eax, 1023				; 000003ffH

; 194  : // ����������ַ�����������ģʽ��־�����д���
; 195  : // ������ַ��ǻس���CR(13)�������س�ת���б�־CRNL ��λ�򽫸��ַ�ת��Ϊ���з�NL(10)��
; 196  : // ���������Իس���־NOCR ��λ������Ը��ַ����������������ַ���
; 197  : 		if (c == 13) {

	cmp	bl, 13					; 0000000dH
	mov	DWORD PTR [esi+56], eax
	jne	SHORT $L738

; 198  : 			if (I_CRNL (tty))

	mov	eax, DWORD PTR [esi]
	test	ah, 1
	je	SHORT $L739

; 199  : 				c = 10;

	mov	bl, 10					; 0000000aH

; 200  : 			else if (I_NOCR (tty))

	jmp	SHORT $L744
$L739:
	test	al, 128					; 00000080H
	jne	$L894

; 201  : 				continue;
; 202  : 			else;
; 203  : // ������ַ��ǻ��з�NL(10)���һ���ת�س���־NLCR ��λ������ת��Ϊ�س���CR(13)��
; 204  : 		} else if (c == 10 && I_NLCR (tty))

	jmp	SHORT $L744
$L738:
	cmp	bl, 10					; 0000000aH
	jne	SHORT $L744
	test	BYTE PTR [esi], 64			; 00000040H
	je	SHORT $L744

; 205  : 			c = 13;

	mov	bl, 13					; 0000000dH
$L744:

; 206  : // �����дתСд��־UCLC ��λ���򽫸��ַ�ת��ΪСд�ַ���
; 207  : 		if (I_UCLC (tty))

	mov	eax, DWORD PTR [esi]
	test	ah, 2
	je	SHORT $L890

; 208  : 			c = tolower (c);

	mov	BYTE PTR __ctmp, bl
	movsx	ebx, bl
	test	BYTE PTR __ctype[ebx+1], 1
	je	SHORT $L890
	add	bl, 32					; 00000020H
$L890:

; 209  : // �������ģʽ��־���й淶���죩ģʽ��־CANON ��λ����������´���
; 210  : 		if (L_CANON (tty))

	mov	ecx, DWORD PTR [esi+12]
	test	cl, 2
	je	$L763

; 211  : 		{
; 212  : // ������ַ��Ǽ�����ֹ�����ַ�KILL(^U)�������ɾ�������д���
; 213  : 			if (c == KILL_CHAR (tty))

	movsx	eax, bl
	xor	edx, edx
	mov	dl, BYTE PTR [esi+20]
	cmp	eax, edx
	jne	$L747

; 214  : 			{
; 215  : /* deal with killing the input line *//* ɾ�������д��� */
; 216  : // ���tty �������в��գ����߸������������һ���ַ��ǻ���NL(10)�����߸��ַ����ļ������ַ�
; 217  : // (^D)����ѭ��ִ�����д��롣
; 218  : 				while (!(EMPTY (tty->secondary) ||
; 219  : 					(c = LAST (tty->secondary)) == 10 ||
; 220  : 					c == EOF_CHAR (tty)))

	cmp	edi, DWORD PTR [esi+2136]
	je	$L894
$L749:
	mov	eax, DWORD PTR [esi+2132]
	dec	eax
	and	eax, 1023				; 000003ffH
	mov	al, BYTE PTR [eax+esi+2144]
	cmp	al, 10					; 0000000aH
	je	$L894
	xor	ecx, ecx
	mov	cl, BYTE PTR [esi+21]
	movsx	edx, al
	cmp	edx, ecx
	je	$L894

; 221  : 				{
; 222  : // ������ػ��Ա�־ECHO ��λ����ô�����ַ��ǿ����ַ�(ֵ<32)������tty ��д�����з������
; 223  : // �ַ�ERASE���ٷ���һ�������ַ�ERASE�����ҵ��ø�tty ��д������
; 224  : 					if (L_ECHO (tty))

	test	BYTE PTR [esi+12], 8
	je	SHORT $L751

; 225  : 					{
; 226  : 						if (c < 32)

	cmp	al, 32					; 00000020H
	jge	SHORT $L752

; 227  : 							PUTCH (127, tty->write_q);

	mov	eax, DWORD PTR [esi+1092]
	mov	BYTE PTR [eax+esi+1104], 127		; 0000007fH
	mov	ecx, DWORD PTR [esi+1092]
	inc	ecx
	and	ecx, 1023				; 000003ffH
	mov	DWORD PTR [esi+1092], ecx
$L752:

; 228  : 						PUTCH (127, tty->write_q);

	mov	edx, DWORD PTR [esi+1092]

; 229  : 						tty->write (tty);

	push	esi
	mov	BYTE PTR [edx+esi+1104], 127		; 0000007fH
	mov	eax, DWORD PTR [esi+1092]
	inc	eax
	and	eax, 1023				; 000003ffH
	mov	DWORD PTR [esi+1092], eax
	call	DWORD PTR [esi+44]
	add	esp, 4
$L751:

; 230  : 					}
; 231  : // ��tty ��������ͷָ�����1 �ֽڡ�
; 232  : 					DEC (tty->secondary.head);

	mov	eax, DWORD PTR [esi+2132]
	mov	ecx, DWORD PTR [esi+2136]
	dec	eax
	and	eax, 1023				; 000003ffH
	cmp	eax, ecx
	mov	DWORD PTR [esi+2132], eax
	jne	$L749

; 233  : 				}
; 234  : 				continue;		// ������ȡ�����������ַ���

	jmp	$L894
$L747:

; 235  : 			}
; 236  : // ������ַ���ɾ�������ַ�ERASE(^H)����ô��
; 237  : 			if (c == ERASE_CHAR (tty))

	xor	edx, edx
	mov	dl, BYTE PTR [esi+19]
	cmp	eax, edx
	jne	$L755

; 238  : 			{
; 239  : // ��tty �ĸ�������Ϊ�գ����������һ���ַ��ǻ��з�NL(10)���������ļ�����������������
; 240  : // �����ַ���
; 241  : 				if (EMPTY (tty->secondary) ||
; 242  : 					(c = LAST (tty->secondary)) == 10 || c == EOF_CHAR (tty))

	cmp	edi, DWORD PTR [esi+2136]
	je	$L894
	dec	edi
	and	edi, 1023				; 000003ffH
	mov	al, BYTE PTR [edi+esi+2144]
	cmp	al, 10					; 0000000aH
	je	$L894
	xor	edx, edx
	mov	dl, BYTE PTR [esi+21]
	movsx	edi, al
	cmp	edi, edx
	je	$L894

; 243  : 					continue;
; 244  : // ������ػ��Ա�־ECHO ��λ����ô�����ַ��ǿ����ַ�(ֵ<32)������tty ��д�����з������
; 245  : // �ַ�ERASE���ٷ���һ�������ַ�ERASE�����ҵ��ø�tty ��д������
; 246  : 				if (L_ECHO (tty))

	test	cl, 8
	je	SHORT $L758

; 247  : 				{
; 248  : 					if (c < 32)

	cmp	al, 32					; 00000020H
	jge	SHORT $L759

; 249  : 						PUTCH (127, tty->write_q);

	mov	eax, DWORD PTR [esi+1092]
	mov	BYTE PTR [eax+esi+1104], 127		; 0000007fH
	mov	ecx, DWORD PTR [esi+1092]
	inc	ecx
	and	ecx, 1023				; 000003ffH
	mov	DWORD PTR [esi+1092], ecx
$L759:

; 250  : 					PUTCH (127, tty->write_q);

	mov	edx, DWORD PTR [esi+1092]

; 251  : 					tty->write (tty);

	push	esi
	mov	BYTE PTR [edx+esi+1104], 127		; 0000007fH
	mov	eax, DWORD PTR [esi+1092]
	inc	eax
	and	eax, 1023				; 000003ffH
	mov	DWORD PTR [esi+1092], eax
	call	DWORD PTR [esi+44]
	add	esp, 4
$L758:

; 252  : 				}
; 253  : // ��tty ��������ͷָ�����1 �ֽڣ��������������ַ���
; 254  : 				DEC (tty->secondary.head);

	mov	ecx, DWORD PTR [esi+2132]
	dec	ecx
	and	ecx, 1023				; 000003ffH
	mov	DWORD PTR [esi+2132], ecx

; 255  : 				continue;

	jmp	$L894
$L755:

; 256  : 			}
; 257  : //������ַ���ֹͣ�ַ�(^S)������tty ֹͣ��־���������������ַ���
; 258  : 			if (c == STOP_CHAR (tty))

	xor	edx, edx
	mov	dl, BYTE PTR [esi+26]
	cmp	eax, edx
	jne	SHORT $L762

; 259  : 			{
; 260  : 				tty->stopped = 1;

	mov	DWORD PTR [esi+40], 1

; 261  : 				continue;

	jmp	$L894
$L762:

; 262  : 			}
; 263  : // ������ַ���ֹͣ�ַ�(^Q)����λtty ֹͣ��־���������������ַ���
; 264  : 			if (c == START_CHAR (tty))

	xor	edx, edx
	mov	dl, BYTE PTR [esi+25]
	cmp	eax, edx
	jne	SHORT $L763

; 265  : 			{
; 266  : 				tty->stopped = 0;

	mov	DWORD PTR [esi+40], 0

; 267  : 				continue;

	jmp	$L894
$L763:

; 268  : 			}
; 269  : 		}
; 270  : // ������ģʽ��־����ISIG ��־��λ�������յ�INTR��QUIT��SUSP ��DSUSP �ַ�ʱ����ҪΪ����
; 271  : // ������Ӧ���źš�
; 272  : 		if (L_ISIG (tty))

	test	cl, 1
	je	SHORT $L766

; 273  : 		{
; 274  : // ������ַ��Ǽ����жϷ�(^C)������ǰ���̷��ͼ����ж��źţ�������������һ�ַ���
; 275  : 			if (c == INTR_CHAR (tty))

	movsx	eax, bl
	xor	edx, edx
	mov	dl, BYTE PTR [esi+17]
	cmp	eax, edx
	jne	SHORT $L765

; 276  : 			{
; 277  : 				tty_intr (tty, INTMASK);

	push	2
	push	esi
	call	_tty_intr
	add	esp, 8

; 278  : 				continue;

	jmp	$L894
$L765:

; 279  : 			}
; 280  : // ������ַ��Ǽ����жϷ�(^\)������ǰ���̷��ͼ����˳��źţ�������������һ�ַ���
; 281  : 			if (c == QUIT_CHAR (tty))

	xor	edx, edx
	mov	dl, BYTE PTR [esi+18]
	cmp	eax, edx
	jne	SHORT $L766

; 282  : 			{
; 283  : 				tty_intr (tty, QUITMASK);

	push	4
	push	esi
	call	_tty_intr
	add	esp, 8

; 284  : 				continue;

	jmp	$L894
$L766:

; 285  : 			}
; 286  : 		}
; 287  : // ������ַ��ǻ��з�NL(10)���������ļ�������EOF(^D)��������������ַ�����1��[??]
; 288  : 		if (c == 10 || c == EOF_CHAR (tty))

	cmp	bl, 10					; 0000000aH
	je	SHORT $L768
	xor	eax, eax
	mov	al, BYTE PTR [esi+21]
	movsx	edx, bl
	cmp	edx, eax
	jne	SHORT $L767
$L768:

; 289  : 			tty->secondary.data++;

	inc	DWORD PTR [esi+2128]
$L767:

; 290  : // �������ģʽ��־���л��Ա�־ECHO ��λ����ô������ַ��ǻ��з�NL(10)���򽫻��з�NL(10)
; 291  : // �ͻس���CR(13)����tty д���л������У�����ַ��ǿ����ַ�(�ַ�ֵ<32)���һ��Կ����ַ���־
; 292  : // ECHOCTL ��λ�����ַ�'^'���ַ�c+64 ����tty д������(Ҳ������ʾ^C��^H ��)�����򽫸��ַ�
; 293  : // ֱ�ӷ���tty д��������С������ø�tty ��д����������
; 294  : 		if (L_ECHO (tty))

	test	cl, 8
	je	$L769

; 295  : 		{
; 296  : 			if (c == 10)

	cmp	bl, 10					; 0000000aH
	jne	SHORT $L770

; 297  : 			{
; 298  : 				PUTCH (10, tty->write_q);

	mov	eax, DWORD PTR [esi+1092]
	mov	BYTE PTR [eax+esi+1104], bl
	mov	eax, DWORD PTR [esi+1092]
	inc	eax
	and	eax, 1023				; 000003ffH
	mov	DWORD PTR [esi+1092], eax

; 299  : 				PUTCH (13, tty->write_q);

	mov	BYTE PTR [eax+esi+1104], 13		; 0000000dH

; 300  : 			}
; 301  : 			else if (c < 32)

	jmp	SHORT $L897
$L770:
	cmp	bl, 32					; 00000020H
	jge	SHORT $L774

; 302  : 			{
; 303  : 				if (L_ECHOCTL (tty))

	test	ch, 2
	je	SHORT $L778

; 304  : 				{
; 305  : 					PUTCH ('^', tty->write_q);

	mov	edx, DWORD PTR [esi+1092]

; 306  : 					PUTCH (c + 64, tty->write_q);

	mov	cl, bl
	add	cl, 64					; 00000040H
	mov	BYTE PTR [edx+esi+1104], 94		; 0000005eH
	mov	eax, DWORD PTR [esi+1092]
	inc	eax
	and	eax, 1023				; 000003ffH
	mov	DWORD PTR [esi+1092], eax
	mov	BYTE PTR [eax+esi+1104], cl
	mov	edx, DWORD PTR [esi+1092]
	inc	edx
	and	edx, 1023				; 000003ffH
	mov	DWORD PTR [esi+1092], edx

; 307  : 				}
; 308  : 			}
; 309  : 			else

	jmp	SHORT $L778
$L774:

; 310  : 				PUTCH (c, tty->write_q);

	mov	eax, DWORD PTR [esi+1092]
	mov	BYTE PTR [eax+esi+1104], bl
$L897:
	mov	ecx, DWORD PTR [esi+1092]
	inc	ecx
	and	ecx, 1023				; 000003ffH
	mov	DWORD PTR [esi+1092], ecx
$L778:

; 311  : 			tty->write (tty);

	push	esi
	call	DWORD PTR [esi+44]
	add	esp, 4
$L769:

; 312  : 		}
; 313  : // �����ַ����븨�������С�
; 314  : 		PUTCH (c, tty->secondary);

	mov	edx, DWORD PTR [esi+2132]
	mov	BYTE PTR [esi+edx+2144], bl
	mov	eax, DWORD PTR [esi+2132]
	inc	eax
	and	eax, 1023				; 000003ffH
	mov	DWORD PTR [esi+2132], eax
$L894:
	mov	eax, DWORD PTR [esi+56]
	mov	ecx, DWORD PTR [esi+52]
	cmp	ecx, eax
	jne	$L735
$L736:

; 315  : 	}
; 316  : // ���ѵȴ��ø���������еĽ��̣�����еĻ�����
; 317  : 	wake_up (&tty->secondary.proc_list);

	add	esi, 2140				; 0000085cH
	push	esi
	call	_wake_up
	add	esp, 4
	pop	edi
	pop	esi
	pop	ebx

; 318  : }

	pop	ebp
	ret	0
_copy_to_cooked ENDP
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

; 276  : 		cmp ecx, current/* ����n �ǵ�ǰ������?(current ==task[n]?) */ 

	cmp	ecx, DWORD PTR _current

; 277  : 		je l1 /* �ǣ���ʲô���������˳���*/ 

	je	SHORT $l1$504

; 278  : 		xchg ecx,current/* current = task[n]�� */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*ִ�г���ת����������л� (ͷ���˺ܳ�ʱ�䣬������)*/
; 280  : 		mov ax, __tmp

	mov	ax, WORD PTR ___tmp$[ebp]

; 281  : 		mov word ptr ds:[lcs],ax

	mov	WORD PTR ds:$lcs$505, ax

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
$lcs$505:

; 287  : lcs:	_emit 0		// cs

	DB	0

; 288  : 		_emit 0

	DB	0

; 289  : // �������л�������Ż����ִ���������䡣
; 290  : 		cmp last_task_used_math,ecx /* �������ϴ�ʹ�ù�Э��������*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$504

; 292  : 		clts/* �������ϴ�ʹ�ù�Э������������cr0 ��TS ��־��*/

	clts
$l1$504:

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
PUBLIC	_tty_read
EXTRN	_jiffies:DWORD
_TEXT	SEGMENT
_channel$ = 8
_buf$ = 12
_nr$ = 16
_c$ = 11
_b$ = -4
_minimum$ = -12
_flag$ = -8
_oldalarm$ = -16
$T924 = -20
_tty_read PROC NEAR

; 324  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 20					; 00000014H

; 329  : 
; 330  : // ���汾linux �ں˵��ն�ֻ��3 �����豸���ֱ��ǿ���̨(0)�������ն�1(1)�ʹ����ն�2(2)��
; 331  : // �����κδ���2 �����豸�Ŷ��ǷǷ��ġ�д���ֽ�����ȻҲ����С��0 �ġ�
; 332  : 	if (channel > 2 || nr < 0)

	mov	ecx, DWORD PTR _channel$[ebp]
	mov	eax, DWORD PTR _buf$[ebp]
	push	ebx
	push	esi
	cmp	ecx, 2
	push	edi
	mov	DWORD PTR _b$[ebp], eax
	mov	DWORD PTR _flag$[ebp], 0
	ja	$L796
	mov	ebx, DWORD PTR _nr$[ebp]
	test	ebx, ebx
	jl	$L796

; 334  : // tty ָ��ָ�����豸�Ŷ�Ӧttb_table ���е�tty �ṹ��
; 335  : 	tty = &tty_table[channel];

	mov	eax, ecx
	shl	eax, 5
	add	eax, ecx

; 336  : // �������ȱ������ԭ��ʱֵ��Ȼ����ݿ����ַ�VTIME ��VMIN ���ö��ַ������ĳ�ʱ��ʱֵ��
; 337  : // �ڷǹ淶ģʽ�£�������ֵ�ǳ�ʱ��ʱֵ��MIN ��ʾΪ���������������Ҫ��ȡ�������ַ�����
; 338  : // TIME ��һ��ʮ��֮һ������ļ�ʱֵ��
; 339  : // ����ȡ�����е�(����)��ʱֵ(�δ���)��
; 340  : 	oldalarm = current->alarm;

	mov	ecx, DWORD PTR _current
	lea	esi, DWORD PTR [eax+eax*2]
	mov	edx, DWORD PTR [ecx+588]
	shl	esi, 5
	add	esi, OFFSET FLAT:_tty_table

; 341  : // �����ö�������ʱ��ʱֵtime ����Ҫ���ٶ�ȡ���ַ�����minimum��
; 342  : 	time = 10L * tty->termios.c_cc[VTIME];

	xor	eax, eax
	mov	DWORD PTR _oldalarm$[ebp], edx
	mov	al, BYTE PTR [esi+22]
	lea	edi, DWORD PTR [eax+eax*4]

; 343  : 	minimum = tty->termios.c_cc[VMIN];

	xor	eax, eax
	mov	al, BYTE PTR [esi+23]
	shl	edi, 1

; 344  : // ��������˶���ʱ��ʱֵtime ��û���������ٶ�ȡ����minimum����ô�ڶ�������һ���ַ�����
; 345  : // ��ʱ��ʱ������������̷��ء�����������minimum=1��
; 346  : 	if (time && !minimum)

	test	edi, edi
	mov	DWORD PTR _minimum$[ebp], eax
	je	SHORT $L798
	test	eax, eax
	jne	SHORT $L798

; 347  : 	{
; 348  : 		minimum = 1;

	mov	eax, 1

; 349  : // �������ԭ��ʱֵ��0 ����time+��ǰϵͳʱ��ֵС�ڽ���ԭ��ʱֵ�Ļ��������������ý��̶�ʱ
; 350  : // ֵΪtime+��ǰϵͳʱ�䣬����flag ��־��
; 351  : 		if (flag = (!oldalarm || time + jiffies < oldalarm))

	test	edx, edx
	mov	DWORD PTR _minimum$[ebp], eax
	je	SHORT $L917
	mov	edx, DWORD PTR _jiffies
	add	edx, edi
	cmp	edx, DWORD PTR _oldalarm$[ebp]
	jl	SHORT $L917
	mov	DWORD PTR _flag$[ebp], 0
	jmp	SHORT $L798
$L917:
	mov	DWORD PTR _flag$[ebp], eax

; 352  : 			current->alarm = time + jiffies;

	mov	eax, DWORD PTR _jiffies
	add	eax, edi
	mov	DWORD PTR [ecx+588], eax
$L798:

; 353  : 	}
; 354  : // ������õ����ٶ�ȡ�ַ���>�������ַ�������������ڴ˴�����ȡ���ַ�����
; 355  : 	if (minimum > nr)

	cmp	DWORD PTR _minimum$[ebp], ebx
	jle	SHORT $L925

; 356  : 		minimum = nr;

	mov	DWORD PTR _minimum$[ebp], ebx
$L925:

; 357  : // ���������ֽ���>0����ѭ��ִ�����²�����
; 358  : 	while (nr > 0)

	test	ebx, ebx
	jle	$L931
$L801:

; 359  : 	{
; 360  : // ���flag ��Ϊ0(������ԭ��ʱֵ��0 ����time+��ǰϵͳʱ��ֵС�ڽ���ԭ��ʱֵ)���ҽ����ж�
; 361  : // ʱ�ź�SIGALRM����λ���̵Ķ�ʱ�źŲ��ж�ѭ����
; 362  : 		if (flag && (current->signal & ALRMMASK))

	mov	eax, DWORD PTR _flag$[ebp]
	test	eax, eax
	je	SHORT $L803
	mov	eax, DWORD PTR [ecx+12]
	test	ah, 32					; 00000020H
	jne	$L929
$L803:

; 365  : 			break;
; 366  : 		}
; 367  : // �����ǰ�������ź�Ҫ�������˳�������0��
; 368  : 		if (current->signal)

	mov	eax, DWORD PTR [ecx+12]
	test	eax, eax
	jne	$L931

; 369  : 			break;
; 370  : // ��������������(�淶ģʽ����)Ϊ�գ����������˹淶ģʽ��־���Ҹ����������ַ���Ϊ0 �Լ�
; 371  : // ����ģʽ������п��пռ�>20���������ж�˯��״̬�����غ��������
; 372  : 		if (EMPTY (tty->secondary) || (L_CANON (tty) &&
; 373  : 					 !tty->secondary.data
; 374  : 					 && LEFT (tty->secondary) > 20))

	mov	ecx, DWORD PTR [esi+2132]
	mov	eax, DWORD PTR [esi+2136]
	cmp	ecx, eax
	je	$L806
	test	BYTE PTR [esi+12], 2
	je	SHORT $L807
	mov	edx, DWORD PTR [esi+2128]
	test	edx, edx
	jne	SHORT $L807
	mov	edx, eax
	sub	edx, ecx
	dec	edx
	and	edx, 1023				; 000003ffH
	cmp	edx, 20					; 00000014H
	ja	$L806
$L807:

; 377  : 			continue;
; 378  : 		}
; 379  : // ִ�����²�����ֱ��nr=0 ���߸����������Ϊ�ա�
; 380  : 		do {
; 381  : // ȡ������������ַ�c��
; 382  : 			GETCH (tty->secondary, c);

	mov	cl, BYTE PTR [eax+esi+2144]
	inc	eax
	and	eax, 1023				; 000003ffH

; 383  : // ������ַ����ļ�������(^D)�����ǻ��з�NL(10)��������������ַ�����1��
; 384  : 			if (c == EOF_CHAR (tty) || c == 10)

	xor	edx, edx
	mov	DWORD PTR [esi+2136], eax
	mov	dl, BYTE PTR [esi+21]
	movsx	eax, cl
	cmp	eax, edx
	mov	BYTE PTR _c$[ebp], cl
	je	SHORT $L812
	cmp	cl, 10					; 0000000aH
	jne	SHORT $L811
$L812:

; 385  : 				tty->secondary.data--;

	dec	DWORD PTR [esi+2128]
$L811:

; 386  : // ������ַ����ļ�������(^D)���ҹ淶ģʽ��־��λ���򷵻��Ѷ��ַ��������˳���
; 387  : 			if (c == EOF_CHAR (tty) && L_CANON (tty))

	xor	ecx, ecx
	mov	cl, BYTE PTR [esi+21]
	cmp	eax, ecx
	jne	SHORT $L813
	test	BYTE PTR [esi+12], 2
	jne	$L927
$L813:

; 388  : 				return (b - buf);
; 389  : // ���򽫸��ַ������û����ݶλ�����buf �У������ַ�����1����������ַ�����Ϊ0�����ж�ѭ����
; 390  : 			else
; 391  : 			{
; 392  : 				put_fs_byte (c, b++);

	mov	eax, DWORD PTR _b$[ebp]
	mov	DWORD PTR $T924[ebp], eax
	inc	eax
	mov	DWORD PTR _b$[ebp], eax

; 325  : 	struct tty_struct *tty;
; 326  : 	char c, *b = buf;

	mov	ebx, DWORD PTR $T924[ebp]

; 327  : 	int minimum, time, flag = 0;

	mov	al, BYTE PTR _c$[ebp]

; 328  : 	long oldalarm;

	mov	BYTE PTR fs:[ebx], al

; 393  : 				if (!--nr)

	mov	eax, DWORD PTR _nr$[ebp]
	dec	eax
	mov	DWORD PTR _nr$[ebp], eax
	je	SHORT $L809

; 394  : 				break;
; 395  : 			}
; 396  : 		} while (nr > 0 && !EMPTY (tty->secondary));

	test	eax, eax
	jle	SHORT $L809
	mov	eax, DWORD PTR [esi+2136]
	mov	ecx, DWORD PTR [esi+2132]
	cmp	ecx, eax
	jne	SHORT $L807
$L809:

; 397  : // �����ʱ��ʱֵtime ��Ϊ0 ���ҹ淶ģʽ��־û����λ(�ǹ淶ģʽ)����ô��
; 398  : 		if (time && !L_CANON (tty))

	mov	ecx, DWORD PTR _current
	test	edi, edi
	je	SHORT $L819
	test	BYTE PTR [esi+12], 2
	jne	SHORT $L947

; 399  : // �������ԭ��ʱֵ��0 ����time+��ǰϵͳʱ��ֵС�ڽ���ԭ��ʱֵ�Ļ��������������ý��̶�ʱֵ
; 400  : // Ϊtime+��ǰϵͳʱ�䣬����flag ��־�������ý��̵Ķ�ʱֵ���ڽ���ԭ��ʱֵ��
; 401  : 		if (flag = (!oldalarm || time + jiffies < oldalarm))

	mov	eax, DWORD PTR _oldalarm$[ebp]
	test	eax, eax
	je	SHORT $L919
	mov	edx, DWORD PTR _jiffies
	add	edx, edi
	cmp	edx, eax
	jl	SHORT $L919
	mov	DWORD PTR _flag$[ebp], 0
	jmp	SHORT $L818
$L919:
	mov	DWORD PTR _flag$[ebp], 1

; 402  : 			current->alarm = time + jiffies;

	mov	eax, DWORD PTR _jiffies
	add	eax, edi
$L818:

; 403  : 		else
; 404  : 			current->alarm = oldalarm;

	mov	DWORD PTR [ecx+588], eax
$L819:

; 405  : // ����淶ģʽ��־��λ����ô��û�ж���1 ���ַ����ж�ѭ�����������Ѷ�ȡ�����ڻ��������Ҫ
; 406  : // ���ȡ���ַ�������Ҳ�ж�ѭ����
; 407  : 		if (L_CANON (tty))

	test	BYTE PTR [esi+12], 2
	je	SHORT $L820
$L947:

; 408  : 		{
; 409  : 			if (b - buf)

	mov	edx, DWORD PTR _b$[ebp]
	mov	eax, DWORD PTR _buf$[ebp]
	sub	edx, eax
	jne	SHORT $L931

; 410  : 			break;
; 411  : 		}
; 412  : 		else if (b - buf >= minimum)

	mov	ebx, DWORD PTR _nr$[ebp]
	jmp	SHORT $L933
$L820:
	mov	eax, DWORD PTR _b$[ebp]
	mov	ebx, DWORD PTR _buf$[ebp]
	mov	edx, DWORD PTR _minimum$[ebp]
	sub	eax, ebx
	cmp	eax, edx
	jge	SHORT $L931

; 413  : 			break;
; 414  : 	}

	mov	ebx, DWORD PTR _nr$[ebp]
	jmp	SHORT $L933
$L806:

; 375  : 		{
; 376  : 			sleep_if_empty (&tty->secondary);

	lea	ecx, DWORD PTR [esi+2128]
	push	ecx
	call	_sleep_if_empty
	mov	ecx, DWORD PTR _current
	add	esp, 4
$L933:

; 357  : // ���������ֽ���>0����ѭ��ִ�����²�����
; 358  : 	while (nr > 0)

	test	ebx, ebx
	jg	$L801

; 410  : 			break;
; 411  : 		}
; 412  : 		else if (b - buf >= minimum)

	jmp	SHORT $L931
$L929:

; 363  : 		{
; 364  : 			current->signal &= ~ALRMMASK;

	mov	eax, DWORD PTR [ecx+12]
	and	ah, -33					; ffffffdfH
	mov	DWORD PTR [ecx+12], eax
$L931:

; 415  : // �ý��̵Ķ�ʱֵ���ڽ���ԭ��ʱֵ��
; 416  : 	current->alarm = oldalarm;

	mov	edx, DWORD PTR _oldalarm$[ebp]
	mov	DWORD PTR [ecx+588], edx

; 417  : // ����������źŲ���û�ж�ȡ�κ��ַ����򷵻س���ţ���ʱ����
; 418  : 	if (current->signal && !(b - buf))

	mov	eax, DWORD PTR [ecx+12]
	test	eax, eax
	je	SHORT $L927
	mov	eax, DWORD PTR _b$[ebp]
	mov	ecx, DWORD PTR _buf$[ebp]
	sub	eax, ecx
	jne	SHORT $L927
	pop	edi
	pop	esi

; 419  : 		return -EINTR;

	mov	eax, -4					; fffffffcH
	pop	ebx

; 421  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L927:

; 420  : 	return (b - buf);		// �����Ѷ�ȡ���ַ�����

	mov	eax, DWORD PTR _b$[ebp]
	mov	ecx, DWORD PTR _buf$[ebp]
	pop	edi
	pop	esi
	sub	eax, ecx
	pop	ebx

; 421  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L796:
	pop	edi
	pop	esi

; 333  : 		return -1;

	or	eax, -1
	pop	ebx

; 421  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_tty_read ENDP
_TEXT	ENDS
PUBLIC	_tty_write
EXTRN	_schedule:NEAR
_TEXT	SEGMENT
_channel$ = 8
_buf$ = 12
_nr$ = 16
_b$ = -4
_tty_write PROC NEAR

; 427  : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 433  : // �����κδ���2 �����豸�Ŷ��ǷǷ��ġ�д���ֽ�����ȻҲ����С��0 �ġ�
; 434  : 	if (channel > 2 || nr < 0)

	mov	ecx, DWORD PTR _channel$[ebp]
	mov	eax, DWORD PTR _buf$[ebp]
	cmp	ecx, 2
	push	edi
	mov	DWORD PTR _b$[ebp], eax
	ja	$L838
	mov	edi, DWORD PTR _nr$[ebp]
	test	edi, edi
	jl	$L838

; 436  : // tty ָ��ָ�����豸�Ŷ�Ӧttb_table ���е�tty �ṹ��
; 437  : 	tty = channel + tty_table;

	mov	eax, ecx
	push	ebx
	shl	eax, 5
	add	eax, ecx
	push	esi
	lea	esi, DWORD PTR [eax+eax*2]
	shl	esi, 5
	add	esi, OFFSET FLAT:_tty_table

; 438  : // �ַ��豸��һ��һ���ַ����д���ģ������������nr ����0 ʱ��ÿ���ַ�����ѭ������
; 439  : 	while (nr > 0)

	test	edi, edi
	jle	$L957
$L840:

; 440  : 	{
; 441  : // �����ʱtty ��д������������ǰ���̽�����жϵ�˯��״̬��
; 442  : 		sleep_if_full (&tty->write_q);

	lea	eax, DWORD PTR [esi+1088]
	push	eax
	call	_sleep_if_full

; 443  : // �����ǰ�������ź�Ҫ�������˳�������0��
; 444  : 		if (current->signal)

	mov	ecx, DWORD PTR _current
	add	esp, 4
	mov	eax, DWORD PTR [ecx+12]
	test	eax, eax
	jne	$L957
$L844:

; 445  : 			break;
; 446  : // ��Ҫд���ֽ���>0 ����tty ��д���в���ʱ��ѭ��ִ�����²�����
; 447  : 		while (nr > 0 && !FULL (tty->write_q))

	mov	edx, DWORD PTR [esi+1096]
	mov	ebx, DWORD PTR [esi+1092]
	sub	edx, ebx
	dec	edx
	test	edx, 1023				; 000003ffH
	je	$L845

; 428  : 	static cr_flag = 0;
; 429  : 	struct tty_struct *tty;
; 430  : 	char c, *b = buf;
; 431  : 

	mov	ebx, DWORD PTR _b$[ebp]

; 432  : // ���汾linux �ں˵��ն�ֻ��3 �����豸���ֱ��ǿ���̨(0)�������ն�1(1)�ʹ����ն�2(2)��

	mov	al, BYTE PTR fs:[ebx]

; 448  : 		{
; 449  : // ���û����ݶ��ڴ���ȡһ�ֽ�c��
; 450  : 			c = get_fs_byte (b);
; 451  : // ����ն����ģʽ��־���е�ִ����������־OPOST ��λ����ִ���������ʱ������̡�
; 452  : 			if (O_POST (tty))

	mov	ecx, DWORD PTR [esi+4]
	test	cl, 1
	je	SHORT $L950

; 453  : 			{
; 454  : // ������ַ��ǻس���'\r'(CR��13)���һس���ת���з���־OCRNL ��λ���򽫸��ַ����ɻ��з�
; 455  : // '\n'(NL��10)������������ַ��ǻ��з�'\n'(NL��10)���һ���ת�س����ܱ�־ONLRET ��λ�Ļ���
; 456  : // �򽫸��ַ����ɻس���'\r'(CR��13)��
; 457  : 				if (c == '\r' && O_CRNL (tty))

	cmp	al, 13					; 0000000dH
	jne	SHORT $L847
	test	cl, 8
	je	SHORT $L850

; 458  : 					c = '\n';

	mov	al, 10					; 0000000aH
$L959:

; 461  : // ������ַ��ǻ��з�'\n'���һس���־cr_flag û����λ������ת�س�-���б�־ONLCR ��λ�Ļ���
; 462  : // ��cr_flag ��λ������һ�س�������д�����С�Ȼ�����������һ���ַ���
; 463  : 				if (c == '\n' && !cr_flag && O_NLCR (tty))

	mov	edx, DWORD PTR _?cr_flag@?1??tty_write@@9@9
	test	edx, edx
	jne	SHORT $L850
	test	cl, 4
	je	SHORT $L850

; 464  : 				{
; 465  : 					cr_flag = 1;
; 466  : 					PUTCH (13, tty->write_q);

	mov	eax, DWORD PTR [esi+1092]
	mov	DWORD PTR _?cr_flag@?1??tty_write@@9@9, 1
	mov	BYTE PTR [eax+esi+1104], 13		; 0000000dH
	mov	ecx, DWORD PTR [esi+1092]
	inc	ecx
	and	ecx, 1023				; 000003ffH
	mov	DWORD PTR [esi+1092], ecx

; 467  : 					continue;

	jmp	SHORT $L958
$L847:

; 459  : 				else if (c == '\n' && O_NLRET (tty))

	cmp	al, 10					; 0000000aH
	jne	SHORT $L850
	test	cl, 32					; 00000020H
	je	SHORT $L959

; 460  : 					c = '\r';

	mov	al, 13					; 0000000dH
$L850:

; 468  : 				}
; 469  : // ���Сдת��д��־OLCUC ��λ�Ļ����ͽ����ַ�ת�ɴ�д�ַ���
; 470  : 				if (O_LCUC (tty))

	test	cl, 2
	je	SHORT $L950

; 471  : 					c = toupper (c);

	mov	BYTE PTR __ctmp, al
	movsx	eax, al
	test	BYTE PTR __ctype[eax+1], 2
	je	SHORT $L950
	sub	al, 32					; 00000020H
$L950:

; 472  : 			}
; 473  : // �û����ݻ���ָ��b ǰ��1 �ֽڣ���д�ֽ�����1 �ֽڣ���λcr_flag ��־���������ֽڷ���tty
; 474  : // д�����С�
; 475  : 			b++;
; 476  : 			nr--;
; 477  : 			cr_flag = 0;
; 478  : 			PUTCH (c, tty->write_q);

	mov	edx, DWORD PTR [esi+1092]
	mov	ecx, DWORD PTR _b$[ebp]
	inc	ecx
	dec	edi
	mov	BYTE PTR [edx+esi+1104], al
	mov	eax, DWORD PTR [esi+1092]
	inc	eax
	mov	DWORD PTR _b$[ebp], ecx
	and	eax, 1023				; 000003ffH
	mov	DWORD PTR _?cr_flag@?1??tty_write@@9@9, 0
	mov	DWORD PTR [esi+1092], eax
$L958:

; 445  : 			break;
; 446  : // ��Ҫд���ֽ���>0 ����tty ��д���в���ʱ��ѭ��ִ�����²�����
; 447  : 		while (nr > 0 && !FULL (tty->write_q))

	test	edi, edi
	jg	$L844
$L845:

; 479  : 		}
; 480  : // ���ֽ�ȫ��д�꣬����д���������������ִ�е�������ö�Ӧtty ��д�������������ֽ�Ҫд��
; 481  : // ��ȴ�д���в��������Ե��õ��ȳ�����ȥִ����������
; 482  : 		tty->write (tty);

	push	esi
	call	DWORD PTR [esi+44]
	add	esp, 4

; 483  : 		if (nr > 0)

	test	edi, edi
	jle	SHORT $L957

; 484  : 		schedule ();

	call	_schedule

; 438  : // �ַ��豸��һ��һ���ַ����д���ģ������������nr ����0 ʱ��ÿ���ַ�����ѭ������
; 439  : 	while (nr > 0)

	jmp	$L840
$L957:

; 485  : 	}
; 486  : 	return (b - buf);		// ����д����ֽ�����

	mov	eax, DWORD PTR _b$[ebp]
	mov	ecx, DWORD PTR _buf$[ebp]
	pop	esi
	pop	ebx
	sub	eax, ecx
	pop	edi

; 487  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L838:

; 435  : 		return -1;

	or	eax, -1
	pop	edi

; 487  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_tty_write ENDP
_queue$ = 8
_sleep_if_full PROC NEAR

; 163  : {

	push	ebp
	mov	ebp, esp
	push	esi

; 164  : // �����л������������򷵻��˳���
; 165  : 	if (!FULL (*queue))

	mov	esi, DWORD PTR _queue$[ebp]
	mov	eax, DWORD PTR [esi+8]
	mov	ecx, DWORD PTR [esi+4]
	sub	eax, ecx
	dec	eax
	test	eax, 1023				; 000003ffH
	jne	SHORT $L722

; 166  : 		return;
; 167  : 	cli ();			// ���жϡ�

	cli

; 168  : // �������û���ź���Ҫ�����Ҷ��л������п���ʣ��������<128�����ý��̽�����ж�˯��״̬��
; 169  : // ���øö��еĽ��̵ȴ�ָ��ָ��ý��̡�
; 170  : 	while (!current->signal && LEFT (*queue) < 128)

	mov	ecx, DWORD PTR _current
	mov	eax, DWORD PTR [ecx+12]
	test	eax, eax
	jne	SHORT $L726
$L725:
	mov	edx, DWORD PTR [esi+8]
	mov	ecx, DWORD PTR [esi+4]
	sub	edx, ecx
	dec	edx
	and	edx, 1023				; 000003ffH
	cmp	edx, 128				; 00000080H
	jae	SHORT $L726

; 171  : 		interruptible_sleep_on (&queue->proc_list);

	lea	eax, DWORD PTR [esi+12]
	push	eax
	call	_interruptible_sleep_on
	mov	ecx, DWORD PTR _current
	add	esp, 4
	mov	eax, DWORD PTR [ecx+12]
	test	eax, eax
	je	SHORT $L725
$L726:

; 172  : 	sti ();			// ���жϡ�

	sti
$L722:
	pop	esi

; 173  : }

	pop	ebp
	ret	0
_sleep_if_full ENDP
_TEXT	ENDS
PUBLIC	_do_tty_interrupt
_TEXT	SEGMENT
_tty$ = 8
_do_tty_interrupt PROC NEAR

; 502  : {

	push	ebp
	mov	ebp, esp

; 503  : 	copy_to_cooked (tty_table + tty);

	mov	ecx, DWORD PTR _tty$[ebp]
	mov	eax, ecx
	shl	eax, 5
	add	eax, ecx
	lea	eax, DWORD PTR [eax+eax*2]
	shl	eax, 5
	add	eax, OFFSET FLAT:_tty_table
	push	eax
	call	_copy_to_cooked
	add	esp, 4

; 504  : }

	pop	ebp
	ret	0
_do_tty_interrupt ENDP
_TEXT	ENDS
PUBLIC	_chr_dev_init
_TEXT	SEGMENT
_chr_dev_init PROC NEAR

; 509  : }

	ret	0
_chr_dev_init ENDP
_TEXT	ENDS
END
