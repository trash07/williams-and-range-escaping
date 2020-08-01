//+------------------------------------------------------------------+
//|                                  williams-and-range-escaping.mq5 |
//|                                                    Lonv'ha KPETO |
//|                                       https://ultron-systems.com |
//+------------------------------------------------------------------+
#include "ranging.mqh";
#include "utils.mqh";
#include "timer.mqh";

input int rangeSize  = 5;


CRangingMarket _ranging;
CNewBar        _bar;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {
   _ranging.setNumCandles(rangeSize);
   _ranging.setUseCurrentTick(false);
   return(INIT_SUCCEEDED);
}


//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick(){
   if (_ranging.isRanging(_Symbol, PERIOD_CURRENT)) {
      PrintFormat("Market is ranging");
   } else {
      PrintFormat("Market is trending");
   }
}
//+------------------------------------------------------------------+
