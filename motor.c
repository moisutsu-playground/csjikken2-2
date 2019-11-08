#define EXTIO_SCAN_ASCII (*(volatile unsigned int *)0x0310)
#define EXTIO_SCAN_REQ (*(volatile unsigned int *)0x030c)
#define EXTIO_SCAN_STROKE (*(volatile unsigned int *)0x0308)

#define SCAN_STRORING (unsigned int)0xffffffff

#define EXTIO_PRINT_STROKE (*(volatile unsigned int *) 0x0300)
#define EXTIO_PRINT_ASCII  (*(volatile unsigned int *) 0x0304)

#define TRUE    0x1
#define FALSE   0x0

#define GPIO0 (*(volatile unsigned int *) 0x0320)

void my_motor();
void my_motor_re();
void ext_out(); 
void my_scan();
void my_print();



main() {
  unsigned int command[16];
  unsigned int input_str[16];


  input_str[0] = 'N';  input_str[1] = 'E';
  input_str[2] = 'X';  input_str[3] = 'T';
  input_str[4] = '=';  input_str[5] = '\0';
  my_print(input_str);

  my_scan(command);
  if (command[0] == 'R') {
      while(TRUE){
        my_motor_re();
      }
  }

  while(TRUE){
    my_motor();
  }
} 
 
void my_motor() {
  ext_out(8); 
  ext_out(4); 
  ext_out(2); 
  ext_out(1); 
} 

void my_motor_re() {
  ext_out(1); 
  ext_out(2); 
  ext_out(4); 
  ext_out(8); 
}
 
void ext_out(unsigned int num) {
  unsigned int i;

  GPIO0 = num; 
}

/* キーボードから入力された文字列を str[] に記憶する関数 */
void my_scan(str)
     unsigned int *str;
{
    EXTIO_SCAN_STROKE = (unsigned int)0x00000000;
    EXTIO_SCAN_REQ = (unsigned int)0x00000001;
    EXTIO_SCAN_STROKE = (unsigned int)0x00000001;

    EXTIO_SCAN_STROKE = (unsigned int)0x00000000;
    EXTIO_SCAN_STROKE = (unsigned int)0x00000001;
    while (EXTIO_SCAN_ASCII == SCAN_STRORING) {
      EXTIO_SCAN_STROKE = (unsigned int)0x00000000;
      EXTIO_SCAN_STROKE = (unsigned int)0x00000001;
    }

    while ((*str = EXTIO_SCAN_ASCII) != (unsigned int)0x3e) {    // 0x3e=RETURN
      if ((*str >= 1) && (*str <= 26)) {
	*str = 'A' + *str - 1;
      } else if ((*str >= 48) && (*str <= 57)) {
	*str = '0' + *str - 48;
      } else {
	if (*str == 0) {
	  *str = '@';
	} else if (*str == 27) {
	  *str = '[';
	} else if (*str == 29) {
	  *str = ']';
	} else if ((*str >= 32) && (*str <= 47)) {
	  *str = ' ' + *str - 32;
	} else if (*str == 58) {
	  *str = '?';
	} else if (*str == 59) {
	  *str = '=';
	} else if (*str == 60) {
	  *str = ';';
	} else if (*str == 61) {
	  *str = ':';
	} else if (*str == 62) {
	  *str = '\n';
	} else {
	  *str = '@';
	}
      }
      EXTIO_SCAN_STROKE = (unsigned int)0x00000000;
      EXTIO_SCAN_STROKE = (unsigned int)0x00000001;
      str++;
    }
    *str = '\0';

    EXTIO_SCAN_STROKE = (unsigned int)0x00000000;
    EXTIO_SCAN_REQ = (unsigned int)0x00000000;
    EXTIO_SCAN_STROKE = (unsigned int)0x00000001;

    EXTIO_SCAN_STROKE = (unsigned int)0x00000000;
}

/* 文字列 str[] を表示する関数 */
void my_print(str)
     unsigned int *str;
{
  while (*str != '\0') {
    EXTIO_PRINT_STROKE = (unsigned int)0x00000000;

    if ((*str >= 'A') && (*str <= 'Z')) {
      EXTIO_PRINT_ASCII = *str - 'A' + 1;
    } else if ((*str >= 'a') && (*str <= 'z')) {
      EXTIO_PRINT_ASCII = *str - 'a' + 1;
    } else if ((*str >= '0') && (*str <= '9')) {
      EXTIO_PRINT_ASCII = *str - '0' + 48;
    } else {
      if (*str == '@') {
        EXTIO_PRINT_ASCII = (unsigned int)0;
      } else if (*str == '[') {
        EXTIO_PRINT_ASCII = (unsigned int)27;
      } else if (*str == ']') {
        EXTIO_PRINT_ASCII = (unsigned int)29;
      } else if ((*str >= ' ') && (*str <= '/')) {
        EXTIO_PRINT_ASCII = *str - ' ' + 32;
      } else if (*str == '?') {
        EXTIO_PRINT_ASCII = (unsigned int)58;
      } else if (*str == '=') {
        EXTIO_PRINT_ASCII = (unsigned int)59;
      } else if (*str == ';') {
        EXTIO_PRINT_ASCII = (unsigned int)60;
      } else if (*str == ':') {
        EXTIO_PRINT_ASCII = (unsigned int)61;
      } else if (*str == '\n') {
	EXTIO_PRINT_ASCII = (unsigned int)62;
      } else {
        EXTIO_PRINT_ASCII = (unsigned int)0x00000000;
      }
    }
   
    EXTIO_PRINT_STROKE = (unsigned int)0x00000001;
    str++;
  }
}