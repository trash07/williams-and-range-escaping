#include <Trade\SymbolInfo.mqh>
#include "utils.mqh";

CSymbolInfo _symbolInfo;

class CRangingMarket {
   protected:
      int   numCandles;
      bool  useCurrentTick;
      double low;
      double high;
   public:
      CRangingMarket(void);
      bool isRanging(string symbol, ENUM_TIMEFRAMES tf);
      int  getNumCandles();
      void setNumCandles(int number);
      bool getUseCurrentTick();
      void setUseCurrentTick(bool value);
      double getLow();
      void   setLow(double l);
      double getHigh();
      void   setHigh(double h);
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

double CRangingMarket::getLow() {
   return low;
};

void   CRangingMarket::setLow(double l) {
   low = l;
};

double CRangingMarket::getHigh() {
   return high;
};

void   CRangingMarket::setHigh(double h) {
   high = h;
};

bool CRangingMarket::isRanging(string symbol,ENUM_TIMEFRAMES tf) {
   int start   = (useCurrentTick ? 0 : 1);
   
   MqlRates rates[];
   ArraySetAsSeries(rates, true);
   CopyRates(_Symbol, tf, start, numCandles, rates);
   
   double rangLow  = lowestLow(rates, numCandles);
   double rangeHigh = highestHigh(rates, numCandles);
   setLow(rangLow);
   setHigh(rangeHigh);
   
   //PrintFormat("Start = %d, Length = %d", start, numCandles);
   //for(int i = 0; i < numCandles; i++) 
      //printCandle(rates[i]);
   //PrintFormat("Lowest low = %f, Highest high = %f", low, high);
   
   _symbolInfo.RefreshRates();
   double bid = _symbolInfo.Bid();
   double ask = _symbolInfo.Ask();
   //PrintFormat("Low = %f, Bid = %f, Ask = %f, High = %f", low, bid, ask, high);
   if ( (rangLow <= bid  && bid <= rangeHigh) /*|| (rangeLow <= ask && ask <= rangeHigh)*/ ) 
      return true;
   return false;
};
