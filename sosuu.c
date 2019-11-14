#define EXTIO_SCAN_ASCII (*(volatile unsigned int *)0x0310)
#define EXTIO_SCAN_REQ (*(volatile unsigned int *)0x030c)
#define EXTIO_SCAN_STROKE (*(volatile unsigned int *)0x0308)

#define SCAN_STRORING (unsigned int)0xffffffff

#define EXTIO_PRINT_STROKE (*(volatile unsigned int *) 0x0300)
#define EXTIO_PRINT_ASCII  (*(volatile unsigned int *) 0x0304)

#define TRUE 	0x1
#define FALSE	0x0

unsigned int sosuu_check(unsigned int kouho);
unsigned int my_a2i();
void my_i2a();
void my_print();
void my_scan();

main() {
  unsigned int i;
  unsigned int k;
  unsigned int str1[16];
  unsigned int str2[16];

  /* "HELLO" を print */
  str1[0] = 'H';  str1[1] = 'E';
  str1[2] = 'L';  str1[3] = 'L';
  str1[4] = 'O';  str1[5] = '\n';
  str1[6] = '\0';
  my_print(str1);

  while (1) {	
    /* "NUM=" を print */
    str1[0] = 'N';  str1[1] = 'U';
    str1[2] = 'M';  str1[3] = '=';
    str1[4] = '\0';
    my_print(str1);

    /* キーボードから入力された文字列（数字）を str2[] に記憶 */
    my_scan(str2);

    /* "ECHO " を print */
    str1[0] = 'E';	str1[1] = 'C';
    str1[2] = 'H';	str1[3] = 'O';
    str1[4] = ' ';	str1[5] = '\0';
    my_print(str1);

    /* str2[] を print */
    my_print(str2);

    /* '\n' を print */
    str1[0] = '\n';  str1[1] = '\0';
    my_print(str1);
    
    /* 文字列（数字） srt2[] を unsigned int に変換 */
    k = my_a2i(str2);
    
    for (i = 3; i <= k; i++) {
      /* 素数判定 */
      if ( sosuu_check(i) ) {  
	/* unsigned int i を文字列（数字）に変換して print */
	my_i2a(i);
      }
    }

    /* '\n' を print */
    str1[0] = '\n';  str1[1] = '\0';
    my_print(str1);
  }
}

/* unsigned int kouho の素数判定を行う関数 */
/* 素数なら TRUE を返す */
/* 素数でないなら FALSE を返す */
unsigned int sosuu_check(unsigned int kouho) {
  unsigned int t, tester, result;

  if ((kouho % 2) == 0) {
    /* kouho は偶数である == TRUE */
    return FALSE;
  } else {
    result = TRUE;
    for (tester = 3; tester < kouho/2; tester += 2) {
      /* kouho が本当に素数かどうかをチェック */
      if ((kouho % tester) == 0) {
        /* kouho は tester の倍数である */
        result = FALSE;
      }
    }
    return result;
  }
}

/* 文字列（数字） srt[] を unsigned int に変換する関数 */
/* unsigned int result を返す */
unsigned int my_a2i(str)
     unsigned int *str;
{
  unsigned int *str_tmp;
  unsigned int k;
  unsigned int result;

  str_tmp = str;
  for (k = 0; *str_tmp != '\0'; k++) {
    str_tmp++;
  }

  result = 0;
  str_tmp = str;
  
  if (k == 1) {
    result = *str_tmp - '0';
  } else if (k == 2) {
    for (k = 0; k < (*str_tmp - '0'); k++) {
      result = result + 10;
    }
    str_tmp++;
    result = result + (*str_tmp - '0');
  } else if (k == 3) {
    for (k = 0; k < (*str_tmp - '0'); k++) {
      result = result + 100;
    }
    str_tmp++;
    for (k = 0; k < (*str_tmp - '0'); k++) {
      result = result + 10;
    }
    str_tmp++;
    result = result + (*str_tmp - '0');
  }

  return result;
}

/* unsigned int i を文字列（数字）に変換して print する関数 */
void my_i2a(unsigned int i) {
  unsigned int counter;
  unsigned int s[4];

    for (counter = 0; i >= 10; counter++) {
        i -= 10;
    }
    s[0] = counter + '0';
    s[1] = i + '0';
    s[2] = ' ';
    s[3] = '\0';

    my_print(s);
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

