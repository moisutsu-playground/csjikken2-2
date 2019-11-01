#define EXTIO_SCAN_ASCII (*(volatile unsigned int *)0x0310)
#define EXTIO_SCAN_REQ (*(volatile unsigned int *)0x030c)
#define EXTIO_SCAN_STROKE (*(volatile unsigned int *)0x0308)

#define SCAN_STRORING (unsigned int)0xffffffff

#define EXTIO_PRINT_STROKE (*(volatile unsigned int *) 0x0300)
#define EXTIO_PRINT_ASCII  (*(volatile unsigned int *) 0x0304)

void my_print();
void my_scan();

main()
{
  unsigned int string1[32];
  unsigned int string2[32];

  string1[0] = 'H';
  string1[1] = 'E';
  string1[2] = 'L';
  string1[3] = 'L';
  string1[4] = 'O';
  string1[5] = '!';
  string1[6] = '!';
  string1[7] = '\n';
  string1[8] = '\0';

  my_print(string1);
  
  while (1) {
    string1[0] = 'S';
    string1[1] = 'T';
    string1[2] = 'R';
    string1[3] = 'I';
    string1[4] = 'N';
    string1[5] = 'G';
    string1[6] = '=';
    string1[7] = '\0';
    
    my_print(string1);
    
    my_scan(string2);
    
    string1[0] = 'E';
    string1[1] = 'C';
    string1[2] = 'H';
    string1[3] = 'O';
    string1[4] = ' ';
    string1[5] = '\0';

    my_print(string1);
    
    my_print(string2);

    string1[0] = '\n';
    string1[1] = '\0';

    my_print(string1);
  }
}

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
