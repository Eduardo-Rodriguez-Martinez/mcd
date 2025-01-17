TITLE Máximo Común Divisor de dos números enteros    (mcd.asm)
.386
.model flat, stdcall
.stack 100h

ExitProcess PROTO, dwExitCode:DWORD

.data
    resultado dd 0; variable que almacena el resultado del MCD
.code

main proc
    invoke mcd, 12, 18, ADDR resultado
    invoke ExitProcess, 0
main endp

mcd proc
; x = abs(x)
    mov eax, [esp + 4]; Carga el primer argumento en eax
    cmp eax, 0; Verifica si x es negativo
    jge L1; Salta si x es positivo
    not eax; Inicia el complemento a dos
    inc eax
; y = abs(y)
L1: mov ebx, [esp + 8]; Carga el segundo argumento en ebx
    cmp ebx, 0; Verifica si y es negativo
    jge L2; Salta si y es positivo
    not ebx; Inicia el complemento a dos
    inc ebx
;do {
; int n = x%y;
; x = y;
; y = n;
; } while (y > 0);
L2: xor edx, edx; Inicializa el registro dx
    div ebx; Divide eax por ebx
    mov eax, ebx; Carga el valor de ebx en eax
    mov ebx, edx; Carga el valor de edx en ebx
    cmp ebx, 0; Compara y con 0
    jnz L2
    mov si, [esp + 12]; Carga el tercer argumento en si
    mov [si], eax; Almacena el resultado en la dirección apuntada por el tercer argumento
    ret 
mcd endp

end main