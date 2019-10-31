#define EXTIO_PRINT_STROKE (*(volatile unsigned int *) 0x0300)
#define EXTIO_PRINT_ASCII  (*(volatile unsigned int *) 0x0304)
main()
{
  unsigned int k;
  for (k = 0; k <= 60; k++) {
    EXTIO_PRINT_STROKE = (unsigned int)0x00000000;
    EXTIO_PRINT_ASCII = k;
    EXTIO_PRINT_STROKE = (unsigned int)0x00000001;
  }
}
