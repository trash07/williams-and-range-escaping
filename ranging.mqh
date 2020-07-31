#include <Indicators\TimeSeries.mqh>

class CRangingMarket {
   protected:
      int   numCandles          = 0;
      bool  useCurrentTick = false;
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
   numCandles = value;
};

bool CRangingMarket::getUseCurrentTick(void) {
   return useCurrentTick;
};

void CRangingMarket::setUseCurrentTick(bool value) {
   useCurrentTick = value;
};

bool CRangingMarket::isRanging(string symbol,ENUM_TIMEFRAMES tf) {
   CiLow cLows;
   CiHigh cHighs;
   double lows[], highs[];
   int start   = (useCurrentTick ? 0 : 1);
   
   lows.GetData(start, numCandles, lows);
   highs.GetData(start, numCandles, highs);
   
   return true;
};
