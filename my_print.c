#define EXTIO_PRINT_STROKE (*(volatile unsigned int *) 0x0300)
#define EXTIO_PRINT_ASCII  (*(volatile unsigned int *) 0x0304)

void my_print();

main()
{
  unsigned int string[64];

  string[0] = 'H';
  string[1] = 'E';
  string[2] = 'L';
  string[3] = 'L';
  string[4] = 'O';
  string[5] = '!';
  string[6] = '!';
  string[7] = '\0';
  
  my_print(string);

  string[0] = 'B';
  string[1] = '\0';
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
