#include <reg51.h>

sbit BUZZ =P1^7;

int IIR_BPF(float *, int);
int input;

void serial0() interrupt 1 
{
	if (RI==1)
	{
		input = SBUF;
		RI=0;
	}
	else
	{
		TI=0;
	}
}

void main(void)
{
	float filter[3] = {0};
	int delay_count = 100;
	int filtered_signal = 0;
	float analog_signal;
	BUZZ = 0;
	TMOD = 0x21;
	TH1 = 0xF6;
	TH0 = 0x3C;
	TL0 = 0xAF;
	SCON = 0x50;
	IE = 0x90;
	TR1 = 1;
	while(1)
	{
		filtered_signal = IIR_BPF(filter, input);
		if (filtered_signal >= 0)
		{
			analog_signal = filtered_signal/127;
		}
		else
		{
			analog_signal = -filtered_signal/128;
		}
		if (analog_signal > 0.25)
		{
			if (TF0 == 1)
			{
				if (delay_count == 0)
				{
					BUZZ = 0;
					TR0 = 0;
					TF0 = 0;
					TH0 = 0x3C;
					TL0 = 0xAF;
					delay_count = 100;
				}
				else
				{
					TR0 = 0;
					TF0 = 0;
					TH0 = 0x3C;
					TL0 = 0xAF;
					delay_count--;
					TR0 = 1;
				}
			}
			else
			{
				BUZZ = 1;
				TR0 = 1;
			}
		}
		else
		{
			if (TR0 == 1)
			{
				if (TF0 == 1)
				{
					if (delay_count == 0)
					{
						BUZZ = 0;
						TR0 = 0;
						TF0 = 0;
						TH0 = 0x3C;
						TL0 = 0xAF;
						delay_count = 100;
					}
					else
					{
						TR0 = 0;
						TF0 = 0;
						TH0 = 0x3C;
						TL0 = 0xAF;
						delay_count--;
						TR0 = 1;
					}
				}
			}
			else
			{
				BUZZ = 0;
			}
		}
	}
}

int IIR_BPF(float *filter, int input)
{
	float filterout = 0;
	filter[2] = filter[1];
	filter[1] = filter[0];
	filter[0] = input + 1.912443*filter[1] - 0.986996*filter[2];
	filterout = 0.006502*filter[0] - 0.006502*filter[2];
	return (int)(filterout);
}