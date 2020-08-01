#include <Trade\SymbolInfo.mqh>
#include "utils.mqh";

CSymbolInfo _symbolInfo;

class CRangingMarket {
   protected:
      int   numCandles;
      bool  useCurrentTick;
   public:
      CRangingMarket(void);
      bool isRanging(string symbol, ENUM_TIMEFRAMES tf);
      int  getNumCandles();
      void setNumCandles(int number);
      bool getUseCurrentTick();
      void setUseCurrentTick(bool value);
};


CRangingMarket::CRangingMarket(void) {
   numCandles = 0;
   useCurrentTick = false;
};

int CRangingMarket::getNumCandles(void) {
   return numCandles;
};

void CRangingMarket::setNumCandles(int number) {
   numCandles = number;
};

bool CRangingMarket::getUseCurrentTick(void) {
   return useCurrentTick;
};

void CRangingMarket::setUseCurrentTick(bool value) {
   useCurrentTick = value;
};

bool CRangingMarket::isRanging(string symbol,ENUM_TIMEFRAMES tf) {
   int start   = (useCurrentTick ? 0 : 1);
   
   MqlRates rates[];
   ArraySetAsSeries(rates, true);
   CopyRates(_Symbol, PERIOD_CURRENT, start, numCandles, rates);
   
   double low  = lowestLow(rates, numCandles);
   double high = highestHigh(rates, numCandles);
   
   //PrintFormat("Start = %d, Length = %d", start, numCandles);
   //for(int i = 0; i < numCandles; i++) 
      //printCandle(rates[i]);
   //PrintFormat("Lowest low = %f, Highest high = %f", low, high);
   
   _symbolInfo.RefreshRates();
   double bid = _symbolInfo.Bid();
   double ask = _symbolInfo.Ask();
   PrintFormat("Low = %f, Bid = %f, Ask = %f, High = %f", low, bid, ask, high);
   if ( (low <= bid  && bid <= high) /*|| (low <= ask && ask <= high)*/ ) 
      return true;
   return false;
};
