//+------------------------------------------------------------------+
//| Check for New Bar                                                |
//+------------------------------------------------------------------+

class CNewBar
{
	private:
		datetime Time[], LastTime;
	
	public:
		void CNewBar();
		bool CheckNewBar(string pSymbol, ENUM_TIMEFRAMES pTimeframe);
};


void CNewBar::CNewBar(void)
{
	ArraySetAsSeries(Time,true);
}


bool CNewBar::CheckNewBar(string pSymbol,ENUM_TIMEFRAMES pTimeframe)
{
	bool firstRun = false, newBar = false;
	CopyTime(pSymbol,pTimeframe,0,2,Time);
	
	if(LastTime == 0) firstRun = true;
	
	if(Time[0] > LastTime)
	{
		if(firstRun == false) newBar = true;
		LastTime = Time[0];
	}
	
	return(newBar);
}