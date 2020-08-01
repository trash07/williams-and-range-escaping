//+------------------------------------------------------------------+
//|                                  williams-and-range-escaping.mq5 |
//|                                                    Lonv'ha KPETO |
//|                                       https://ultron-systems.com |
//+------------------------------------------------------------------+
#include <Trade\Trade.mqh>
#include "ranging.mqh";
#include "utils.mqh";
#include "timer.mqh";

input int rangeSize     = 5;
input int willamsPeriod = 14;

CTrade _trade;
CRangingMarket _ranging;
CNewBar        _bar;
int            williamsHandle;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {
   _ranging.setNumCandles(rangeSize);
   _ranging.setUseCurrentTick(false);
   williamsHandle = iWPR(_Symbol, PERIOD_CURRENT, willamsPeriod);
   if (williamsHandle == INVALID_HANDLE) {
      PrintFormat("Error when initilizing Williams %R indicator");
      return (INIT_FAILED);
   }
   return(INIT_SUCCEEDED);
}


//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick(){
   //scalp_profits();
   
   //if ( !_ranging.isRanging(_Symbol, PERIOD_CURRENT) ) {
      //PrintFormat("Market is trending");
      double williams = lastBarWilliams(williamsHandle, false);
      //PrintFormat("Williams => %f", williams);
      if (MathAbs(williams) < 50) {
         if (PositionsTotal() == 0
          && !_ranging.isRanging(_Symbol, PERIOD_H1)
          && !_ranging.isRanging(_Symbol, PERIOD_M5)
          && !_ranging.isRanging(_Symbol, PERIOD_M1)
          && !_ranging.isRanging(_Symbol, PERIOD_CURRENT)
          ) {
            double sl = _ranging.getLow();
            _trade.Buy(0.001, _Symbol, 0.0, sl, LongTakeProfit(sl, 0.5));
         }   
      }
      if (MathAbs(williams) > 50) {
         if (PositionsTotal() == 0
            && !_ranging.isRanging(_Symbol, PERIOD_H1)
            && !_ranging.isRanging(_Symbol, PERIOD_M5)
            && !_ranging.isRanging(_Symbol, PERIOD_M1)
            && !_ranging.isRanging(_Symbol, PERIOD_CURRENT)
         ) {
            double sl = _ranging.getHigh();
            _trade.Sell(0.001, _Symbol, 0.0, sl, ShortTakeProfit(sl, 0.5));
         }
      }
   //}
}
//+------------------------------------------------------------------+
